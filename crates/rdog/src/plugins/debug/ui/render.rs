use crate::Config;
use bevy_egui::egui::{self, CollapsingHeader, Ui};

pub fn render_tab(ui: &mut Ui, ui_state: &mut Config, c: &mut bool) {
    CollapsingHeader::new("Passes")
        .default_open(true)
        .show(ui, |ui| *c = *c || passes(ui_state, ui));

    CollapsingHeader::new("Atmosphere")
        .default_open(true)
        .show(ui, |ui| *c = *c || atmosphere(ui_state, ui));
}

fn atmosphere(ui_state: &mut Config, ui: &mut Ui) -> bool {
    let mut c = false;

    c = c
        || ui
            .checkbox(&mut ui_state.realtime_atmosphere, "Realtime Atmosphere")
            .changed;

    ui.heading("Sun Position");
    egui::Grid::new("")
        .num_columns(2)
        .striped(true)
        .spacing([40.0, 4.0])
        .show(ui, |ui| {
            ui.label("Sun Height");
            c = c
                || ui
                    .add(egui::Slider::new(&mut ui_state.sun_pos.y, 0.0..=1.0).suffix("%"))
                    .changed;
            ui.end_row();

            ui.label("Sun Pos");
            c = c
                || ui
                    .add(egui::Slider::new(&mut ui_state.sun_pos.x, 0.0..=1.0).suffix("%"))
                    .changed;
            ui.end_row();
        });

    c
}

fn passes(ui_state: &mut Config, ui: &mut Ui) -> bool {
    let mut c = false;

    c = c
        || ui
            .checkbox(
                &mut ui_state.multi_frame_override,
                "Preserve last frame (MultiPass)",
            )
            .changed;

    egui::Grid::new("")
        .num_columns(2)
        .striped(true)
        .spacing([40.0, 4.0])
        .show(ui, |ui| {
            ui.label("Pass Count");
            c = ui
                .add(
                    egui::DragValue::new(&mut ui_state.pass_count)
                        .speed(1)
                        .range(0.0..=16.0),
                )
                .changed
                || c;
            ui.end_row();

            ui.label("Bounces");
            c = ui
                .add(
                    egui::DragValue::new(&mut ui_state.bounce_count)
                        .speed(1)
                        .range(0.0..=16.0),
                )
                .changed
                || c;
            ui.end_row();
        });

    c
}
