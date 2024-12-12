use rdog_lib::prelude::*;
use spirv_std::glam::{Vec2, Vec4};

use crate::atmosphere::calc_atmosphere2;

const RMAX: u32 = 150;
const TMAX: f32 = 22.0;

// TODO TEMP PUB
struct Material {
    dist: f32,
    normal: Vec3,
    metallic: bool,
    refractive: bool,
    albedo: Vec3,
    scattering_color: Vec3,
    diffuse_scale: f32,
    specular_scale: f32,
    emissive: f32,
    ior: f32,
    f0: f32,
    roughness: f32,
    scattering_weight: f32,
}

impl Default for Material {
    fn default() -> Self {
        Self {
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

fn map(pos: Vec3, elapsed: f32) -> Vec2 {
    let pos = axis_angle_rotate(
        pos + vec3(0.0, -1.0, 0.0),
        vec3(0.2, 0.6, 1.5).normalize(),
        elapsed * 10.0,
    );

    let po = axis_angle_rotate(pos, vec3(0.0, 0.0, 1.0).normalize(), 90.0_f32.to_radians());
    let pp = axis_angle_rotate(pos, vec3(1.0, 0.0, 0.0).normalize(), 45.0_f32.to_radians());

    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.2), 0.3, 0.1, 0.05);
    let r = sd_rounded_cylinder(po + vec3(-0.2, 0.0, 0.2), 0.3, 0.1, 0.05);

    return vec2(op_smooth_union(o, r, 0.3), 2.0);
}

fn calc_normal(pos: Vec3, el: f32) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (0. + e.xyy() * map(pos + ep * e.xyy(), el).x
        + e.yyx() * map(pos + ep * e.yyx(), el).x
        + e.yxy() * map(pos + ep * e.yxy(), el).x
        + e.xxx() * map(pos + ep * e.xxx(), el).x)
        .normalize()
}

fn robobo_1221_tonemap(color: Vec3) -> Vec3 {
    let l = color.length();

    let mut color = color;
    color = color.mix(color * 0.5, l / (l + 1.0));
    r_t_operator(color)
}

#[inline]
fn r_t_operator(x: Vec3) -> Vec3 {
    return x / (x * x + 1.0).sqrt();
}

fn checkers_grad_box(p: Vec2, dpdx: Vec2, dpdy: Vec2) -> f32 {
    let t = 6.;
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

fn render(
    pos: Vec4,

    camera: &Camera,
    globals: &Globals,

    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;
    let uvx = (2.0 * (p + vec2(1.0, 0.0)) - camera.screen.xy()).xy() / camera.screen.y;
    let uvy = (2.0 * (p + vec2(0.0, 1.0)) - camera.screen.xy()).xy() / camera.screen.y;

    // let uv = (2.0 * pos - camera.screen).xy() / camera.screen.y;
    // let uv = uv * -1.0;
    let time = globals.time.x * 0.05;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -2.0));

    let f = 1.5;

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, f))).normalize();
    let rdx = (rotate_vector(rotor, vec3(uvx.x, uvx.y, f))).normalize();
    let rdy = (rotate_vector(rotor, vec3(uvy.x, uvy.y, f))).normalize();

    let mut col = get_color(ro, rd, rdx, rdy, time);

    if col == Vec3::ZERO {
        let coord = ro + rd * 10.0;

        col = calc_atmosphere2(
            coord.normalize(),
            (pos - camera.screen).xy(),
            globals,
            noise_tx,
            noise_sampler,
        );
    }

    col
}

fn get_color(ro: Vec3, rd: Vec3, rdx: Vec3, rdy: Vec3, e: f32) -> Vec3 {
    let mut res = hit(ro, rd, rdx, rdy, e);

    if res.dist < TMAX {
        let mut col = Vec3::ZERO;

        let pos = ro + res.dist * rd;
        // col = calc_normal(pos, time);
        let norm = res.normal;
        return res.albedo;
    }

    Vec3::ZERO
}

fn hit(ro: Vec3, rd: Vec3, rdx: Vec3, rdy: Vec3, e: f32) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.;

    let mut res = Material::default();

    let tp1 = (0.0 - ro.y) / rd.y;
    if tp1 > 0.0 {
        res.dist = tp1;
        res.normal = vec3(0.0, 1.0, 0.0);
        let pos = ro + res.dist * rd;
        // // project pixel footprint into the plane
        let dpdx = ro.y * (rd / rd.y - rdx / rdx.y);
        let dpdy = ro.y * (rd / rd.y - rdy / rdy.y);
        let f = checkers_grad_box(3.0 * pos.xz(), 3.0 * dpdx.xz(), 3.0 * dpdy.xz());
        res.albedo = 0.15 + f * Vec3::splat(0.05);
        // todo material here.
    }

    for _ in 0..RMAX {
        let p = ro + t * rd;

        let h = map(p, e);
        if h.x < 0.001 {
            res = match h.y {
                2.0 => Material {
                    dist: t,
                    normal: calc_normal(p, e),
                    albedo: vec3(1.0, 0.0, 0.0),
                    ..Default::default()
                },
                _ => Material {
                    dist: t,
                    albedo: vec3(1.0, 0.0, 0.0),
                    normal: calc_normal(p, e),
                    ..Default::default()
                },
            };

            return res;
        }
        if t > TMAX {
            break;
        }
        t += h.x;
    }

    return res;
}

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] nosie_tx: Tex,
    #[spirv(descriptor_set = 1, binding = 1)] noise_sampler: &Sampler,
    output: &mut Vec4,
) {
    let mut col: Vec3 = render(pos, camera, globals, nosie_tx, noise_sampler);

    col = col.powf(1.0 / 2.2);
    col = robobo_1221_tonemap(col);
    col = col.powf(2.2);

    col = col.clamp(Vec3::ZERO, Vec3::ONE);

    *output = col.extend(1.0);
}

#[spirv(vertex)]
pub fn vs(#[spirv(vertex_index)] vert_idx: i32, #[spirv(position)] output: &mut Vec4) {
    fn full_screen_triangle(vert_idx: i32) -> Vec4 {
        let uv = vec2(((vert_idx << 1) & 2) as f32, (vert_idx & 2) as f32);
        let pos = 2.0 * uv - Vec2::ONE;

        pos.extend(0.0).extend(1.0)
    }

    *output = full_screen_triangle(vert_idx);
}
