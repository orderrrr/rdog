use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp, RenderSet},
    window::{PresentMode, WindowResolution},
};
use pipelines::{AccumPass, DiffPass, DiffRasterPass, OutputTracePass, RasterPass, ReadbackPass};
use rdog::{
    buffer_builder::BufferBuilder,
    event::RdogEvent,
    passes::{PassConstruct, Passes},
    rdog::passes::RdogPassResource,
    renderer::{buffers::Buffers, config::Camera},
    shader::RdogShaderState,
    state::{ExtractedConfig, SyncedState},
    texture::Texture,
    Config, Engine, EngineResource, Globals, RdogBufferResource,
};
use wgpu::Device;

use bevy_egui::EguiPlugin;
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState},
    DebugConfig, RdogDebugPlugin, RdogPlugin,
};

pub mod pipelines;

pub const W: u32 = 640;
pub const H: u32 = 480;

fn main() {
    App::new()
        .insert_resource(DebugConfig::default())
        .add_plugins((
            DefaultPlugins
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        name: Some("rdog".to_string()),
                        resolution: WindowResolution::new(W as f32, H as f32),
                        present_mode: PresentMode::AutoNoVsync,
                        ..default()
                    }),
                    ..default()
                })
                .set(AssetPlugin {
                    watch_for_changes_override: Some(true),
                    ..default()
                }),
            RdogPlugin(rand::thread_rng().gen_range(0..4_294_967_295)),
            InitialPlugin,
            RdogDebugPlugin,
            EguiPlugin,
        ))
        .add_systems(
            Update,
            pan_orbit_camera.run_if(any_with_component::<PanOrbitState>),
        )
        .run();
}

// TODO: put this in the app and make it so we just pass the init_buffers function
pub struct InitialPlugin;

impl Plugin for InitialPlugin {
    fn build(&self, app: &mut App) {
        info!("Initial demo init");

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            /*
             * Pipeline Registry Plugin for registering plugins from app world.
             * TODO: need a way to specify an order, or better yet a graph for this.
             */
            render_app.add_systems(
                Render,
                (buffer_events, setup_passes)
                    .chain()
                    .in_set(RenderSet::Prepare)
                    .run_if(in_state(RdogShaderState::Finished)),
            );
        }
    }
}

pub fn setup_passes(
    buffers: Res<RdogBufferResource>,
    mut events: EventReader<RdogEvent>,
    mut passes: ResMut<RdogPassResource>,
    engine: Res<EngineResource>,
    state: Res<SyncedState>,
    device: Res<RenderDevice>,
) {
    for e in events.read() {
        match e {
            RdogEvent::Recompute | RdogEvent::RecomputePasses => {
                info!("need to create passes");

                let device = device.wgpu_device();

                for handle in state.cameras.values() {
                    info!("create passes");
                    let cam = &engine.cameras.get(handle.handle).camera;
                    let buf = &buffers.get(&handle.handle).unwrap();

                    let mut p = Passes::new();

                    let dif = DiffPass::new(&engine, &device, cam, &buf);
                    let readback = ReadbackPass::new(&engine, &device, cam, &buf);
                    let draster = DiffRasterPass::new(&engine, &device, cam, &buf);
                    let raster = RasterPass::new(&engine, &device, cam, &buf);
                    let accum = AccumPass::new(&engine, &device, cam, &buf);
                    let output = OutputTracePass::new(&engine, &device, cam, &buf);

                    p.set_pass_order(vec![&dif, &draster, &accum, &raster]);
                    p.insert_all(vec![dif, readback, draster, accum, raster, output]);

                    passes.insert(handle.handle, p);
                }

                info!("finished creating");
            }
            _ => (),
        }
    }
}

