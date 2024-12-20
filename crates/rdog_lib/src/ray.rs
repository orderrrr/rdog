use crate::prelude::*;

pub const TMAX: f32 = 22.0;
pub const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, 1.5, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

pub const DIFFUSE_STEPS: u32 = 8;
pub const SCATTER_STEPS: u32 = 8;
pub const BRDF_STEPS: u32 = 8;

#[derive(Copy, Clone)]
pub struct Ray {
    pub o: Vec3,
    pub d: Vec3,
}

impl Ray {
    pub fn new(o: Vec3, d: Vec3) -> Self {
        Ray { o, d }
    }
    pub fn pd(&self, t: f32) -> Vec3 {
        (self.d * t) + self.o
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
    pub scattering_scale: f32,
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
            scattering_scale: 0.0,
        }
    }
}

pub fn shape(posi: Vec3, _el: f32, _seed: UVec2) -> f32 {
    // let pos = aar(posi + Vec3::NEG_Y, vec3(0.2, 1.0, 0.0).normalize(), el);
    let pos = aar(posi + Vec3::NEG_Y, vec3(0.2, 1.0, 0.0).normalize(), 0.5);
    let po = aar(pos, vec3(0.0, 0.0, 1.0).normalize(), 90.0_f32.to_radians());
    let pp = aar(pos, vec3(1.0, 0.0, 0.0).normalize(), 45.0_f32.to_radians());
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    op_smooth_union(o, r, 0.1)
}

pub fn map(posi: Vec3, el: f32, seed: UVec2) -> Vec2 {
    let l = sphere(posi - LIGHT_POS, LIGHT_RAD);
    let s = shape(posi, el, seed);
    let p = plane(posi, vec4(0.0, 1.0, 0.0, 0.9));

    let l = vec2(l, 999.0);
    let s = vec2(s, 2.0);
    let p = vec2(p, 3.0);

    let s2 = vec2(sphere(posi - vec3(-1.0, 1.0, 0.0), 0.6), 3.0);

    min_sd(min_sd(min_sd(l, s), p), s2)
}

pub fn hit(r: Ray, el: f32, seed: UVec2) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.pd(t);

        let h = map(p, el, seed);

        if h.x < 0.001 {
            return lookup_mat(r, p, h, t, el, seed);
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    Material::default()
}

// TODO - currently very hacky, move this out of the shader.
pub fn lookup_mat(_r: Ray, p: Vec3, h: Vec2, t: f32, el: f32, seed: UVec2) -> Material {
    let s = if h.x >= 0.0 { 1.0 } else { 0.0 };

    match h.y {
        2.0 => Material {
            id: h.y,
            dist: t,
            scattering_scale: 1.0,
            scattering_color: Vec3::splat(1.0),
            specular_scale: 1.0,
            f0: 0.04,
            roughness: 1.0,
            ior: 1.04,
            normal: calc_normal(p, el, seed) * s,
            albedo: vec3(0.71, 0.65, 0.26),
            ..Default::default()
        },
        3.0 => Material {
            id: h.y,
            dist: t,
            metallic: true,
            scattering_scale: 0.0,
            scattering_color: Vec3::splat(1.0),
            specular_scale: 1.0,
            f0: 0.95,
            ior: 1.4,
            diffuse_scale: 0.0,
            roughness: 0.2,
            normal: calc_normal(p, el, seed) * s,
            // albedo: checker(vec3(0.79, 0.70, 0.77), vec3(0.79, 0.70, 0.77) * 0.5, r, t),
            albedo: vec3(0.71, 0.65, 0.26),
            ..Default::default()
        },
        999.0 => Material {
            id: h.y,
            dist: t,
            emissive: 8.0,
            normal: calc_normal(p, el, seed) * s,
            albedo: vec3(1.0, 1.0, 1.0),
            ..Default::default()
        },
        _ => Material {
            id: h.y,
            dist: t,
            albedo: vec3(1.0, 1.0, 1.0),
            specular_scale: 1.0,
            f0: 0.04,
            normal: calc_normal(p, el, seed) * s,
            ..Default::default()
        },
    }
}

pub fn calculate_derivatives(rd: Vec3, step_size: f32) -> (Vec3, Vec3) {
    // Calculate tangent vectors perpendicular to ray direction
    let temp = if rd.x.abs() < 0.9 { Vec3::X } else { Vec3::Y };
    let tangent = rd.cross(temp).normalize();
    let bitangent = rd.cross(tangent);

    // Approximate derivatives using small offsets along tangent vectors
    let dpdx = tangent * step_size;
    let dpdy = bitangent * step_size;

    (dpdx, dpdy)
}

pub fn checkers_grad_box(p: Vec2, dpdx: Vec2, dpdy: Vec2) -> f32 {
    let t = 3.;
    let p = (p / t).wrap() * t;
    // Filter kernel
    let w = dpdx.abs() + dpdy.abs() + Vec2::splat(0.001);

    // Analytical integral
    let i = 2.0
        * ((((p - 0.5 * w) * 0.5).fract() - 0.5).abs()
            - (((p + 0.5 * w) * 0.5).fract() - 0.5).abs())
        / w;

    // XOR pattern
    0.5 - 0.5 * i.x * i.y
}

pub fn checker(v1: Vec3, v2: Vec3, r: Ray, t: f32) -> Vec3 {
    let pos = r.pd(t);

    let (dpdx, dpdy) = calculate_derivatives(r.d, 0.01);
    let f = checkers_grad_box(3.0 * pos.xz(), 3.0 * dpdx.xz(), 3.0 * dpdy.xz());
    if f > 0.0 {
        v1
    } else {
        v2
    }
}

pub fn light_map(posi: Vec3, _el: f32, _seed: UVec2) -> Light {
    let dist = sphere(posi - LIGHT_POS, LIGHT_RAD);

    Light {
        dist,
        pos: LIGHT_POS,
        radius: LIGHT_RAD,
    }
}

pub fn calc_normal(pos: Vec3, el: f32, seed: UVec2) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (0. + e.xyy() * map(pos + ep * e.xyy(), el, seed).x
        + e.yyx() * map(pos + ep * e.yyx(), el, seed).x
        + e.yxy() * map(pos + ep * e.yxy(), el, seed).x
        + e.xxx() * map(pos + ep * e.xxx(), el, seed).x)
        .normalize()
}

pub fn translate_to_ws(d: Vec3, n: Vec3) -> Vec3 {
    let r = if n.x.abs() > n.y.abs() {
        vec3(n.z, 0.0, -n.x) / ((n.x * n.x) + (n.z * n.z)).sqrt()
    } else {
        vec3(0.0, -n.z, n.y) / ((n.y * n.y) + (n.z * n.z)).sqrt()
    };

    let f = n.cross(r);

    return vec3(
        (d.x * f.x) + (d.y * n.x) + (d.z * r.x),
        (d.x * f.y) + (d.y * n.y) + (d.z * r.y),
        (d.x * f.z) + (d.y * n.z) + (d.z * r.z),
    );
}

pub fn get_camera_ray(pos: Vec2, camera: &Camera, el: f32) -> Ray {
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

    // let time = 4.0;
    let time = el * 0.5;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -3.0));

    let f = 1.5;

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, f))).normalize();

    // start the ray right at the object
    Ray::new(ro + rd, rd)
}
