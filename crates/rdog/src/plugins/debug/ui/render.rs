use crate::{Config, DebugConfig};
use bevy_egui::egui::{self, CollapsingHeader, Ui};

pub fn render_tab(ui: &mut Ui, ui_state: &mut Config, d: &mut DebugConfig) {
    CollapsingHeader::new("Passes")
        .default_open(true)
        .show(ui, |ui| passes(ui_state, ui));

    CollapsingHeader::new("Camera")
        .default_open(true)
        .show(ui, |ui| camera_ui(ui_state, d, ui));

    CollapsingHeader::new("Atmosphere")
        .default_open(true)
        .show(ui, |ui| atmosphere(ui_state, ui));
}

fn camera_ui(ui_state: &mut Config, d: &mut DebugConfig, ui: &mut Ui) {
    egui::Grid::new("")
        .num_columns(4)
        .striped(true)
        .spacing([4.0, 4.0])
        .show(ui, |ui| {
            ui.label("Internal Res");
            ui.add(egui::Slider::new(&mut ui_state.res, 0.01..=1.0));
            ui.end_row();

            ui.label("Aperture");
            ui.add(egui::Slider::new(
                &mut ui_state.camera_config.aperture,
                -10.0..=10.0,
            ));
            ui.end_row();

            ui.label("Focal Length");
            ui.add(egui::Slider::new(
                &mut ui_state.camera_config.focal_length,
                -10.0..=10.0,
            ));
            ui.end_row();

            ui.label("Focus dist");
            ui.add(egui::Slider::new(
                &mut ui_state.camera_config.focus_dist,
                0.0..=20.0,
            ));
            ui.end_row();
        });

    egui::Grid::new("")
        .num_columns(4)
        .striped(true)
        .spacing([4.0, 4.0])
        .show(ui, |ui| {
            ui.label("Focus Point");
            ui.add(
                egui::DragValue::new(&mut ui_state.camera_config.focus_point.x)
                    .speed(0.1)
                    .range(-16.0..=16.0),
            );
            ui.add(
                egui::DragValue::new(&mut ui_state.camera_config.focus_point.y)
                    .speed(0.1)
                    .range(-16.0..=16.0),
            );
            ui.add(
                egui::DragValue::new(&mut ui_state.camera_config.focus_point.z)
                    .speed(0.1)
                    .range(-16.0..=16.0),
            );
            ui.end_row();
        });

    ui.checkbox(&mut d.point_picker, "Pick point");
}

fn atmosphere(ui_state: &mut Config, ui: &mut Ui) {
    ui.checkbox(&mut ui_state.realtime_atmosphere, "Realtime Atmosphere");

    ui.heading("Sun Position");
    egui::Grid::new("")
        .num_columns(2)
        .striped(true)
        .spacing([40.0, 4.0])
        .show(ui, |ui| {
            ui.label("Sun Height");
            ui.add(egui::Slider::new(&mut ui_state.sun_pos.y, 0.0..=1.0).suffix("%"));
            ui.end_row();

            ui.label("Sun Pos");
            ui.add(egui::Slider::new(&mut ui_state.sun_pos.x, 0.0..=1.0).suffix("%"));
            ui.end_row();
        });
}

fn passes(ui_state: &mut Config, ui: &mut Ui) {
    ui.checkbox(
        &mut ui_state.multi_frame_override,
        "Preserve last frame (MultiPass)",
    );

    egui::Grid::new("")
        .num_columns(2)
        .striped(true)
        .spacing([40.0, 4.0])
        .show(ui, |ui| {
            // ui.checkbox(&mut ui_state.voxel_debug, "Voxel Debug");
            ui.label("should be voxel debug");
            ui.end_row();

            ui.label("Pass Count");
            ui.add(
                egui::DragValue::new(&mut ui_state.pass_count)
                    .speed(1)
                    .range(0.0..=16.0),
            );
            ui.end_row();

            ui.label("Bounces");
            ui.add(
                egui::DragValue::new(&mut ui_state.bounce_count)
                    .speed(1)
                    .range(0.0..=16.0),
            );
            ui.end_row();
        });
}
