use crate::prelude::*;
use bytemuck::{Pod, Zeroable};

#[repr(C)]
#[derive(Copy, Clone, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Globals {
    pub time: Vec2,
    pub seed: UVec2,
}

impl Globals {
    pub fn with_seed(&self, seed: UVec2) -> Self {
        Globals {
            time: self.time,
            seed,
        }
    }
}

#[repr(C)]
#[derive(Copy, Clone, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct RayParams {
    pub time: Vec2,
    pub seed: UVec2,
}
