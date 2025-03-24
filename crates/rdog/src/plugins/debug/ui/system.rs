use std::{fs, ops::Deref};

use bevy_egui::egui::{self, Ui};

use crate::{plugin_config::read_config, Config};

pub fn system_tab(ui: &mut Ui, ui_state: &mut Config) {
    if ui.button("Reset Camera").clicked() {
        ui_state.orbit_reset = true;
    }

    ui.separator();

    egui::Grid::new("")
        .num_columns(2)
        .striped(true)
        .spacing([40.0, 4.0])
        .show(ui, |ui| {
            if ui.button("Reload").clicked() {
                *ui_state = read_config().unwrap_or(Config::default());
                ui_state.reload = true;
            }

            if ui.button("Save").clicked() {
                fs::write(
                    "crates/rdog/assets/config.json",
                    serde_json::to_string(ui_state.deref()).unwrap(),
                )
                .unwrap();
            }
        });
}
