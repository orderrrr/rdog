use std::ops;

use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, RenderApp},
};
use event::RdogEvent;
use state::SyncedState;

pub mod camera;
pub mod event;
pub mod graph;
pub mod rendering;
pub mod stages;
pub mod state;

pub struct RdogPlugin;

impl Plugin for RdogPlugin {
    fn build(&self, app: &mut App) {
        app.add_event::<RdogEvent>();
        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app.insert_resource(SyncedState::default());

            stages::setup(render_app);
            graph::setup(render_app);
        }
    }

    fn finish(&self, app: &mut App) {
        let Some(render_app) = app.get_sub_app_mut(RenderApp) else {
            return;
        };

        let render_device = render_app.world().resource::<RenderDevice>();
        let engine = crate::Engine::new(render_device.wgpu_device());

        render_app.insert_resource(EngineResource(engine));
    }
}

#[derive(Resource)]
pub struct EngineResource(crate::Engine);

impl ops::Deref for EngineResource {
    type Target = crate::Engine;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl ops::DerefMut for EngineResource {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}
