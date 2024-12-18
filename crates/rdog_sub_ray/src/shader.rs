use bytemuck::{Pod, Zeroable};
use glam::{UVec2, Vec2};

#[repr(C)]
#[derive(Copy, Clone, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Globals {
    pub time: Vec2,
    pub seed: UVec2
}
