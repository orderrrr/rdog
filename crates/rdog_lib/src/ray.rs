use crate::prelude::*;

pub const TMAX: f32 = 22.0;
pub const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, 1.5, 2.5);
pub const LIGHT_RAD: f32 = 1.0;
pub const DIFFUSE_STEPS: u32 = 8;

#[derive(Copy, Clone)]
pub struct Ray {
    pub o: Vec3,
    pub d: Vec3,
}

impl Ray {
    pub fn new(o: Vec3, d: Vec3) -> Self {
        Ray { o, d }
    }
}

#[derive(Copy, Clone)]
pub struct Light {
    pub dist: f32,
    pub pos: Vec3,
    pub radius: f32,
}

pub struct Material {
    pub id: f32,
    pub dist: f32,
    pub normal: Vec3,
    pub metallic: bool,
    pub refractive: bool,
    pub albedo: Vec3,
    pub scattering_color: Vec3,
    pub diffuse_scale: f32,
    pub specular_scale: f32,
    pub emissive: f32,
    pub ior: f32,
    pub f0: f32,
    pub roughness: f32,
    pub scattering_weight: f32,
}

impl Default for Material {
    fn default() -> Self {
        Self {
            id: 0.0,
            dist: TMAX,
            normal: Vec3::ZERO,
            metallic: false,
            refractive: false,
            albedo: Vec3::ZERO,
            scattering_color: Vec3::ZERO,
            diffuse_scale: 1.0,
            specular_scale: 1.0,
            emissive: 0.0,
            ior: 1.0,
            f0: 0.04,
            roughness: 0.0,
            scattering_weight: 0.0,
        }
    }
}

fn shape(posi: Vec3, _g: &Globals) -> f32 {
    let pos = aar(posi + Vec3::NEG_Y, vec3(0.0, 0.8, 1.0).normalize(), 0.5);

    let po = aar(pos, vec3(0.0, 0.0, 1.0).normalize(), 90.0_f32.to_radians());
    let pp = aar(pos, vec3(1.0, 0.0, 0.0).normalize(), 45.0_f32.to_radians());
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    op_smooth_union(o, r, 0.1)

    // sphere(posi, 1.0)
}

pub fn map(posi: Vec3, g: &Globals) -> Vec2 {
    let l = sphere(posi - LIGHT_POS, LIGHT_RAD);
    let s = shape(posi, g);
    let p = plane(posi, vec4(0.0, 1.0, 0.0, 0.9));

    let l = vec2(l, 999.0);
    let s = vec2(s, 2.0);
    let p = vec2(p, 3.0);

    min_sd(min_sd(l, s), p)
}

pub fn calc_normal(pos: Vec3, g: &Globals) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (0. + e.xyy() * map(pos + ep * e.xyy(), g).x
        + e.yyx() * map(pos + ep * e.yyx(), g).x
        + e.yxy() * map(pos + ep * e.yxy(), g).x
        + e.xxx() * map(pos + ep * e.xxx(), g).x)
        .normalize()
}
