use super::{TUi, C32};
use crate::Config;
use bevy::prelude::*;
use bevy_egui::egui::{self, CollapsingHeader, RichText, Ui};
use glam::vec3;
use serde::{Deserialize, Serialize};

pub fn mats_tab(ui: &mut Ui, ui_state: &mut Config, c: &mut bool) {
    CollapsingHeader::new("Material Tree")
        .default_open(true)
        .show(ui, |ui| *c = *c || ui_state.material_tree.ui(ui));
}

#[derive(Clone, Default, Debug, Serialize, Deserialize)]
pub struct MaterialList {
    pub list_changed: bool,
    pub modified: bool,
    pub mats: Vec<Material>,
}

impl MaterialList {
    pub fn demo() -> Self {
        Self {
            mats: vec![
                Material {
                    albedo: vec3(0.99, 0.98, 1.0),
                    emissive: 8.0,
                    ..default()
                },
                Material {
                    albedo: vec3(0.99, 0.55, 0.7),
                    ..default()
                },
            ],
            modified: false,
            list_changed: false,
        }
    }
}

impl TUi for MaterialList {
    fn ui(&mut self, ui: &mut Ui) -> bool {
        self.list_changed = false;
        self.modified = false;

        let mut removed = None;
        let le = self.mats.len();
        for (i, material) in &mut self.mats.iter_mut().enumerate() {
            self.modified = self.modified || material.ui(ui);

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
            self.mats.remove(removed.unwrap());
            self.list_changed = true;
        }

        egui::Grid::new("")
            .num_columns(2)
            .striped(true)
            .spacing([40.0, 4.0])
            .show(ui, |ui| {
                ui.end_row();

                ui.label("New Material");
                if ui.button("+").clicked() {
                    self.mats.push(Material {
                        id: (self.mats.len() - 1) as f32,
                        ..default()
                    });
                    self.list_changed = true;
                }
                ui.end_row();
            });

        for (i, material) in &mut self.mats.iter_mut().enumerate() {
            material.id = i as f32;
        }

        return self.list_changed || self.modified;
    }
}

impl TUi for Material {
    fn ui(&mut self, ui: &mut Ui) -> bool {
        let mut c = false;

        egui::Grid::new("Material Instance")
            .num_columns(4)
            .striped(true)
            .spacing([10.0, 4.0])
            .show(ui, |ui| {
                ui.label("ID");
                // ui.add(egui::DragValue::new(&mut self.id).speed(1).range(0..=255));
                ui.label(self.id.to_string());
                // ui.end_row();

                let mut albedo = self.albedo.to_c32();
                ui.label("Albedo");
                c = ui.color_edit_button_srgba(&mut albedo).changed || c;
                self.albedo = Vec3::from_c32(albedo);
                ui.end_row();

                let mut scattering_col = self.scattering_color.to_c32();
                ui.label("Scatter Col");
                c = ui.color_edit_button_srgba(&mut scattering_col).changed || c;
                self.scattering_color = Vec3::from_c32(scattering_col);
                // ui.end_row();

                ui.label("Diffuse Scale");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.diffuse_scale)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();

                ui.label("Specular Scale");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.specular_scale)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                // ui.end_row();

                ui.label("Scatter Scale");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.scattering_scale)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();

                ui.label("Emmissive");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.emissive)
                            .speed(0.01)
                            .range(0.0..=30.0),
                    )
                    .changed
                    || c;
                // ui.end_row();

                ui.label("Ior");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.ior)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();

                ui.label("Refraction");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.refraction)
                            .speed(0.01)
                            .range(0.0..=1.0),
                    )
                    .changed
                    || c;
                // ui.end_row();

                ui.label("Roughness");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.roughness)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
            });

        c
    }
}

#[derive(Copy, Clone, Debug, Serialize, Deserialize)]
pub struct Material {
    pub id: f32,

    pub diffuse_scale: f32,
    pub specular_scale: f32,
    pub scattering_scale: f32,
    pub ior: f32,
    pub refraction: f32,
    pub roughness: f32,
    pub albedo: Vec3,
    pub scattering_color: Vec3,
    pub emissive: f32,
}
impl Material {
    pub fn to_shader(&self) -> rdog_lib::Material {
        rdog_lib::Material::default()
            .with_refraction(self.refraction)
            .with_roughness(self.roughness)
            .with_scattering_scale(self.scattering_scale)
            .with_albedo(self.albedo)
            .with_scattering_color(self.scattering_color)
            .with_diffuse(self.diffuse_scale)
            .with_specular(self.specular_scale)
            .with_emissive(self.emissive)
            .with_ior(self.ior)
    }
}

impl Default for Material {
    fn default() -> Self {
        Self {
            id: 0.0,
            albedo: Vec3::ZERO,
            scattering_color: Vec3::ZERO,
            diffuse_scale: 1.0,
            specular_scale: 0.0,
            emissive: 0.0,
            ior: 0.0,
            refraction: 0.04,
            roughness: 0.0,
            scattering_scale: 0.0,
        }
    }
}
