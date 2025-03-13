use super::DebugConfig;
use crate::{event::RdogEvent, Config};
use bevy::prelude::*;
use bevy_egui::{
    egui::{self, CursorIcon, Id, Pos2},
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
pub use render::*;
use strum::IntoEnumIterator;
pub use system::*;
pub use util::*;

pub const ID: Id = Id::NULL;

pub fn ui_system(
    mut event_writer: EventWriter<RdogEvent>,
    mut ui_state: ResMut<Config>,
    mut debug_state: ResMut<DebugConfig>,
    mut contexts: EguiContexts,
) {
    ui_state.reload = false;

    let ctx = contexts.ctx_mut();

    // Get previous state
    let prev_state = ctx.data_mut(|d| {
        d.get_persisted::<Config>(ID)
            .unwrap_or_else(|| ui_state.clone())
    });

    debug_state.pointer_in_egui = ctx.is_pointer_over_area();

    if !debug_state.pointer_in_egui && debug_state.point_picker {
        ctx.set_cursor_icon(CursorIcon::Crosshair);
    }

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

            debug_state
                .selected_tab
                .clone()
                .render(ui, &mut ui_state, &mut debug_state);
        });

    let changes = ui_state.track_changes(&prev_state);

    if !changes.is_empty() {
        info!("update");

        for (field, change_desc) in &changes {
            info!("field changed: {} | {}", field, change_desc);

            match field.as_str() {
                "res" => {
                    event_writer.send(RdogEvent::Recompute);
                }
                "material_tree" => {
                    if ui_state.material_tree.mats.len() != prev_state.material_tree.mats.len() {
                        event_writer.send(RdogEvent::Recompute);
                    } else {
                        event_writer.send(RdogEvent::UpdateBuffers);
                    }
                }
                "light_tree" => {
                    if ui_state.light_tree.lights.len() != prev_state.light_tree.lights.len() {
                        event_writer.send(RdogEvent::Recompute);
                    } else {
                        event_writer.send(RdogEvent::UpdateBuffers);
                    }
                }
                _ => (),
            };
        }
    }

    ui_state.multi_frame =
        !(!changes.is_empty() || ui_state.user_orbit || !ui_state.multi_frame_override);

    ctx.data_mut(|d| d.insert_persisted(ID, ui_state.clone()));
}
