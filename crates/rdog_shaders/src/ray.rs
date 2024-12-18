// TODO remove all pow
use rdog_lib::prelude::*;
use spirv_std::num_traits::Pow;

pub const HPI: f32 = PI * 0.5; // TODO move out

const REALTIME_ATMOS: bool = false;

const RMAX: u32 = 300;
const TMAX: f32 = 22.0;
const DIFFUSE_STEPS: u32 = 8;
const SCATTER_STEPS: u32 = 8;
const BRDF_STEPS: u32 = 8;

const LIGHT_POS: Vec3 = vec3(0.0, 1.5, 2.5);
const LIGHT_RAD: f32 = 1.0;

#[derive(Copy, Clone)]
struct G {
    el: f32,
    _dt: f32,
    seed: UVec2,
}

impl G {
    pub fn from(g: &Globals) -> Self {
        G {
            el: g.time.x,
            _dt: g.time.y,
            seed: g.seed,
        }
    }

    pub fn with_seed(&self, seed: UVec2) -> Self {
        G {
            el: self.el,
            _dt: self._dt,
            seed,
        }
    }
}

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
    _dist: f32,
    pos: Vec3,
    radius: f32,
}

// TODO TEMP PUB
#[allow(unused)]
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

fn lookup_mat(r: Ray, p: Vec3, h: Vec2, t: f32, g: &G) -> Material {
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

fn light_map(posi: Vec3, _g: &G) -> Light {
    let dist = sphere(posi - LIGHT_POS, LIGHT_RAD);

    Light {
        _dist: dist,
        pos: LIGHT_POS,
        radius: LIGHT_RAD,
    }
}

fn shape(posi: Vec3, g: &G) -> f32 {
    let pos = aar(
        posi + Vec3::NEG_Y,
        vec3(0.0, 0.8, 1.0).normalize(),
        g.el * 0.5,
    );
    let po = aar(pos, vec3(0.0, 0.0, 1.0).normalize(), 90.0_f32.to_radians());
    let pp = aar(pos, vec3(1.0, 0.0, 0.0).normalize(), 45.0_f32.to_radians());
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    op_smooth_union(o, r, 0.1)
}

// float sdPlane( vec3 p, vec4 n )
// {
//   // n must be normalized
//   return dot(p,n.xyz) + n.w;
// }
fn plane(pos: Vec3, n: Vec4) -> f32 {
    pos.dot(n.xyz()) + n.w
}

fn map(posi: Vec3, g: &G) -> Vec2 {
    let l = sphere(posi - LIGHT_POS, LIGHT_RAD);
    let s = shape(posi, g);
    let p = plane(posi, vec4(0.0, 1.0, 0.0, 0.9));

    let l = vec2(l, 999.0);
    let s = vec2(s, 2.0);
    let p = vec2(p, 3.0);

    min_sd(min_sd(l, s), p)
}

fn calc_normal(pos: Vec3, g: &G) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (0. + e.xyy() * map(pos + ep * e.xyy(), g).x
        + e.yyx() * map(pos + ep * e.yyx(), g).x
        + e.yxy() * map(pos + ep * e.yxy(), g).x
        + e.xxx() * map(pos + ep * e.xxx(), g).x)
        .normalize()
}

fn _robobo_1221_tonemap(color: Vec3) -> Vec3 {
    let l = color.length();

    let mut color = color;
    color = color.mix(color * 0.5, l / (l + 1.0));
    _r_t_operator(color)
}

#[inline]
fn _r_t_operator(x: Vec3) -> Vec3 {
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

    globals: &G,

    atmos_tx: Tex,
    atmos_sampler: &Sampler,

    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

    // let uv = (2.0 * pos - camera.screen).xy() / camera.screen.y;
    // let uv = uv * -1.0;
    let time = globals.el * 0.5;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -5.0));

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

fn t(s: f32) -> Vec3 {
    Vec3::new(0.233, 0.455, 0.649) * (-s * s / 0.0064).exp()
        + Vec3::new(0.1, 0.336, 0.344) * (-s * s / 0.0484).exp()
        + Vec3::new(0.118, 0.198, 0.0) * (-s * s / 0.187).exp()
        + Vec3::new(0.113, 0.007, 0.007) * (-s * s / 0.567).exp()
        + Vec3::new(0.358, 0.004, 0.0) * (-s * s / 1.99).exp()
        + Vec3::new(0.078, 0.0, 0.0) * (-s * s / 7.41).exp()
}

