use rdog_lib::prelude::*;
use spirv_std::glam::{Vec2, Vec4};

use crate::atmosphere::{calc_atmosphere2, HPI};

const REALTIME_ATMOS: bool = false;

const RMAX: u32 = 300;
const TMAX: f32 = 22.0;
const DIFFUSE_STEPS: u32 = 8;

#[derive(Copy, Clone)]
struct Ray {
    o: Vec3,
    d: Vec3,
}

impl Ray {
    fn new(o: Vec3, d: Vec3) -> Self {
        Ray { o, d }
    }
}

#[derive(Copy, Clone)]
struct Light {
    dist: f32,
    pos: Vec3,
    radius: f32,
}

// TODO TEMP PUB
struct Material {
    id: f32,
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

fn light_map(posi: Vec3, _g: &Globals) -> Light {
    let pos = vec3(-2.0, 1.0, 1.0);
    let radius = 0.5;

    let dist = sphere(posi - pos, radius);

    Light { dist, pos, radius }
}

fn map(posi: Vec3, g: &Globals) -> Vec2 {
    let pos = axis_angle_rotate(
        posi + vec3(0.0, -1.0, 0.0),
        vec3(0.2, 0.6, 1.5).normalize(),
        g.time.x * 0.5,
    );

    let po = axis_angle_rotate(pos, vec3(0.0, 0.0, 1.0).normalize(), 90.0_f32.to_radians());
    let pp = axis_angle_rotate(pos, vec3(1.0, 0.0, 0.0).normalize(), 45.0_f32.to_radians());

    let d = 0.35;
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -d), 0.3, 0.1, 0.1);

    let r = sd_rounded_cylinder(po + vec3(-d, 0.0, d), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-d, 0.0, d), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    let ld = sphere(posi - vec3(-2.0, 1.0, 1.0), 0.5);

    let u = op_smooth_union(o, r, 0.1);

    if ld > u {
        vec2(u, 2.0)
    } else {
        vec2(ld, 999.0)
    }
}

fn calc_normal(pos: Vec3, g: &Globals) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (0. + e.xyy() * map(pos + ep * e.xyy(), g).x
        + e.yyx() * map(pos + ep * e.yyx(), g).x
        + e.yxy() * map(pos + ep * e.yxy(), g).x
        + e.xxx() * map(pos + ep * e.xxx(), g).x)
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

