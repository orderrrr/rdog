pub use rdog_lib::prelude::*;

pub fn spherical_light_sample(cl: Light, p: Vec3, uv: Vec2, camera: &Camera, seed: u32) -> Vec3 {
    let u0 = rng01(uv.xy() + vec2(2.0, 3.0), seed, camera.screen.x as u32).c(0.0, 1.0);
    let u1 = rng01(uv.yx() - vec2(1.0, 1.0), seed, camera.screen.x as u32).c(0.0, 1.0);

    let d = (cl.pos - p).length();
    let lv = (cl.pos - p) / d;

    let sin_theta_max_sq = (cl.radius * cl.radius) / (d * d);
    let cos_theta_max = (1.0 - sin_theta_max_sq).max(0.0).sqrt();

    let cos_theta = (u0 * cos_theta_max) + (1.0 - u0);
    let sin_theta = (1.0 - (cos_theta * cos_theta)).max(0.0).sqrt();
    let phi = u1 * 2.0 * PI;

    let sample_direction = vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta);

    translate_to_ws(sample_direction, lv)
}

pub fn get_random_sample(uv: Vec2, camera: &Camera, _el: f32, seed: UVec2) -> Vec3 {
    let ct = (1.0 - rng01(uv.xy(), seed.y, camera.screen.y as u32)).sqrt();
    let st = (1.0 - (ct * ct)).max(0.0).sqrt();
    let phi = rng01(uv.yx(), seed.y, camera.screen.y as u32) * 2.0 * PI;
    return vec3((phi).cos() * st, ct, (phi).sin() * st);
}

pub fn sample_indirect_diff(
    p: Vec3,
    n: Vec3,
    uv: Vec2,
    bounces: u32,
    camera: &Camera,
    el: f32,
    seed: UVec2,
) -> Vec3 {
    let mut t = sample_direct_diff_spherical(p, n, uv + vec2(1.2233, 2.111), camera, el, seed);
    let mut albedo = Vec3::splat(1.0);
    let mut p = p;
    let mut n = n;

    for i in 0..bounces + 1 {
        let l = translate_to_ws(get_random_sample(uv, camera, el, seed + (i * 2)), n);
        let cos_theta = n.dot(l).max(0.0); // TODO - this can sometimes be negative...
        let sr = Ray::new(p, l);
        let h = hit(sr, el, seed);

        // TODO put sampling into some kind of helper
        if h.dist >= TMAX {
            t += albedo * cos_theta * sample_atmos(sr);
            break;
        }

        // // todo && i > 0??
        if h.emissive > 0.0 {
            t += albedo * cos_theta;
            break;
        }

        albedo *= h.albedo;
        n = h.normal;
        p = sr.pd(h.dist);
        t += albedo * cos_theta * sample_direct_diff_spherical(p, n, uv, camera, el, seed);
    }

    return t;
}

fn sample_direct_diff_spherical(
    p: Vec3,
    n: Vec3,
    uv: Vec2,
    camera: &Camera,
    el: f32,
    seed: UVec2,
) -> Vec3 {
    let cl = light_map(p, el, seed);

    // assumed spherical
    let l = spherical_light_sample(cl, p, uv, camera, seed.y);

    let cos_theta = n.dot(l);
    if cos_theta < 0.0 {
        return Vec3::ZERO;
    }

    let lsr = Ray::new(p + l, l);
    let hit = hit(lsr, el, seed);

    let attenuation = hit.dist / cl.radius + 1.0; // direct light attenuation factor

    if hit.emissive > 0.0 {
        hit.albedo * cos_theta / (attenuation * attenuation)
    } else {
        Vec3::ZERO
    }
}

fn get_color(r: Ray, uv: Vec2, camera: &Camera, el: f32, seed: UVec2) -> Vec3 {
    let res = hit(r, el, seed);

    if res.dist >= TMAX {
        // TODO - back to atmos
        return sample_atmos(r);
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let pos = r.o + r.d * res.dist;

    if res.diffuse_scale > 0.0 {
        res.diffuse_scale
            * res.albedo
            * (sample_indirect_diff(pos, res.normal, uv, DIFFUSE_BOUNCES, camera, el, seed))
    } else {
        vec3(1.0, 0.0, 1.0)
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

    if inp.w >= TMAX {
        return;
    }

    let pos = global_id.xy().as_vec2();
    let mut r = ray(camera.screen.xy(), camera.ndc_to_world, global_id.xy());
    r.o = (r.d * inp.w) + r.o;
    let col = get_color(r, pos, camera, globals.time.x, globals.seed);

    unsafe {
        out.write(global_id.xy(), col.extend(inp.w));
    }
}
