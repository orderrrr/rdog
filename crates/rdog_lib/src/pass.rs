use bytemuck::{Pod, Zeroable};
use glam::{UVec2, Vec2};

#[repr(C)]
#[derive(Clone, Copy, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct PassParams {
    pub sun_x: f32,
    pub sun_y: f32,
    pub pass_count: u32,
    pub bounce_count: u32,
    pub flags: u32,
    pub voxel_dim: u32,
}

impl PassParams {
    pub fn new(sun: Vec2, pass_count: u32, bounce_count: u32, flags: u32, octree_dim: u32) -> Self {
        PassParams {
            sun_x: sun.x,
            sun_y: sun.y,
            pass_count,
            bounce_count,
            flags,
            voxel_dim: octree_dim,
        }
    }
}

#[repr(C)]
#[derive(Clone, Copy, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct OutputParams {
    pub workgroup_offset: UVec2,
    pub tile_size: UVec2,
}
