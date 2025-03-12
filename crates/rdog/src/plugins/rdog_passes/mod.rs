pub mod event;

use crate::{
    passes::{PassConstructor, PassRegistry, Passes},
    rdog_buffers::create_buffer,
    CameraHandle,
};
use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, Render, RenderApp},
    utils::HashMap,
};

use super::{
    event::RdogEvent, rdog_buffers::RdogBufferResource, state::SyncedState, EngineResource,
};

pub struct PassesPlugin;

impl Plugin for PassesPlugin {
    fn build(&self, app: &mut App) {
        info!("Rdog pass plugin init");

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app.insert_resource(RdogPassResource::default());
            render_app.insert_resource(RdogPassRegistry::default());
            render_app.add_systems(Render, setup_passes.after(create_buffer));
        }
    }
}

#[derive(Resource, TypePath, Default, Debug, DerefMut, Deref)]
pub struct RdogPassResource(HashMap<CameraHandle, Passes>);

#[derive(Resource, TypePath, Default, Debug, DerefMut, Deref)]
pub struct RdogPassRegistry(PassRegistry);

impl RdogPassRegistry {
    pub fn new(
        constructor: Vec<Box<dyn PassConstructor>>,
        pass_order: Vec<String>,
    ) -> RdogPassRegistry {
        RdogPassRegistry(PassRegistry::new(constructor, pass_order))
    }
}

pub fn setup_passes(
    registry: Res<RdogPassRegistry>,
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
                for handle in state.cameras.values() {
                    info!("create passes");
                    passes.insert(
                        handle.handle,
                        Passes::from_registry(
                            &registry,
                            &engine,
                            &device.wgpu_device(),
                            &engine.cameras.get(handle.handle).camera,
                            &buffers.get(&handle.handle).unwrap(),
                        ),
                    );
                }
            }
            _ => (),
        }
    }
}
