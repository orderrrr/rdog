use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp},
};
use glam::uvec3;
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
    state::SyncedState,
    storage_buffer::StorageBuffer,
    texture::Texture,
    Engine, EngineResource, Globals,
};
use wgpu::Device;

use crate::pipelines::{
    RasterPassConstructor, ReadbackPassConstructor, TracePassConstructor, VoxelAccelPassConstructor,
};

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
                        Box::new(VoxelAccelPassConstructor),
                        Box::new(ReadbackPassConstructor),
                        Box::new(TracePassConstructor),
                        Box::new(RasterPassConstructor),
                    ],
                    vec![
                        String::from("voxelAccel"),
                        String::from("trace"),
                        String::from("raster"),
                    ],
                ))
                .add_systems(
                    Render,
                    init_buffers.after(create_buffer).before(setup_passes), // TODO: better way to do this ordering
                );
        }
    }
}

fn init_buffers(
    engine: Res<EngineResource>,
    mut events: EventReader<RdogEvent>,
    state: Res<SyncedState>,
    mut buffers: ResMut<RdogBufferResource>,
    device: Res<RenderDevice>,
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
                    );
                }
            }
            _ => (),
        }
    }
}

fn update(engine: &Engine, device: &Device, buffers: &mut Buffers, camera: &Camera) {}

fn bufs(engine: &Engine, device: &Device, buffers: &mut Buffers, camera: &Camera) {
    debug!("Initializing camera buffers");

    buffers.insert(
        "curr_camera".to_string(),
        BT::from(MappedUniformBuffer::new(
            device,
            "camera",
            camera.serialize(&engine.config).data().to_vec(),
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
                .with_size(camera.scale(&engine.config))
                .with_format(wgpu::TextureFormat::Rgba32Float)
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
            engine.config.to_pass_params().data().to_vec(),
        )),
    );
    buffers.insert(
        "materials".to_string(),
        BT::from(StorageBuffer::new(
            device,
            "materials",
            engine.config.material_pass().data().to_vec(),
        )),
    );
    buffers.insert(
        "lights".to_string(),
        BT::from(StorageBuffer::new(
            device,
            "lights",
            engine.config.light_pass().data().to_vec(),
        )),
    );
    buffers.insert(
        "voxels".to_string(),
        BT::from(
            Texture::builder("voxels")
                .with_size_3d(uvec3(
                    engine.config.voxel_dim,
                    engine.config.voxel_dim,
                    engine.config.voxel_dim,
                ))
                .with_format(wgpu::TextureFormat::Rgba16Float) // TODO - pack 8 here instead of a single voxel
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
