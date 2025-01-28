use bytemuck::{Pod, Zeroable};

#[repr(C)]
#[derive(Clone, Copy, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct PassParams {
    pub sun_x: f32,
    pub sun_y: f32,
    pub pass_count: u32,
    pub bounce_count: u32,
    pub flags: u32,
}
