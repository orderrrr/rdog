pub use rdog_lib::prelude::*;

fn sample_direct_diff_spherical(p: Vec3, n: Vec3, uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 {
    let cl = light_map(p, g);

    // assumed spherical
    let l = spherical_light_sample(cl, p, uv, camera, g.seed.y);

    let cos_theta = n.dot(l);
    if cos_theta < 0.0 {
        return Vec3::ZERO;
    }

    let lsr = Ray::new(p + l, l);
    let hit = hit(lsr, g);

    let attenuation = hit.dist / cl.radius + 0.5; // direct light attenuation factor

    if hit.emissive > 0.0 {
        hit.albedo * cos_theta / (attenuation * attenuation)
    } else {
        Vec3::ZERO
    }
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

fn checker(v1: Vec3, v2: Vec3, r: Ray, t: f32) -> Vec3 {
    let pos = r.o + t * r.d;

    let (dpdx, dpdy) = calculate_derivatives(r.d, 0.01);
    let f = checkers_grad_box(3.0 * pos.xz(), 3.0 * dpdx.xz(), 3.0 * dpdy.xz());
    if f > 0.0 {
        v1
    } else {
        v2
    }
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

fn lookup_mat(r: Ray, p: Vec3, h: Vec2, t: f32, g: &Globals) -> Material {
    let s = if h.x >= 0.0 { 1.0 } else { 0.0 };

    match h.y {
        2.0 => Material {
            id: h.y,
            dist: t,
            scattering_weight: 1.0,
            scattering_color: Vec3::splat(1.0),
            specular_scale: 1.0,
            f0: 0.04,
            normal: calc_normal(p, g) * s,
            albedo: vec3(0.71, 0.65, 0.26),
            ..Default::default()
        },
        3.0 => Material {
            id: h.y,
            dist: t,
            scattering_weight: 0.0,
            scattering_color: Vec3::splat(1.0),
            specular_scale: 1.0,
            f0: 1.04,
            roughness: 0.0,
            normal: calc_normal(p, g) * s,
            albedo: checker(vec3(0.79, 0.70, 0.77), vec3(0.79, 0.70, 0.77) * 0.5, r, t),
            ..Default::default()
        },
        999.0 => Material {
            id: h.y,
            dist: t,
            emissive: 8.0,
            normal: calc_normal(p, g) * s,
            albedo: vec3(1.0, 1.0, 1.0),
            ..Default::default()
        },
        _ => Material {
            id: h.y,
            dist: t,
            albedo: vec3(1.0, 1.0, 1.0),
            specular_scale: 1.0,
            f0: 0.04,
            normal: calc_normal(p, g) * s,
            ..Default::default()
        },
    }
}

fn hit(r: Ray, g: &Globals) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let h = map(p, g);

        if h.x < 0.001 {
            return lookup_mat(r, p, h, t, g);
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    Material::default()
}

fn get_color(r: Ray, uv: Vec2, camera: &Camera, g: &Globals) -> Vec3 {
    // todo somehow don't calculate this every pass...
    // FIXME actually what could happen is the trace will output the diffuse scale, scattering weight and specular scale
    // in the vec4 output, which we can use to feed directly into the samplers.
    let res = hit(r, g);

    if res.dist >= TMAX {
        return Vec3::splat(0.1);
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let pos = r.o + r.d * res.dist;

    if res.diffuse_scale > 0.0 {
        sample_direct_diff_spherical(pos, res.normal, uv, camera, g)
    } else {
        Vec3::ZERO
    }
}

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

fn light_map(posi: Vec3, _g: &Globals) -> Light {
    let dist = sphere(posi - LIGHT_POS, LIGHT_RAD);

    Light {
        dist,
        pos: LIGHT_POS,
        radius: LIGHT_RAD,
    }
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16<'_>,
) {
    let pos = global_id.as_vec3();
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

    let time = globals.time.x * 0.5;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -5.0));

    let f = 1.5;

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, f))).normalize();

    let dist = out.read(global_id.xy().as_ivec2()).w;

    // start the ray right at the object
    let r = Ray::new(ro, rd);

    let col = get_color(r, uv, camera, globals).extend(dist);

    unsafe {
        out.write(global_id.xy(), col);
    }
}
