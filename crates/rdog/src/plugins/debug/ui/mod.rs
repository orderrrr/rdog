use super::DebugConfig;
use crate::Config;
use bevy::prelude::*;
use bevy_egui::{
    egui::{self, Pos2},
    EguiContexts,
};

pub mod lights;
pub mod materials;
pub mod objects;
pub mod render;
pub mod system;
pub mod util;

pub use lights::*;
pub use materials::*;
// pub use objects::*;
pub use render::*;
use strum::IntoEnumIterator;
pub use system::*;
pub use util::*;

pub fn ui_system(
    mut ui_state: ResMut<Config>,
    mut debug_state: ResMut<DebugConfig>,
    mut contexts: EguiContexts,
) {
    ui_state.reload = false;
    let mut c = false;

    let ctx = contexts.ctx_mut();

    debug_state.pointer_in_egui = ctx.is_pointer_over_area();

    egui::Window::new("Config")
        .vscroll(true)
        .default_open(false)
        .default_pos(Pos2::new(10.0, 10.0))
        .current_pos(Pos2::new(10.0, 10.0))
        .show(ctx, |ui| {
            ui.horizontal(|ui| {
                SelectedTab::iter().for_each(|i| {
                    ui.selectable_value(&mut debug_state.selected_tab, i.clone(), i.name());
                });
            });

            debug_state.selected_tab.render(ui, &mut ui_state, &mut c);
        });

    ui_state.multi_frame = !(c || ui_state.user_orbit || !ui_state.multi_frame_override);
}
