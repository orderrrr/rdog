// use spirv_std::image::ImageFormat;

use crate::prelude::*;

// ImageFormat
pub type TexRgba16<'a> = &'a Image!(2D, format = rgba16f, sampled = false);
pub type TexRgba32<'a> = &'a Image!(2D, format = rgba32f, sampled = false);
pub type TexRgba8<'a> = &'a Image!(2D, format = rgba8, sampled = false);
pub type TexRgba8i<'a> = &'a Image!(2D, format = rgba8i, sampled = false);
pub type TexRgba8ui<'a> = &'a Image!(2D, format = rgba8ui, sampled = false);

pub type Tex<'a> = &'a Image!(2D, type = f32, sampled = true);
pub type TexU<'a> = &'a Image!(2D, type = u32, sampled = true);
