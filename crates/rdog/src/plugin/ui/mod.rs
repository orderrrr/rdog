use std::{fs, ops::Deref};

use bevy::prelude::*;
use bevy_egui::{
    egui::{self, CollapsingHeader, Color32, Pos2, RichText, Ui},
    EguiContexts,
};
use glam::vec3;
use rdog_lib::TMAX;
use serde::{Deserialize, Serialize};

use crate::Config;

use super::read_config;

pub fn ui_system(mut ui_state: ResMut<Config>, mut contexts: EguiContexts) {
    let mut c = false;

    let ctx = contexts.ctx_mut();

    egui::Window::new("Config")
        .vscroll(true)
        .default_open(false)
        .default_pos(Pos2::new(10.0, 10.0))
        .current_pos(Pos2::new(10.0, 10.0))
        .show(ctx, |ui| {
            ui.heading("Config Panel");

            ui.separator();

            CollapsingHeader::new("Passes")
                .default_open(true)
                .show(ui, |ui| c = c || passes(&mut ui_state, ui));

            CollapsingHeader::new("Atmosphere")
                .default_open(false)
                .show(ui, |ui| c = c || atmosphere(&mut ui_state, ui));

            ui.separator();

            CollapsingHeader::new("Material Tree")
                .default_open(false)
                .show(ui, |ui| c = c || ui_state.material_tree.ui(ui));

            ui.separator();

            if ui.button("Reset Camera").clicked() {
                ui_state.orbit_reset = true;
                c = true;
            }

            ui.separator();

            egui::Grid::new("")
                .num_columns(2)
                .striped(true)
                .spacing([40.0, 4.0])
                .show(ui, |ui| {
                    if ui.button("Reload").clicked() {
                        *ui_state = read_config().unwrap_or(Config::default());
                        c = true;
                    }

                    if ui.button("Save").clicked() {
                        fs::write(
                            "crates/rdog/assets/config.json",
                            serde_json::to_string(ui_state.deref()).unwrap(),
                        )
                        .unwrap();
                    }
                });
        });

    ui_state.multi_frame = !(c || ui_state.user_orbit || !ui_state.multi_frame_override);
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
            // ui_state.sun_pos *= 360.0;

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

            // ui_state.sun_pos /= 360.0;
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
            ui_state.pass_count -= 1;
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
            ui_state.pass_count += 1;

            ui_state.bounce_count -= 1;
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
            ui_state.bounce_count += 1;
        });

    // TODO - probably can remove...
    // c = c
    //     || ui
    //         .checkbox(&mut ui_state.direct_pass, "Direct+Indirect Lighting")
    //         .changed;
    // c = c
    //     || ui
    //         .checkbox(&mut ui_state.scatter_pass, "Scatter Lighting")
    //         .changed;
    // c = c
    //     || ui
    //         .checkbox(&mut ui_state.specular_pass, "Specular Lighting")
    //         .changed;
    // c = c
    //     || ui
    //         .checkbox(&mut ui_state.realtime_atmosphere, "Realtime Atmosphere")
    //         .changed;

    c
}

pub trait TUi {
    fn ui(&mut self, ui: &mut Ui) -> bool;
}

#[derive(Clone, Copy, PartialEq)]
pub enum Action {
    Keep,
    Delete,
}

#[derive(Clone, Default, Debug, Serialize, Deserialize)]
pub struct MaterialList {
    pub changed: bool,
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
            changed: false,
        }
    }
}

impl TUi for MaterialList {
    fn ui(&mut self, ui: &mut Ui) -> bool {
        self.changed = false;
        let mut p_change = false;

        let mut removed = None;
        let le = self.mats.len();
        for (i, material) in &mut self.mats.iter_mut().enumerate() {
            p_change = p_change || material.ui(ui);

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
            self.changed = true;
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
                    self.changed = true;
                }
                ui.end_row();
            });

        for (i, material) in &mut self.mats.iter_mut().enumerate() {
            material.id = i as f32;
        }

        return self.changed || p_change;
    }
}

impl TUi for Material {
    fn ui(&mut self, ui: &mut Ui) -> bool {
        let mut c = false;

        ui.heading("Material Instance");
        egui::Grid::new("")
            .num_columns(2)
            .striped(true)
            .spacing([40.0, 4.0])
            .show(ui, |ui| {
                ui.label("ID");
                // ui.add(egui::DragValue::new(&mut self.id).speed(1).range(0..=255));
                ui.label(self.id.to_string());
                ui.end_row();

                let mut albedo = self.albedo.to_c32();
                ui.label("Albedo");
                c = ui.color_edit_button_srgba(&mut albedo).changed || c;
                self.albedo = Vec3::from_c32(albedo);
                ui.end_row();

                let mut scattering_col = self.scattering_color.to_c32();
                ui.label("Scatter Col");
                c = ui.color_edit_button_srgba(&mut scattering_col).changed || c;
                self.scattering_color = Vec3::from_c32(scattering_col);
                ui.end_row();

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
                ui.end_row();

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
                ui.end_row();

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

                ui.label("F0");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.refraction)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();

                ui.label("Roughness");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.roughness)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();
            });

        c
    }
}

pub trait C32 {
    fn to_c32(self) -> Color32;
    fn from_c32(c: Color32) -> Self;
}

impl C32 for Vec3 {
    fn to_c32(self) -> Color32 {
        egui::Color32::from_rgb(
            (self.x * 255.999) as u8,
            (self.y * 255.999) as u8,
            (self.z * 255.999) as u8,
        )
    }

    fn from_c32(c: Color32) -> Self {
        vec3(
            (c.r() as f32) / 255.999,
            (c.g() as f32) / 255.999,
            (c.b() as f32) / 255.999,
        )
    }
}

#[derive(Copy, Clone, Debug, Serialize, Deserialize)]
pub struct Material {
    pub id: f32,
    pub dist: f32,
    pub normal: Vec3,
    pub metallic: bool,
    pub refractive: bool,
    pub albedo: Vec3,
    pub scattering_color: Vec3,
    pub diffuse_scale: f32,
    pub specular_scale: f32,
    pub emissive: f32,
    pub ior: f32,
    pub refraction: f32,
    pub roughness: f32,
    pub scattering_scale: f32,
}
impl Material {
    pub fn to_shader(&self) -> rdog_lib::Material {
        rdog_lib::Material::default()
            // ifrs: (index, f0, roughness, scattering_scale)
            .with_index(self.id)
            .with_refraction(self.refraction)
            .with_roughness(self.roughness)
            .with_scattering_scale(self.scattering_scale)
            // nd: (normal.xyz, dist)
            .with_normal(self.normal)
            .with_dist(self.dist)
            // albedo: (albedo.xyz, unused)
            .with_albedo(self.albedo)
            // scattering_color: (scattering_color.xyz, unused)
            .with_scattering_color(self.scattering_color)
            // dsei: (diffuse_scale, specular_scale, emissive, ior)
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
            dist: TMAX,
            normal: Vec3::ZERO,
            metallic: false,
            refractive: false,
            albedo: Vec3::ZERO,
            scattering_color: Vec3::ZERO,
            diffuse_scale: 1.0,
            specular_scale: 1.0,
            emissive: 0.0,
            ior: 0.0,
            refraction: 0.04,
            roughness: 0.0,
            scattering_scale: 0.0,
        }
    }
}