fn sample_direct_diff_spherical(p: Vec3, n: Vec3, uv: Vec2, camera: &Camera, g: &G) -> Vec3 {
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

fn spec_brdf(
    pos: Vec3,
    v: Vec3,
    n: Vec3,
    roughness: f32,
    f0: f32,
    uv: Vec2,
    fresnel: &mut f32,
    atmos_tx: Tex,
    atmos_sampler: &Sampler,
    noise_tx: Tex,
    noise_sampler: &Sampler,
    camera: &Camera,
    g: &G,
) -> Vec3 {
    let mut specular_light = Vec3::ZERO;

    let alpha = roughness * roughness;
    let alpha2 = alpha * alpha;
    let k_direct = (alpha2 + 1.0) / 8.0;
    let k_ibl = alpha / 2.0;

    for i in 0..BRDF_STEPS {
        let h = sample_brdf(
            n,
            alpha2,
            uv + vec2(1.220, 2.530),
            camera,
            &g.with_seed(g.seed + i + 5),
        );
        let v_dot_h = v.dot(h).max(0.000001);
        let l = (2.0 * v_dot_h) * (h - v);
        let n_dot_v = n.dot(v).max(0.0);
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = Ray::new(pos, l);

            let hit = hit(sr, g);

            let in_radiance = if hit.dist >= TMAX || hit.emissive > 0.0 {
                sample_atmos(
                    sr,
                    uv,
                    atmos_tx,
                    atmos_sampler,
                    noise_tx,
                    noise_sampler,
                    camera,
                    g,
                )
            } else {
                hit.albedo
                    * (sample_direct_diff_spherical(
                        pos + (l * hit.dist),
                        hit.normal,
                        uv + vec2(1.2377, 1.2377),
                        camera,
                        &g.with_seed(g.seed + i + 10),
                    ) + sample_indirect_diff(
                        pos + (l * hit.dist),
                        hit.normal,
                        uv + vec2(3.223, 3.225),
                        camera,
                        &g.with_seed(g.seed + i + 10),
                        atmos_tx,
                        atmos_sampler,
                        noise_tx,
                        noise_sampler,
                    ))
            };

            *fresnel = f0 + (1.0 - f0) * (1.0 - n_dot_v).pow(5.0);
            let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_ibl);
            specular_light += in_radiance * (g_term * *fresnel * v_dot_h / (n_dot_h * n_dot_v));
        }

        let cl = light_map(pos, g);
        let l = spherical_light_sample(cl, pos, uv, camera, g.seed.y + i);
        let h = (v + l) / (v + l).length();
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = Ray::new(pos, l);
            let hit = hit(sr, g);

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

fn sample_atmos(
    sr: Ray,
    _uv: Vec2,
    atmos_tx: Tex,
    atmos_sampler: &Sampler,
    _noise_tx: Tex,
    _noise_sampler: &Sampler,
    _camera: &Camera,
    _g: &G,
) -> Vec3 {
    if REALTIME_ATMOS {
        // in_radiance = albedo
        //     * calc_atmosphere2(
        //         (sr.o + sr.d * 10.0).normalize(),
        //         uv - camera.screen.xy(),
        //         g,
        //         noise_tx,
        //         noise_sampler,
        //     );
        Vec3::ZERO
    } else {
        sample(
            atmos_tx,
            atmos_sampler,
            world_space_to_uv(sr.o + sr.d * 1000.0) + vec2(0.0, 0.02),
        )
        .xyz()
    }
}

fn sample_brdf(normal: Vec3, alpha2: f32, uv: Vec2, camera: &Camera, g: &G) -> Vec3 {
    let u0 = rng01(uv.xy() + vec2(0.0, 0.0), g.seed.y, camera.screen.y as u32);
    let u1 = rng01(uv.yx() + vec2(1.3, 2.7), g.seed.y, camera.screen.y as u32);

    let cos_theta = ((1.0 - u0) / ((alpha2 - 1.0) * u0 + 1.0)).sqrt();
    let sin_theta = ((1.0 - (cos_theta * cos_theta)).max(0.0)).sqrt();
    let phi = u1 * 2.0 * PI;

    translate_to_ws(
        vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta),
        normal,
    )
}

