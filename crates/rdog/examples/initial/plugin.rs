use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp},
};
use rdog::{
    event::RdogEvent,
    rdog_buffers::{create_buffer, RdogBufferResource},
    rdog_passes::{setup_passes, RdogPassRegistry},
    renderer::buffers::{Buffers, BT},
    state::SyncedState,
    texture::Texture,
    Engine, EngineResource,
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
                    bufs(&engine, device.wgpu_device(), buffers);
                }
            }
            _ => (),
        }
    }
}

fn bufs(engine: &Engine, device: &Device, buffers: &mut Buffers) {
    let cam = engine.cameras.get_first();

    buffers.insert(
        "render_tx_new".to_string(),
        BT::from(
            Texture::builder("render_tx_new")
                .with_size(cam.camera.scale(&engine.config))
                .with_format(wgpu::TextureFormat::Rgba32Float)
                .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
                .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
                .with_linear_filtering_sampler()
                .build(device),
        ),
    );
}
