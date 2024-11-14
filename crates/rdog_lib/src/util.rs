use glam::{vec3, Vec3};

use crate::prelude::*;

pub trait Math {
    fn cos(&self) -> Self;
    fn sin(&self) -> Self;
}

impl Math for Vec3 {
    fn cos(&self) -> Self {
        vec3(self.x.cos(), self.y.cos(), self.z.cos())
    }

    fn sin(&self) -> Self {
        vec3(self.x.sin(), self.y.sin(), self.z.sin())
    }
}

pub type TexRgba16<'a> = &'a Image!(2D, format = rgba16f, sampled = false);
pub type TexRgba8<'a> = &'a Image!(2D, format = rgba8, sampled = false);

pub type Tex<'a> = &'a Image!(2D, type = f32, sampled = true);
