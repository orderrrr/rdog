use super::TUi;
use crate::Config;
use bevy::prelude::*;
use bevy_egui::egui::{self, CollapsingHeader, RichText, Ui};
use glam::vec3;
use serde::{Deserialize, Serialize};

pub fn lights_tab(ui: &mut Ui, ui_state: &mut Config) {
    CollapsingHeader::new("Light List")
        .default_open(true)
        .show(ui, |ui| ui_state.light_tree.ui(ui));
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct LightList {
    pub lights: Vec<Light>,
}

impl Default for LightList {
    fn default() -> Self {
        LightList {
            lights: vec![Light::default()],
        }
    }
}

impl TUi for LightList {
    fn ui(&mut self, ui: &mut Ui) {
        let mut removed = None;
        let le = self.lights.len();
        for (i, light) in &mut self.lights.iter_mut().enumerate() {
            light.ui(ui);

            if ui
                .button(RichText::new("delete").color(ui.visuals().warn_fg_color))
                .clicked()
            {
                removed = Some(i);
            }

            if le - 1 > i {
                ui.separator();
            }
        }

        if removed.is_some() {
            self.lights.remove(removed.unwrap());
        }

        egui::Grid::new("")
            .num_columns(2)
            .striped(true)
            .spacing([40.0, 4.0])
            .show(ui, |ui| {
                ui.end_row();

                ui.label("New Light");
                if ui.button("+").clicked() {
                    self.lights.push(Light { ..default() });
                }
                ui.end_row();
            });
    }
}

#[derive(Copy, Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct Light {
    pub pos: Vec3,
    pub radius: f32,
    pub mat_id: f32,
    pub falloff: f32,
}

impl Default for Light {
    fn default() -> Self {
        Self {
            pos: vec3(1.0, 1.0, 0.0),
            radius: 1.0,
            mat_id: 0.0,
            falloff: 8.0,
        }
    }
}

impl Light {
    pub fn to_shader(&self) -> rdog_lib::Light {
        rdog_lib::Light::default()
            .with_pos(self.pos)
            .with_radius(self.radius)
            .with_material_id(self.mat_id)
            .with_falloff(self.falloff)
    }
}

impl TUi for Light {
    fn ui(&mut self, ui: &mut Ui) {
        egui::Grid::new("Light Instance")
            .num_columns(4)
            .striped(true)
            .spacing([10.0, 4.0])
            .show(ui, |ui| {
                ui.label("Material Id");
                ui.add(
                    egui::DragValue::new(&mut self.mat_id)
                        .speed(1.0)
                        .range(0.0..=20.0),
                );

                ui.label("PosX");
                ui.add(
                    egui::DragValue::new(&mut self.pos.x)
                        .speed(0.01)
                        .range(-10.0..=10.0),
                );

                ui.end_row();

                ui.label("Radius");
                ui.add(
                    egui::DragValue::new(&mut self.radius)
                        .speed(0.01)
                        .range(0.0..=10.0),
                );

                ui.label("PosY");
                ui.add(
                    egui::DragValue::new(&mut self.pos.y)
                        .speed(0.01)
                        .range(-10.0..=10.0),
                );
                ui.end_row();

                ui.label("Falloff");
                ui.add(
                    egui::DragValue::new(&mut self.falloff)
                        .speed(0.01)
                        .range(0.0..=20.0),
                );

                ui.label("PosZ");
                ui.add(
                    egui::DragValue::new(&mut self.pos.z)
                        .speed(0.01)
                        .range(-10.0..=10.0),
                );
                ui.end_row();
            });
    }
}
