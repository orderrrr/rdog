pub use rdog_lib::prelude::*;
use spirv_std::num_traits::Pow;

use crate::direct::{sample_indirect_diff, spherical_light_sample};

fn d_term_ggxtr(n_dot_h: f32, alpha: f32) -> f32 {
    let alpha = n_dot_h * alpha;
    let kappa = alpha / (n_dot_h * n_dot_h * (alpha * alpha - 1.0) + 1.0);
    kappa * kappa / PI
}

fn g_term_schlick_ggx(n_dot_v: f32, n_dot_l: f32, k: f32) -> f32 {
    let g_term_v = n_dot_v / (n_dot_v * (1.0 - k) + k);
    let g_term_l = n_dot_l / (n_dot_l * (1.0 - k) + k);
    g_term_v * g_term_l
}

fn sample_brdf(
    normal: Vec3,
    alpha2: f32,
    uv: Vec2,
    camera: &Camera,
    _el: f32,
    seed: UVec2,
) -> Vec3 {
    let u0 = rng01(uv.xy() + vec2(0.0, 0.0), seed.y, camera.screen.y as u32);
    let u1 = rng01(uv.yx() + vec2(1.3, 2.7), seed.y, camera.screen.y as u32);

    let cos_theta = ((1.0 - u0) / ((alpha2 - 1.0) * u0 + 1.0)).sqrt();
    let sin_theta = ((1.0 - (cos_theta * cos_theta)).max(0.0)).sqrt();
    let phi = u1 * 2.0 * PI;

    translate_to_ws(
        vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta),
        normal,
    )
}

fn spec_brdf(
    pos: Vec3,
    v: Vec3,
    n: Vec3,
    roughness: f32,
    f0: f32,
    uv: Vec2,
    fresnel: &mut f32,
    camera: &Camera,
    el: f32,
    seed: UVec2,
) -> Vec3 {
    let mut specular_light = Vec3::ZERO;

    let alpha = roughness * roughness;
    let alpha2 = alpha * alpha;
    let k_direct = (alpha2 + 1.0) / 8.0;
    let k_ibl = alpha / 2.0;

    for i in 0..BRDF_STEPS + 1 {
        let h = sample_brdf(n, alpha2, uv + vec2(1.220, 2.530), camera, el, seed + i + 5);
        let v_dot_h = v.dot(h).max(0.000001);
        let l = (2.0 * (v_dot_h * h)) - v;
        let n_dot_v = n.dot(v).max(0.0);
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = Ray::new(pos + (l * 0.02), l);
            let hit = hit(sr, el, seed);

            let in_radiance = if hit.dist >= TMAX {
                sample_atmos(sr)
            } else if hit.emissive > 0.0 {
                hit.albedo
            } else {
                hit.albedo
                    * sample_indirect_diff(
                        pos + (l * hit.dist),
                        hit.normal,
                        uv,
                        DIFFUSE_BOUNCES,
                        camera,
                        el,
                        seed + i + 30,
                    )
            };

            *fresnel = f0 + (1.0 - f0) * (1.0 - n_dot_v).pow(5.0);
            let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_ibl);
            specular_light += in_radiance * (g_term * (*fresnel) * v_dot_h / (n_dot_h * n_dot_v));
        }

        let cl = light_map(pos, el, seed);
        let l = spherical_light_sample(cl, pos, uv, camera, seed.y + i);
        let h = (v + l) / (v + l).length();
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = Ray::new(pos, l);
            let hit = hit(sr, el, seed);

            if hit.emissive > 0.0 {
                let attn = 1.0 / (hit.dist * hit.dist);
                let in_radiance = hit.albedo * hit.emissive * attn;
                let d_term = d_term_ggxtr(n_dot_h, alpha);
                let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
                specular_light += in_radiance * g_term * *fresnel * d_term / (4.0 / n_dot_v);
            }
        }
    }

    specular_light / BRDF_STEPS as f32
}

fn get_color(r: Ray, uv: Vec2, camera: &Camera, el: f32, seed: UVec2, fresnel: &mut f32) -> Vec3 {
    let res = hit(r, el, seed);

    if res.dist >= TMAX {
        // TODO - back to atmos
        return sample_atmos(r);
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let v = -r.d;

    let pos = r.pd(res.dist);

    if res.specular_scale > 0.0 {
        res.specular_scale
            * spec_brdf(
                pos,
                v,
                res.normal,
                res.roughness,
                res.f0,
                uv - vec2(1.0, 1.0),
                fresnel,
                camera,
                el,
                seed,
            )
    } else {
        // vec3(1.0, 0.0, 1.0)
        Vec3::ZERO
    }
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] _params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16,
) {
    let inp = out.read(global_id.xy().as_ivec2());

    let pos = global_id.xy().as_vec2();

    let mut r = ray(camera.screen.xy(), camera.ndc_to_world, global_id.xy());
    r.o = (inp.w * r.d) + r.o;

    if inp.w >= TMAX {
        unsafe {
            out.write(global_id.xy(), sample_atmos(r).extend(inp.w));
        }
        return;
    }

    let mut fresnel = 0.0;
    let col = get_color(r, pos, camera, globals.time.x, globals.seed, &mut fresnel);
    let col = (1.0 - fresnel) * inp.xyz() + col;

    unsafe {
        out.write(global_id.xy(), col.extend(1.0));
    }
}
