use pipelines::OutputTracePassConstructor;
use rdog::{
    bufferable::Bufferable,
    event::RdogEvent,
    map_write_buffer::MapWriteBuffer,
    mapped_uniform_buffer::MappedUniformBuffer,
    rdog_buffers::{create_buffer, RdogBufferResource},
    rdog_passes::{setup_passes, RdogPassRegistry},
    renderer::{
        buffers::{Buffers, BT},
        config::Camera,
    },
    state::{ExtractedConfig, SyncedState},
    storage_buffer::StorageBuffer,
    texture::Texture,
    Config, Engine, EngineResource, Globals,
};
use wgpu::Device;

use crate::pipelines::{
    DiffPassConstructor, RasterPassConstructor, ReadbackPassConstructor, TracePassConstructor,
};
use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp},
    window::{PresentMode, WindowResolution},
};

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
            render_app
                .insert_resource(RdogPassRegistry::new(
                    vec![
                        Box::new(DiffPassConstructor),
                        Box::new(ReadbackPassConstructor),
                        Box::new(TracePassConstructor),
                        Box::new(RasterPassConstructor),
                        Box::new(OutputTracePassConstructor),
                    ],
                    vec![String::from("diff"), String::from("trace"), String::from("raster")],
                ))
                .add_systems(
                    Render,
                    buffer_events.after(create_buffer).before(setup_passes), // TODO: better way to do this ordering
                );
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
                    let buffers = buffers.get_mut(&handle.handle).unwrap();
                    bufs(
                        &engine,
                        device.wgpu_device(),
                        buffers,
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
        update(
            &engine,
            device.wgpu_device(),
            buffers,
            &engine.cameras.get(handle.handle).camera,
            &config,
        );
    }
}

fn update(
    engine: &Engine,
    _device: &Device,
    buffers: &mut Buffers,
    camera: &Camera,
    config: &Config,
) {
    buffers.update("curr_camera", camera.serialize(&config).data().into());
    buffers.update("out_camera", camera.serialize_out(&config).data().into());
    buffers.update(
        "globals",
        Globals::from_engine(engine, &camera)
            .serialize()
            .data()
            .into(),
    );
    buffers.update("config", config.to_pass_params().data().into());
    buffers.update("out_config", config.to_pass_params_out().data().into());
    buffers.update("march_readback", Vec4::ZERO.data().into());

    buffers.update("materials", config.material_pass().data().into());
    buffers.update("lights", config.light_pass().data().into());
}

fn bufs(engine: &Engine, device: &Device, buffers: &mut Buffers, camera: &Camera, config: &Config) {
    debug!("Initializing camera buffers");

    buffers.insert(
        "curr_camera".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "camera",
            camera.serialize(config).data().to_vec(),
        )),
    );
    buffers.insert(
        "out_camera".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "camera",
            camera.serialize_out(config).data().to_vec(),
        )),
    );
    buffers.insert(
        "globals".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "globals",
            Globals::from_engine(engine, camera)
                .serialize()
                .data()
                .to_vec(),
        )),
    );
    buffers.insert(
        "render_tx".to_string(),
        BT::from(
            Texture::builder("render")
                .with_size(camera.scale(&config))
                .with_format(wgpu::TextureFormat::Rgba32Float)
                .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
                .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
                .with_nearest_filtering_sampler()
                .build(device),
        ),
    );
    buffers.insert(
        "render_readback".to_string(),
        BT::from(
            Texture::builder("render_readback")
                .with_size(config.output_res)
                .with_format(wgpu::TextureFormat::Rgba32Float)
                .with_usage(wgpu::TextureUsages::COPY_SRC)
                .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
                .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
                .with_nearest_filtering_sampler()
                .build(device),
        ),
    );
    buffers.insert(
        "config".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "config",
            config.to_pass_params().data().to_vec(),
        )),
    );
    buffers.insert(
        "out_config".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "config",
            config.to_pass_params_out().data().to_vec(),
        )),
    );
    buffers.insert(
        "materials".to_string(),
        BT::from(StorageBuffer::new(
            device,
            "materials",
            config.material_pass().data().to_vec(),
        )),
    );
    buffers.insert(
        "lights".to_string(),
        BT::from(StorageBuffer::new(
            device,
            "lights",
            config.light_pass().data().to_vec(),
        )),
    );
    buffers.insert(
        "voxel".to_string(),
        BT::from(
            Texture::builder("voxel")
                .with_size_3d(UVec3::splat(config.voxel_dim))
                .with_format(wgpu::TextureFormat::Rgba32Float)
                .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
                .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
                .with_linear_filtering_sampler()
                .build(device),
        ),
    );
    buffers.insert(
        "march_readback".to_string(),
        BT::from(MapWriteBuffer::new(
            device,
            "march_readback",
            Vec4::ZERO.data().to_vec(),
        )),
    );
}
