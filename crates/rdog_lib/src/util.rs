use crate::prelude::*;

pub type TexRgba16<'a> = &'a Image!(2D, format = rgba16f, sampled = false);
pub type TexRgba8<'a> = &'a Image!(2D, format = rgba8, sampled = false);

pub type Tex<'a> = &'a Image!(2D, type = f32, sampled = true);
