use crate::prelude::*;
use bytemuck::{Pod, Zeroable};
use glam::{Mat4, Vec2, Vec3, Vec4};

#[repr(C)]
#[derive(Clone, Copy, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Camera {
    pub projection_view: Mat4,
    pub ndc_to_world: Mat4,
    pub origin: Vec4,
    pub screen: Vec4,
    pub fpd: Vec4,
    pub ftd: Vec4,
}

impl Camera {
    pub fn new_blank(screen: Vec4) -> Self {
        Camera {
            projection_view: Mat4::ZERO,
            ndc_to_world: Mat4::ZERO,
            origin: Vec4::ZERO,
            screen,
            fpd: Vec4::ZERO,
            ftd: Vec4::ZERO,
        }
    }

    /// Given a point in world-coordinates, returns it in clip-coordinates.
    pub fn world_to_clip(self, pos: Vec3) -> Vec4 {
        self.projection_view * pos.extend(1.0)
    }

    /// Given a point in world-coordinates, returns it in screen-coordinates.
    pub fn world_to_screen(self, pos: Vec3) -> Vec2 {
        self.clip_to_screen(self.world_to_clip(pos))
    }

    /// Given a point in clip-coordinates, returns it in screen-coordinates.
    pub fn clip_to_screen(self, pos: Vec4) -> Vec2 {
        let ndc = pos.xy() / pos.w;
        let ndc = vec2(ndc.x, -ndc.y);

        (0.5 * ndc + 0.5) * self.screen.xy()
    }

    /// Given a point in screen-coordinates, returns a unique index for it; used
    /// to index screen-space structures.
    pub fn screen_to_idx(self, pos: UVec2) -> usize {
        (pos.y * (self.screen.x as u32) + pos.x) as usize
    }
}
