use bytemuck::{Pod, Zeroable};

use crate::prelude::*;

pub const TMAX: f32 = 22.0;
pub const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, -2.0, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

pub const DIFFUSE_BOUNCES: u32 = 4;
pub const SCATTER_STEPS: u32 = 2;
pub const BRDF_STEPS: u32 = 1;

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

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Material {
    ifrs: Vec4,
    nd: Vec4,
    albedo: Vec4,
    scattering_color: Vec4,
    dsei: Vec4,
}

impl Default for Material {
    fn default() -> Self {
        Self {
            // ifrs: (index, f0, roughness, scattering_scale)
            ifrs: Vec4::new(0.0, 0.04, 0.0, 0.0),

            // nd: (normal.xyz, dist)
            nd: Vec4::new(0.0, 0.0, 0.0, TMAX),

            // albedo: (albedo.xyz, w unused)
            albedo: Vec4::new(0.0, 0.0, 0.0, 0.0),

            // scattering_color: (scattering_color.xyz, w unused)
            scattering_color: Vec4::new(0.0, 0.0, 0.0, 0.0),

            // dsei: (diffuse_scale, specular_scale, emissive, ior)
            dsei: Vec4::new(1.0, 1.0, 0.0, 1.0),
        }
    }
}

impl Material {
    pub fn index(&self) -> f32 {
        self.ifrs.x
    }

    pub fn f0(&self) -> f32 {
        self.ifrs.y
    }

    pub fn roughness(&self) -> f32 {
        self.ifrs.z
    }

    pub fn scattering_scale(&self) -> f32 {
        self.ifrs.w
    }

    pub fn normal(&self) -> Vec3 {
        self.nd.xyz()
    }

    pub fn dist(&self) -> f32 {
        self.nd.w
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
        self.ifrs.x = index;
        self
    }

    pub fn with_f0(mut self, f0: f32) -> Self {
        self.ifrs.y = f0;
        self
    }

    pub fn with_roughness(mut self, roughness: f32) -> Self {
        self.ifrs.z = roughness;
        self
    }

    pub fn with_scattering_scale(mut self, scale: f32) -> Self {
        self.ifrs.w = scale;
        self
    }

    pub fn with_normal(mut self, normal: Vec3) -> Self {
        self.nd.x = normal.x;
        self.nd.y = normal.y;
        self.nd.z = normal.z;
        self
    }

    pub fn with_dist(mut self, dist: f32) -> Self {
        self.nd.w = dist;
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
    let p = plane(posi, vec4(0.0, -1.0, 0.0, 3.0));

    let l = vec2(l, 0.0);
    let s = vec2(s, 1.0);
    // let p = vec2(p, 2.0);
    //
    // let s2 = vec2(sphere(posi - vec3(-1.0, 1.0, 0.0), 0.6), 3.0);

    // min_sd(min_sd(min_sd(l, s), p), s2)
    min_sd(l, s)
}

pub fn hit(r: Ray, el: f32, seed: UVec2, materials: &[Material]) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.pd(t);

        let h = map(p, el, seed);

        if h.x < 0.001 {
            return lookup_mat(r, p, h, t, el, seed, materials);
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    Material::default()
}

// TODO move these materials to egui
pub fn lookup_mat(
    _r: Ray,
    p: Vec3,
    h: Vec2,
    t: f32,
    el: f32,
    seed: UVec2,
    materials: &[Material],
) -> Material {
    let s = if h.x >= 0.0 { 1.0 } else { 0.0 };
    let normal = calc_normal(p, el, seed) * s;

    let i = h.y as usize;

    if i > materials.len() - 1 {
        return Material::default().with_normal(normal).with_dist(t);
    }

    materials[i].with_normal(normal).with_dist(t)
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
    if f > 0.5 {
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

// right now not using atmos tex.
pub fn sample_atmos(_sr: Ray /* , atmos_tx: Tex<'_>, atmos_sampler: &Sampler */) -> Vec3 {
    vec3(0.03, 0.02, 0.03)
    // sample(
    //     atmos_tx,
    //     atmos_sampler,
    //     world_space_to_uv(sr.o + sr.d * 1000.0) + vec2(0.0, 0.02),
    // )
    // .xyz()
}

pub fn ray(ss: Vec2, ndc_to_world: Mat4, screen_pos: UVec2) -> Ray {
    let sp = screen_pos.as_vec2() + vec2(0.5, 0.5);

    let ndc = sp * 2.0 / ss - Vec2::ONE;
    let ndc = vec2(ndc.x, ndc.y);

    let far_plane = ndc_to_world.project_point3(ndc.extend(f32::EPSILON));
    let near_plane = ndc_to_world.project_point3(ndc.extend(1.0));

    Ray::new(near_plane, (far_plane - near_plane).normalize())
}

// todo maybe remove
pub fn get_camera_ray(pos: Vec2, camera: &Camera, _el: f32) -> Ray {
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

    let time = 4.0;
    // let time = el * 0.5;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -3.0));

    let f = 1.5;

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, f))).normalize();

    // start the ray right at the objec
    Ray::new(ro + rd, rd)
}
