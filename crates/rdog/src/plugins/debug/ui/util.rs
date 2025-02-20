use bevy_egui::egui::{self, Color32, Ui};
use glam::{vec3, Vec3};
use serde::{Deserialize, Serialize};
use strum::EnumIter;

use crate::Config;

use super::{lights_tab, mats_tab, render_tab, system_tab};

pub trait TUi {
    fn ui(&mut self, ui: &mut Ui) -> bool;
}

#[derive(Clone, Copy, PartialEq)]
pub enum Action {
    Keep,
    Delete,
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

#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq, EnumIter)]
pub enum SelectedTab {
    #[default]
    Render,
    Mats,
    Lights,
    System,
}

impl SelectedTab {
    pub fn name(&self) -> String {
        match self {
            Self::Render => "render",
            Self::Mats => "mats",
            Self::Lights => "lights",
            Self::System => "system",
        }
        .to_string()
    }

    pub fn render(&self, ui: &mut Ui, ui_state: &mut Config, c: &mut bool) {
        match self {
            Self::Render => render_tab(ui, ui_state, c),
            Self::Mats => mats_tab(ui, ui_state, c),
            Self::Lights => lights_tab(ui, ui_state, c),
            Self::System => system_tab(ui, ui_state, c),
        }
    }
}
