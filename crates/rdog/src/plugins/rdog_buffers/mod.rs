use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp},
    utils::HashMap,
};

use crate::{renderer::buffers::Buffers, stages::prepare::cameras, CameraHandle, EngineResource};

use super::{event::RdogEvent, state::SyncedState};

pub struct BufferPlugin;

impl Plugin for BufferPlugin {
    fn build(&self, app: &mut App) {
        info!("Rdog buffer plugin init");

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app
                .insert_resource(RdogBufferResource(HashMap::new()))
                .add_systems(Render, create_buffer.after(cameras));
        }
    }
}

#[derive(Resource, TypePath, Default, Debug, Deref, DerefMut)]
pub struct RdogBufferResource(HashMap<CameraHandle, Buffers>);

pub fn create_buffer(
    mut buffers: ResMut<RdogBufferResource>,
    mut events: EventReader<RdogEvent>,
    engine: Res<EngineResource>,
    state: Res<SyncedState>,
    device: Res<RenderDevice>,
) {
    for e in events.read() {
        match e {
            RdogEvent::Recompute | RdogEvent::RecomputeBuffers => {
                info!("need to create buffer");
                for handle in state.cameras.values() {
                    info!("created buffer");
                    buffers.insert(
                        handle.handle,
                        Buffers::new(
                            &engine,
                            device.wgpu_device(),
                            &engine.cameras.get(handle.handle).camera,
                        ),
                    );
                }
            }
            _ => (),
        }
    }
}
