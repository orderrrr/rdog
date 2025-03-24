use crate::prelude::*;
use bytemuck::{Pod, Zeroable};

#[repr(C)]
#[derive(Copy, Clone, Default, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Globals {
    pub time: Vec2,
    pub seed: UVec2,
    pub mouse: Vec2,
    pub true_res: UVec2,
}

impl Globals {
    pub fn with_seed(&self, seed: UVec2, true_res: UVec2) -> Self {
        Globals {
            time: self.time,
            seed,
            mouse: self.mouse,
            true_res
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

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Material {
    pub irrs: Vec4,
    pub albedo: Vec4,
    pub scattering_color: Vec4,
    pub dsei: Vec4,
}

impl Default for Material {
    fn default() -> Self {
        Self {
            irrs: Vec4::new(0.0, 0.04, 0.0, 0.0),
            albedo: Vec4::new(0.0, 0.0, 0.0, 0.0),
            scattering_color: Vec4::new(0.0, 0.0, 0.0, 0.0),
            dsei: Vec4::new(1.0, 1.0, 0.0, 0.0),
        }
    }
}

impl Material {
    pub fn index(&self) -> f32 {
        self.irrs.x
    }

    pub fn refraction(&self) -> f32 {
        self.irrs.y
    }

    pub fn roughness(&self) -> f32 {
        self.irrs.z
    }

    pub fn scattering_scale(&self) -> f32 {
        self.irrs.w
    }

    pub fn albedo(&self) -> Vec3 {
        self.albedo.xyz()
    }

    pub fn scattering_color(&self) -> Vec3 {
        self.scattering_color.xyz()
    }

    pub fn diffuse(&self) -> f32 {
        self.dsei.x
    }

    pub fn specular(&self) -> f32 {
        self.dsei.y
    }

    pub fn emissive(&self) -> f32 {
        self.dsei.z
    }

    pub fn ior(&self) -> f32 {
        self.dsei.w
    }
}

impl Material {
    pub fn with_index(mut self, index: f32) -> Self {
        self.irrs.x = index;
        self
    }

    pub fn with_refraction(mut self, refraction: f32) -> Self {
        self.irrs.y = refraction;
        self
    }

    pub fn with_roughness(mut self, roughness: f32) -> Self {
        self.irrs.z = roughness;
        self
    }

    pub fn with_interior(mut self, interior: bool) -> Self {
        self.albedo.w = ((!interior as i32) as f32) * 2.0 - 1.0;
        self
    }

    pub fn with_scattering_scale(mut self, scale: f32) -> Self {
        self.irrs.w = scale;
        self
    }

    pub fn with_albedo(mut self, albedo: Vec3) -> Self {
        self.albedo.x = albedo.x;
        self.albedo.y = albedo.y;
        self.albedo.z = albedo.z;
        self
    }

    pub fn with_scattering_color(mut self, color: Vec3) -> Self {
        self.scattering_color.x = color.x;
        self.scattering_color.y = color.y;
        self.scattering_color.z = color.z;
        self
    }

    pub fn with_diffuse(mut self, diffuse: f32) -> Self {
        self.dsei.x = diffuse;
        self
    }

    pub fn with_specular(mut self, specular: f32) -> Self {
        self.dsei.y = specular;
        self
    }

    pub fn with_emissive(mut self, emissive: f32) -> Self {
        self.dsei.z = emissive;
        self
    }

    pub fn with_ior(mut self, ior: f32) -> Self {
        self.dsei.w = ior;
        self
    }
}

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Light {
    pub posf: Vec4,
    pub rmd: Vec4,
}

impl Default for Light {
    fn default() -> Self {
        Self {
            posf: vec4(10000.0, 10000.0, 10000.0, 8.0),
            rmd: vec4(0.0, 0.0, 0.0, 0.0),
        }
    }
}

impl Light {
    pub fn pos(&self) -> Vec3 {
        self.posf.xyz()
    }

    pub fn falloff(&self) -> f32 {
        self.posf.w
    }
}

impl Light {
    pub fn with_pos(mut self, pos: Vec3) -> Self {
        self.posf = pos.extend(self.falloff());
        self
    }

    pub fn with_falloff(mut self, falloff: f32) -> Self {
        self.posf.w = falloff;
        self
    }

    pub fn with_radius(mut self, radius: f32) -> Self {
        self.rmd.x = radius;
        self
    }

    pub fn with_material_id(mut self, material_id: f32) -> Self {
        self.rmd.y = material_id;
        self
    }

    pub fn with_dist(mut self, dist: f32) -> Self {
        self.rmd.z = dist;
        self
    }
}