fn sample_scattering(pos: Vec3, n: Vec3, uv: Vec2, camera: &Camera, g: &G) -> Vec3 {
    let p1 = pos - (n * 0.02);

    let cl = light_map(p1, g);

    let mut out = Vec3::ZERO;

    for i in 0..SCATTER_STEPS {
        let l = spherical_light_sample(cl, p1, uv, camera, g.seed.y + i);

        // let p1 = p1 + l;

        let sr = Ray::new(p1, l);
        let h = hit_transparrent(sr, g);

        let sr = Ray::new(p1 + (l * h.dist) + (0.03 * l), l);

        let h1 = hit(sr, g);

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

fn sample_indirect_diff(
    p: Vec3,
    n: Vec3,
    uv: Vec2,
    camera: &Camera,
    g: &G,
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
            t += albedo
                * sample_atmos(
                    sr,
                    uv,
                    atmos_tx,
                    atmos_sampler,
                    noise_tx,
                    noise_sampler,
                    camera,
                    g,
                );
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

fn get_random_sample(uv: Vec2, camera: &Camera, g: &G) -> Vec3 // cosine weighted uniform distribution
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
    g: &G,
    atmos_tx: Tex,
    atmos_sampler: &Sampler,
    noise_tx: Tex,
    noise_sampler: &Sampler,
) -> Vec3 {
    let res = hit(r, g);

    if res.dist >= TMAX {
        return sample_atmos(
            r,
            uv,
            atmos_tx,
            atmos_sampler,
            noise_tx,
            noise_sampler,
            camera,
            g,
        );
    }

    if res.id > 900.0 {
        return res.albedo;
    }

    let mut diffuse = Vec3::ZERO;
    let mut scattering = Vec3::ZERO;
    let mut specular = Vec3::ZERO;
    let mut fresnel = 0.0;

    let v = -r.d;
    let pos = r.o + r.d * res.dist;

    if res.diffuse_scale > 0.0 {
        diffuse = res.diffuse_scale
            * res.albedo
            * (sample_direct_diff_spherical(pos, res.normal, uv, camera, g)
                + sample_indirect_diff(
                    pos,
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

    if res.specular_scale > 0.0 {
        specular = res.specular_scale
            * spec_brdf(
                pos,
                v,
                res.normal,
                res.roughness,
                res.f0,
                uv - vec2(1.0, 1.0),
                &mut fresnel,
                atmos_tx,
                atmos_sampler,
                noise_tx,
                noise_sampler,
                camera,
                g,
            );
    }

    // let mut col = Vec3::ZERO;
    //
    // let pos = ro + res.dist * rd;
    // // col = calc_normal(pos, time);
    // let norm = res.normal;
    return (1.0 - fresnel) * (scattering + diffuse) + specular;
    // return specular;
}

fn hit_transparrent(r: Ray, g: &G) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    let mut res = Material::default();

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let mut h = map(p, g);
        h.x *= -1.0;

        if h.x < 0.002 {
            return lookup_mat(r, p, h, t, g);
        }

        if t > TMAX {
            break;
        }

        t += h.x
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

fn hit(r: Ray, g: &G) -> Material {
    // TODO - change to a Material struct
    let mut t = 0.0;

    let res = Material::default();

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

    res
}

fn srgb(channel: f32) -> f32 {
    if channel <= 0.00031308 {
        channel * 12.92
    } else {
        1.055 * channel.pow(1.0 / 2.4) - 0.055
    }
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
        &G::from(globals),
        atmos_tx,
        atmos_sampler,
        nosie_tx,
        noise_sampler,
    );

    col = vec3(srgb(col.x), srgb(col.y), srgb(col.z));
    // todo figure out how to improve tone mapping
    // col = col.pow(1.0 / 2.2);
    // col = robobo_1221_tonemap(col);
    // col = col.pow(2.2);

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
