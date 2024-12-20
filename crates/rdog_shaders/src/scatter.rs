pub use rdog_lib::prelude::*;

fn spherical_light_sample(cl: Light, p: Vec3, uv: Vec2, camera: &Camera, seed: u32) -> Vec3 {
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

fn get_color(r: Ray, uv: Vec2, camera: &Camera, el: f32, seed: UVec2) -> Vec3 {
    let res = hit(r, el, seed);

    if res.dist >= TMAX {
        return sample_atmos(r);
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let pos = r.o + r.d * res.dist;

    if res.scattering_scale > 0.0 {
        res.scattering_scale
            * res.scattering_color
            * sample_scattering(pos, res.normal, uv + vec2(1.325, 2.4), camera, el, seed)
    } else {
        Vec3::ZERO
    }
}

fn hit_transparrent(r: Ray, el: f32, seed: UVec2) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let mut h = map(p, el, seed);
        h.x *= -1.0;

        if h.x < 0.002 {
            return lookup_mat(r, p, h, t, el, seed);
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    Material::default()
}

fn sample_scattering(pos: Vec3, n: Vec3, uv: Vec2, camera: &Camera, el: f32, seed: UVec2) -> Vec3 {
    let p1 = pos - (n * 0.02);

    let cl = light_map(p1, el, seed);

    let mut out = Vec3::ZERO;

    for i in 0..SCATTER_STEPS + 1 {
        let l = spherical_light_sample(cl, p1, uv, camera, seed.y + i);

        // let p1 = p1 + l;

        let sr = Ray::new(p1, l);
        let h = hit_transparrent(sr, el, seed);

        let sr = Ray::new(p1 + (l * h.dist) + (0.03 * l), l);

        let h1 = hit(sr, el, seed);

        if h1.emissive > 0.0 {
            let scale = 3.0;
            let bias = 0.01;

            let n1 = -h1.normal;
            let cos_theta = n1.dot(l);
            let s = scale * (h.dist + bias);

            let e = (0.3 + cos_theta).max(0.0);

            let a = 1.0 / (h1.dist * h1.dist);

            out += t(s) * e * a * (h1.albedo * h1.emissive);
        }
    }

    out / (SCATTER_STEPS as f32)
}

fn t(s: f32) -> Vec3 {
    Vec3::new(0.233, 0.455, 0.649) * (-s * s / 0.0064).exp()
        + Vec3::new(0.1, 0.336, 0.344) * (-s * s / 0.0484).exp()
        + Vec3::new(0.118, 0.198, 0.0) * (-s * s / 0.187).exp()
        + Vec3::new(0.113, 0.007, 0.007) * (-s * s / 0.567).exp()
        + Vec3::new(0.358, 0.004, 0.0) * (-s * s / 1.99).exp()
        + Vec3::new(0.078, 0.0, 0.0) * (-s * s / 7.41).exp()
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16<'_>,
) {
    let inp = out.read(global_id.xy().as_ivec2());

    if inp.w >= TMAX {
        unsafe {
            out.write(global_id.xy(), Vec3::splat(0.01).extend(inp.w));
        }
    }

    let pos = global_id.xy().as_vec2();
    let mut r = get_camera_ray(global_id.xy().as_vec2(), camera, globals.time.x);
    r.o = (inp.w * r.d) + r.o;

    let col = inp.xyz() + get_color(r, pos, camera, globals.time.x, globals.seed);
    let col = col.extend(inp.w);

    unsafe {
        out.write(global_id.xy(), col);
    }
}
