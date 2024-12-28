use std::ops;

use bevy::{
    prelude::*,
    render::{renderer::RenderDevice, RenderApp},
};
use bevy_egui::{egui, EguiContexts};
use event::RdogEvent;
use state::SyncedState;

use crate::Config;

pub mod camera;
pub mod event;
pub mod graph;
pub mod rendering;
pub mod stages;
pub mod state;

pub struct RdogPlugin(pub u32);

impl Plugin for RdogPlugin {
    fn build(&self, app: &mut App) {
        app.add_event::<RdogEvent>();
        app.insert_resource(Config::default());
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

fn ui_system(mut ui_state: ResMut<Config>, mut contexts: EguiContexts) {
    let ctx = contexts.ctx_mut();
    // println!("state direct: {}", ui_state.direct_pass);
    egui::Window::new("Window")
        .vscroll(true)
        .default_open(true)
        .show(ctx, |ui| {
            ui.heading("Config Panel");
            ui.separator();
            ui.heading("Passes");
            ui.checkbox(&mut ui_state.direct_pass, "Direct+Indirect Lighting");
            ui.checkbox(&mut ui_state.scatter_pass, "Scatter Lighting");
            ui.checkbox(&mut ui_state.specular_pass, "Specular Lighting");
        });
}
