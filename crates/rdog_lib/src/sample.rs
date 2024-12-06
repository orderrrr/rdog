use glam::{Vec2, Vec4};
use spirv_std::Sampler;

use crate::{Tex, Wrap};

pub fn sample(tex: Tex, sampler: &Sampler, uv: Vec2) -> Vec4 {
    let uv = uv.wrap();
    tex.sample_by_lod(*sampler, uv, 0.0)
}