fn calculate_derivatives(rd: Vec3, step_size: f32) -> (Vec3, Vec3) {
    // Calculate tangent vectors perpendicular to ray direction
    let temp = if rd.x.abs() < 0.9 { Vec3::X } else { Vec3::Y };
    let tangent = rd.cross(temp).normalize();
    let bitangent = rd.cross(tangent);

    // Approximate derivatives using small offsets along tangent vectors
    let dpdx = tangent * step_size;
    let dpdy = bitangent * step_size;

    (dpdx, dpdy)
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

fn cart_to_sphere(v: Vec3) -> Vec3 {
    let normalized = v.normalize();
    Vec3::new(
        normalized.z.atan2(normalized.x),
        normalized.y.asin(),
        v.length(),
    )
}

fn world_space_to_uv(world_pos: Vec3) -> Vec2 {
    let spherical = cart_to_sphere(world_pos);
    let ndc = Vec2::new(spherical.x / PI, spherical.y / HPI);
    (ndc + Vec2::ONE) * 0.5
}

fn render(
    pos: Vec4,

    camera: &Camera,

    globals: &Globals,

    atmos_tx: Tex,
    atmos_sampler: &Sampler,

    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

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

    let r = Ray::new(ro, rd);

    get_color(
        r,
        pos.xy(),
        camera,
        globals,
        atmos_tx,
        atmos_sampler,
        noise_tx,
        noise_sampler,
    )
}

fn translate_to_ws(d: Vec3, n: Vec3) -> Vec3 {
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

// fn rand_float(seed: Vec2, g: &Globals) -> f32 {
//     ((seed + Vec2::splat(g.time.x))
//         .dot(vec2(12.9898, 78.233))
//         .sin()
//         * 43758.5453)
//         .fract()
// }

fn spherical_light_sample(cl: Light, p: Vec3, uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 {
    let u0 = rng01(uv + vec2(1.0, 1.0), g.seed.y, camera.screen.y as u32);
    let u1 = rng01(uv - vec2(1.0, 1.0), g.seed.y, camera.screen.y as u32);
    // let u0 = rand_float(uv + vec2(1.0, 2.0), g); // TODO don't use this one
    // let u1 = rand_float(uv - vec2(1.0, 1.0), g);

    // let d = (cl.pos - p).length(); // TODO use one provided by light
    let d = cl.dist;
    let lv = (cl.pos - p) / d;

    let sin_theta_max_sq = (cl.radius * cl.radius) / (d * d);
    let cos_theta_max = (1.0 - sin_theta_max_sq).max(0.0).sqrt();

    let cos_theta = (u0 * cos_theta_max) + (1.0 - u0);
    let sin_theta = (1.0 - (cos_theta * cos_theta)).max(0.0).sqrt();
    let phi = u1 * 2.0 * PI;

    let sample_direction = vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta);

    translate_to_ws(sample_direction, lv)
}

fn t(s: f32) -> Vec3 {
    Vec3::new(0.233, 0.455, 0.649) * (-s * s / 0.0064).exp()
        + Vec3::new(0.1, 0.336, 0.344) * (-s * s / 0.0484).exp()
        + Vec3::new(0.118, 0.198, 0.0) * (-s * s / 0.187).exp()
        + Vec3::new(0.113, 0.007, 0.007) * (-s * s / 0.567).exp()
        + Vec3::new(0.358, 0.004, 0.0) * (-s * s / 1.99).exp()
        + Vec3::new(0.078, 0.0, 0.0) * (-s * s / 7.41).exp()
}

fn sample_direct_diff_spherical(p: Vec3, n: Vec3, uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 {
    let cl = light_map(p, g);

    // assumed spherical
    let l = spherical_light_sample(cl, p, uv, camera, g);

    let cos_theta = n.dot(l);
    if cos_theta < 0.0 {
        return Vec3::ZERO;
    }

    let lsr = Ray::new(p + l, l);
    let hit = hit(lsr, &g);

    let attenuation = hit.dist / cl.radius + 0.5; // direct light attenuation factor

    if hit.emissive > 0.0 {
        hit.albedo * cos_theta / (attenuation * attenuation)
    } else {
        Vec3::ZERO
    }
}

fn sample_scattering(pos: Vec3, n: Vec3, uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 {
    let scale = 3.0;
    let bias = 0.01;
    let p1 = pos - (n * 0.005);

    let cl = light_map(p1, g);
    let l = spherical_light_sample(cl, p1, uv, camera, g);

    let mut sr = Ray::new(p1 + l, l);
    let h = hit(sr, g);

    let n1 = -h.normal;

    let cos_theta = n1.dot(l);
    sr.o = p1 + l * h.dist;

    let h1 = hit(sr, g);

    if h1.emissive > 0.0 {
        let s = scale * (h.dist + bias);
        let e = (0.3 + cos_theta).max(0.0);
        let a = 2.0 / (h1.dist * h1.dist);

        return t(s) * e * a * h1.albedo;
    }

    Vec3::ZERO
}

fn sample_indirect_diff(
    p: Vec3,
    v: Vec3,
    n: Vec3,
    uv: Vec2,
    camera: &Camera,
    g: &Globals,
    atmos_tx: Tex,
    atmos_sampler: &Sampler,
    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let mut t = Vec3::ZERO;
    let mut albedo = Vec3::splat(1.0);
    let mut p = p;
    let mut n = n;

    for i in 0..DIFFUSE_STEPS {
        let l = translate_to_ws(get_random_sample(uv + (i as f32), camera, g), n);
        let cos_theta = n.dot(l);
        let sr = Ray::new(p + l, l);
        let h = hit(sr, g);

        // TODO put sampling into some kind of helper
        if h.dist >= TMAX {
            let coord = sr.o + sr.d;

            if REALTIME_ATMOS {
                t += albedo
                    * calc_atmosphere2(
                        (coord * 10.0).normalize(),
                        uv - camera.screen.xy(),
                        g,
                        noise_tx,
                        noise_sampler,
                    );
            } else {
                t += albedo
                    * sample(
                        atmos_tx,
                        atmos_sampler,
                        world_space_to_uv(coord * 1000.0) - vec2(0.0, 0.02),
                    )
                    .xyz();
            }

            // continue;
            break;
        }

        // // todo && i > 0??
        if h.emissive > 0.0 && i > 0 {
            t += albedo * cos_theta;
            // continue;
            break;
        }

        albedo *= h.albedo;
        n = h.normal;
        p = sr.o + sr.d * h.dist;
        t += albedo * cos_theta * sample_direct_diff_spherical(p, n, uv, camera, g);
    }

    return t;
}

fn get_random_sample(uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 // cosine weighted uniform distribution
{
    let cos_theta = (1.0 - rng01(uv.xy(), g.seed.y, camera.screen.y as u32)).sqrt();
    let sin_theta = (1.0 - (cos_theta * cos_theta)).max(0.0).sqrt();
    let phi = rng01(uv.yx(), g.seed.y, camera.screen.y as u32) * 2.0 * PI;

    return vec3((phi).cos() * sin_theta, cos_theta, (phi).sin() * sin_theta);
}

fn get_color(
    r: Ray,
    uv: Vec2,
    camera: &Camera,
    g: &Globals,
    atmos_tx: Tex,
    atmos_sampler: &Sampler,
    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let res = hit(r, g);

    if res.dist >= TMAX {
        if REALTIME_ATMOS {
            let coord = r.o + r.d * 10.0;
            return calc_atmosphere2(
                coord.normalize(),
                uv - camera.screen.xy(),
                g,
                noise_tx,
                noise_sampler,
            );
        } else {
            let coord = r.o + r.d * 1000.0;

            return sample(
                atmos_tx,
                atmos_sampler,
                world_space_to_uv(coord) - vec2(0.0, 0.02),
            )
            .xyz();
        }
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let mut diffuse = Vec3::ZERO;
    let mut scattering = Vec3::ZERO;

    let v = -r.d;
    let pos = r.o + r.d * res.dist;

    if res.diffuse_scale > 0.0 {
        diffuse = res.diffuse_scale
            * res.albedo
            * (sample_direct_diff_spherical(pos, res.normal, uv, camera, g)
                + sample_indirect_diff(
                    pos,
                    v,
                    res.normal,
                    uv,
                    camera,
                    g,
                    atmos_tx,
                    atmos_sampler,
                    noise_tx,
                    noise_sampler,
                ));
    }

    if res.scattering_weight > 0.0 {
        scattering = res.scattering_weight
            * res.scattering_color
            * sample_scattering(pos, res.normal, uv + vec2(1.325, 2.4), camera, g);
    }

    // let mut col = Vec3::ZERO;
    //
    // let pos = ro + res.dist * rd;
    // // col = calc_normal(pos, time);
    // let norm = res.normal;
    return scattering;
}

fn hit(r: Ray, g: &Globals) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.;

    let mut res = Material::default();

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let h = map(p, g);
        if h.x < 0.001 {
            res = match h.y {
                2.0 => Material {
                    id: h.y,
                    dist: t,
                    scattering_weight: 1.0,
                    scattering_color: Vec3::splat(1.0),
                    normal: calc_normal(p, g),
                    albedo: vec3(1.0, 0.0, 0.0),
                    ..Default::default()
                },
                999.0 => Material {
                    id: h.y,
                    dist: t,
                    emissive: 8.0,
                    albedo: vec3(1.0, 1.0, 1.0),
                    ..Default::default()
                },
                _ => Material {
                    id: h.y,
                    dist: t,
                    albedo: vec3(1.0, 1.0, 1.0),
                    normal: calc_normal(p, g),
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

    // check if we hit the floor
    let tp1 = (-0.9 - r.o.y) / r.d.y;
    if tp1 > 0.0 {
        res.dist = tp1;
        res.normal = vec3(0.0, 1.0, 0.0);
        let pos = r.o + res.dist * r.d;

        let (dpdx, dpdy) = calculate_derivatives(r.d, 0.01);

        let f = checkers_grad_box(3.0 * pos.xz(), 3.0 * dpdx.xz(), 3.0 * dpdy.xz());
        res.albedo = 0.15 + f * Vec3::splat(0.05);
    }

    res
}

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] atmos_tx: Tex,
    #[spirv(descriptor_set = 1, binding = 1)] atmos_sampler: &Sampler,
    #[spirv(descriptor_set = 1, binding = 2)] nosie_tx: Tex,
    #[spirv(descriptor_set = 1, binding = 3)] noise_sampler: &Sampler,
    output: &mut Vec4,
) {
    let mut col: Vec3 = render(
        pos,
        camera,
        globals,
        atmos_tx,
        atmos_sampler,
        nosie_tx,
        noise_sampler,
    );

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
