use std::ops;

use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, RenderApp},
};
use event::RdogEvent;
use shader::{RdogShaderAsset, RdogShaderAssetLoader};
use state::SyncedState;
use ui::ui_system;

use crate::Config;

pub mod camera;
pub mod event;
pub mod graph;
pub mod rendering;
pub mod shader;
pub mod stages;
pub mod state;
pub mod ui;

pub struct RdogPlugin(pub u32);

impl Plugin for RdogPlugin {
    fn build(&self, app: &mut App) {
        app.add_event::<RdogEvent>()
            .insert_resource(Config::default())
            .init_asset::<RdogShaderAsset>()
            .init_asset_loader::<RdogShaderAssetLoader>();

        app.add_systems(Update, ui_system);
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
        let engine = crate::Engine::new(render_device.wgpu_device(), self.0);

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