fn buffer_events(
    engine: Res<EngineResource>,
    mut events: EventReader<RdogEvent>,
    state: Res<SyncedState>,
    mut buffers: ResMut<RdogBufferResource>,
    device: Res<RenderDevice>,
    config: Res<ExtractedConfig>,
) {
    for e in events.read() {
        match e {
            RdogEvent::Recompute | RdogEvent::RecomputeBuffers => {
                info!("need to init buffer");
                for handle in state.cameras.values() {
                    info!("init_buffers");
                    buffers.insert(handle.handle, Buffers::new());

                    let mut buffers = buffers.get_mut(&handle.handle).unwrap();

                    bufs(
                        &engine,
                        device.wgpu_device(),
                        &mut buffers,
                        &engine.cameras.get(handle.handle).camera,
                        &config,
                    );
                }
            }
            _ => (),
        }
    }

    for handle in state.cameras.values() {
        let buffers = buffers.get_mut(&handle.handle).unwrap();
        update_buffers(
            &engine,
            device.wgpu_device(),
            buffers,
            &engine.cameras.get(handle.handle).camera,
            &config,
        );
    }
}

fn update_buffers(
    engine: &Engine,
    _device: &Device,
    buffers: &mut Buffers,
    camera: &Camera,
    config: &Config,
) {
    buffers.update("curr_camera", camera.serialize(&config));
    buffers.update("out_camera", camera.serialize_out(&config));
    buffers.update("globals", Globals::from_engine(engine, &camera).serialize());
    buffers.update("config", config.to_pass_params());
    buffers.update("out_config", config.to_pass_params_out());
    buffers.update("march_readback", Vec4::ZERO);
    buffers.update("materials", config.material_pass());
    buffers.update("lights", config.light_pass());
}

fn bufs(engine: &Engine, device: &Device, buffers: &mut Buffers, camera: &Camera, config: &Config) {
    debug!("Initializing camera buffers");

    buffers.add(
        BufferBuilder::new("curr_camera")
            .with_data(camera.serialize(config))
            .build_uniform(device),
    );
    buffers.add(
        BufferBuilder::new("out_camera")
            .with_data(camera.serialize_out(config))
            .build_uniform(device),
    );
    buffers.add(
        BufferBuilder::new("globals")
            .with_data(Globals::from_engine(engine, camera).serialize())
            .build_uniform(device),
    );
    buffers.add(
        Texture::builder("render_tx")
            .with_size(camera.scale(&config))
            .with_format(wgpu::TextureFormat::Rgba16Float)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_usage(wgpu::TextureUsages::RENDER_ATTACHMENT)
            .with_linear_filtering_sampler()
            .build(device),
    );
    buffers.add(
        Texture::builder("accum_render")
            .with_size(camera.scale(&config))
            .with_format(wgpu::TextureFormat::Rgba16Float)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_nearest_filtering_sampler()
            .build(device),
    );
    buffers.add(
        Texture::builder("render_readback")
            .with_size(config.output_res)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::COPY_SRC)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_nearest_filtering_sampler()
            .build(device),
    );
    buffers.add(
        BufferBuilder::new("config")
            .with_data(config.to_pass_params())
            .build_uniform(device),
    );
    buffers.add(
        BufferBuilder::new("out_config")
            .with_data(config.to_pass_params_out())
            .build_uniform(device),
    );
    buffers.add(
        BufferBuilder::new("materials")
            .with_data(config.material_pass())
            .build_storage(device),
    );
    buffers.add(
        BufferBuilder::new("lights")
            .with_data(config.light_pass())
            .build_storage(device),
    );
    buffers.add(
        Texture::builder("voxel")
            .with_size_3d(UVec3::splat(config.voxel_dim))
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device),
    );
    buffers.add(
        BufferBuilder::new("march_readback")
            .with_usage(
                wgpu::BufferUsages::COPY_SRC
                    | wgpu::BufferUsages::COPY_DST
                    | wgpu::BufferUsages::STORAGE,
            )
            .with_data(Vec4::ZERO)
            .build_storage(device),
    );
}
