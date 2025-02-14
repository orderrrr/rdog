use std::{fs, ops::Deref};

use bevy::prelude::*;
use bevy_egui::{
    egui::{self, CollapsingHeader, Color32, Pos2, RichText, Ui},
    EguiContexts,
};
use glam::vec3;
use serde::{Deserialize, Serialize};

use crate::{plugins::rdog::config::read_config, Config};

use super::{DebugConfig, SelectedTab};

pub fn ui_system(
    mut ui_state: ResMut<Config>,
    mut debug_state: ResMut<DebugConfig>,
    mut contexts: EguiContexts,
) {
    ui_state.reload = false;
    let mut c = false;

    let ctx = contexts.ctx_mut();

    debug_state.pointer_in_egui = ctx.is_pointer_over_area();

    // debug_state.pointer_in_egui = ui.ui_contains_pointer();
    println!(
        "debug_state.pointer_in_egui: {}",
        debug_state.pointer_in_egui
    );

    egui::Window::new("Config")
        .vscroll(true)
        .default_open(false)
        .default_pos(Pos2::new(10.0, 10.0))
        .current_pos(Pos2::new(10.0, 10.0))
        .show(ctx, |ui| {
            ui.horizontal(|ui| {
                ui.selectable_value(&mut debug_state.selected_tab, SelectedTab::Render, "Render");
                ui.selectable_value(
                    &mut debug_state.selected_tab,
                    SelectedTab::Materials,
                    "Materials",
                );
                ui.selectable_value(&mut debug_state.selected_tab, SelectedTab::Lights, "Lights");
                ui.selectable_value(&mut debug_state.selected_tab, SelectedTab::System, "System");
            });

            match debug_state.selected_tab {
                SelectedTab::Render => render_tab(ui, &mut ui_state, &mut debug_state, &mut c),
                SelectedTab::Materials => mats_tab(ui, &mut ui_state, &mut debug_state, &mut c),
                SelectedTab::Lights => lights_tab(ui, &mut ui_state, &mut debug_state, &mut c),
                SelectedTab::System => system_tab(ui, &mut ui_state, &mut debug_state, &mut c),
            }
        });

    ui_state.multi_frame = !(c || ui_state.user_orbit || !ui_state.multi_frame_override);
}

fn render_tab(ui: &mut Ui, ui_state: &mut Config, _debug_state: &mut DebugConfig, c: &mut bool) {
    CollapsingHeader::new("Passes")
        .default_open(false)
        .show(ui, |ui| *c = *c || passes(ui_state, ui));

    CollapsingHeader::new("Atmosphere")
        .default_open(false)
        .show(ui, |ui| *c = *c || atmosphere(ui_state, ui));
}

fn mats_tab(ui: &mut Ui, ui_state: &mut Config, _debug_state: &mut DebugConfig, c: &mut bool) {
    CollapsingHeader::new("Material Tree")
        .default_open(false)
        .show(ui, |ui| *c = *c || ui_state.material_tree.ui(ui));
}

fn lights_tab(ui: &mut Ui, ui_state: &mut Config, _debug_state: &mut DebugConfig, c: &mut bool) {
    CollapsingHeader::new("Light List")
        .default_open(false)
        .show(ui, |ui| *c = *c || ui_state.light_tree.ui(ui));
}

fn system_tab(ui: &mut Ui, ui_state: &mut Config, _debug_state: &mut DebugConfig, c: &mut bool) {
    if ui.button("Reset Camera").clicked() {
        ui_state.orbit_reset = true;
        *c = true;
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
                *c = true;
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

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct LightList {
    pub list_changed: bool,
    pub modified: bool,
    pub lights: Vec<Light>,
}

impl Default for LightList {
    fn default() -> Self {
        LightList {
            lights: vec![Light::default()],
            modified: false,
            list_changed: false,
        }
    }
}

impl TUi for LightList {
    fn ui(&mut self, ui: &mut Ui) -> bool {
        self.list_changed = false;
        self.modified = false;

        let mut removed = None;
        let le = self.lights.len();
        for (i, light) in &mut self.lights.iter_mut().enumerate() {
            self.modified = self.modified || light.ui(ui);

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
            self.list_changed = true;
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
                    self.list_changed = true;
                }
                ui.end_row();
            });

        return self.list_changed || self.modified;
    }
}

#[derive(Copy, Clone, Debug, Serialize, Deserialize)]
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
    fn ui(&mut self, ui: &mut Ui) -> bool {
        let mut c = false;

        egui::Grid::new("Light Instance")
            .num_columns(4)
            .striped(true)
            .spacing([10.0, 4.0])
            .show(ui, |ui| {
                ui.label("Material Id");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.mat_id)
                            .speed(1.0)
                            .range(0.0..=20.0),
                    )
                    .changed
                    || c;

                ui.label("PosX");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.pos.x)
                            .speed(0.01)
                            .range(-10.0..=10.0),
                    )
                    .changed
                    || c;

                ui.end_row();

                ui.label("Radius");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.radius)
                            .speed(0.01)
                            .range(0.0..=10.0),
                    )
                    .changed
                    || c;

                ui.label("PosY");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.pos.y)
                            .speed(0.01)
                            .range(-10.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();

                ui.label("Falloff");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.falloff)
                            .speed(0.01)
                            .range(0.0..=20.0),
                    )
                    .changed
                    || c;

                ui.label("PosZ");
                c = ui
                    .add(
                        egui::DragValue::new(&mut self.pos.z)
                            .speed(0.01)
                            .range(-10.0..=10.0),
                    )
                    .changed
                    || c;
                ui.end_row();
            });

        c
    }
}
