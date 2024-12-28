use core::f32;

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
}

impl Camera {
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

    pub fn ray(self, screen_pos: UVec2) -> Ray {
        let ss = self.screen.xy();
        let sp = screen_pos.as_vec2() + vec2(0.5, 0.5);

        let ndc = sp * 2.0 / ss - Vec2::ONE;
        let ndc = vec2(ndc.x, ndc.y);

        let far_plane = self.ndc_to_world.project_point3(ndc.extend(f32::EPSILON));
        let near_plane = self.ndc_to_world.project_point3(ndc.extend(1.0));

        Ray::new(near_plane, (far_plane - near_plane).normalize())
    }
}
