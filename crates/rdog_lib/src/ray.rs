use bytemuck::{Pod, Zeroable};
use spirv_std::num_traits::Pow;

use crate::prelude::*;

pub const DANGER: Vec3 = vec3(1.0, 0.0, 1.0);

pub const TMAX: f32 = 40.0;
pub const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, -2.0, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

pub const HPI: f32 = PI * 0.5; // TODO move out

#[derive(Copy, Clone)]
pub struct Ray {
    pub o: Vec3,
    pub d: Vec3,
    pub spos: Vec2,
    pub seed: UVec2,
}

impl Ray {
    pub fn new(o: Vec3, d: Vec3, pos: Vec2, seed: UVec2) -> Self {
        Ray {
            o,
            d,
            spos: pos,
            seed,
        }
    }

    pub fn pd(&self, t: f32) -> Vec3 {
        (self.d * t) + self.o
    }

    pub fn at(mut self, p: Vec3) -> Ray {
        self.o = p;
        self
    }

    pub fn dir(mut self, d: Vec3) -> Ray {
        self.d = d;
        self
    }

    pub fn offset_uv(mut self, offset: Vec2) -> Ray {
        self.spos += offset;
        self
    }

    pub fn offset_seed(mut self, offset: UVec2) -> Ray {
        self.seed += offset;
        self
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
    pub fn valid(&self) -> bool {
        self.normal().length() > 0.0 // means its an object.
    }

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

impl Material {
    pub fn scatter(&self, scene: &Scene, r: Ray) -> ScatterRes {
        // let dir = scene.random_on_hemisphere(self.normal(), r);
        let mut dir = translate_to_ws(
            scene.get_random_sample(r.offset_uv(vec2(-1.03322, 3.299))),
            self.normal(),
        );

        if self.specular() > 0.0 {
            let v = -r.d;
            let h = scene.sample_brdf(
                self.normal(),
                self.roughness().powf(4.0),
                r.offset_seed(uvec2(3, 2)).offset_uv(vec2(1.220, 2.530)),
            );

            let v_dot_h = v.dot(h).max(0.000001);
            dir = (2.0 * (v_dot_h * h)) - v;
        }

        ScatterRes::new(r.at(r.o + (dir * 0.02)).dir(dir), true, self.albedo())
    }
}

pub struct ScatterRes {
    ray: Ray,
    scatter: bool,
    albedo: Vec3,
}

impl ScatterRes {
    pub fn new(ray: Ray, scatter: bool, albedo: Vec3) -> Self {
        Self {
            ray,
            scatter,
            albedo,
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
    let _p = plane(posi, vec4(0.0, -1.0, 0.0, 3.0)); // TODO - readd

    let l = vec2(l, 0.0);
    let s = vec2(s, 1.0);
    // let p = vec2(p, 2.0);
    //
    // let s2 = vec2(sphere(posi - vec3(-1.0, 1.0, 0.0), 0.6), 3.0);

    // min_sd(min_sd(min_sd(l, s), p), s2)
    min_sd(l, s)
}

fn world_space_to_uv(world_pos: Vec3) -> Vec2 {
    let spherical = cart_to_sphere(world_pos);
    let ndc = Vec2::new(spherical.x / PI, spherical.y / HPI);
    (ndc + Vec2::ONE) * 0.5
}

fn cart_to_sphere(v: Vec3) -> Vec3 {
    let normalized = v.normalize();
    Vec3::new(
        normalized.z.atan2(normalized.x),
        normalized.y.asin(),
        v.length(),
    )
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

pub fn ray(ss: Vec2, ndc_to_world: Mat4, pos: Vec2, seed: UVec2) -> Ray {
    let sp = pos + vec2(0.5, 0.5);

    let ndc = sp * 2.0 / ss - Vec2::ONE;
    let ndc = vec2(ndc.x, ndc.y);

    let far_plane = ndc_to_world.project_point3(ndc.extend(f32::EPSILON));
    let near_plane = ndc_to_world.project_point3(ndc.extend(1.0));

    Ray::new(near_plane, (far_plane - near_plane).normalize(), pos, seed)
}

pub struct Scene<'a> {
    pub camera: &'a Camera,
    pub globals: &'a Globals,
    pub materials: &'a [Material],
    pub params: &'a PassParams,
    pub bounces: u32,
    pub atmos_tx: Tex<'a>,
    pub atmos_sampler: &'a Sampler,
}

impl<'a> Scene<'a> {
    pub fn new(
        camera: &'a Camera,
        globals: &'a Globals,
        materials: &'a [Material],
        params: &'a PassParams,
        bounces: u32,
        atmos_tx: Tex<'a>,
        atmos_sampler: &'a Sampler,
    ) -> Scene<'a> {
        Self {
            camera,
            globals,
            materials,
            params,
            bounces,
            atmos_tx,
            atmos_sampler,
        }
    }
}

impl Scene<'_> {
    #[inline(never)]
    pub fn trace(&self, r: Ray) -> Material {
        // TODO - change to a Material struct
        let mut t = 0.01;

        for _ in 0..RMAX {
            let p = r.pd(t);

            let h = self.map(p);

            if h.x < 0.001 {
                return self.lookup_mat(r, p, h, t, self.calc_normal(p));
            }

            if t > TMAX {
                break;
            }

            t += h.x
        }

        // let tp1 = (2.0 - r.o.y) / r.d.y;
        // if tp1 > 0.0 {
        //     return self
        //         .lookup_mat(r, r.pd(tp1), vec2(tp1, 2.0), t, Vec3::Y)
        //         .with_albedo(DANGER);
        //

        Material::default().with_albedo(DANGER)
    }

    pub fn rt(&self, r: Ray) -> Vec3 {
        let mut hit = self.trace(r);
        let mut r = r.at(r.pd(hit.dist()));

        let mut col = Vec3::splat(1.0);

        let mut iter = 0;

        if !hit.valid() {
            return self.sample_atmos(r);
        }

        loop {
            if iter > self.bounces {
                break;
            }

            if !hit.valid() {
                // col *= 1.0 / DANGER;
                col *= 1.0 / self.sample_atmos(r);
                break;
            }

            let scat = hit.scatter(&self, r.offset_seed(uvec2(iter, iter)));

            let mut scol = Vec3::ZERO;

            if hit.emissive() > 0.0 {
                col *= 1.0 / (hit.albedo() * hit.emissive());
                break;
            }

            if hit.diffuse() > 0.0 {
                scol += hit.diffuse()
                    * hit.albedo()
                    * self.sample_direct_diff_spherical(r, hit.normal());
            }

            if hit.scattering_scale() > 0.0 {
                scol += hit.scattering_scale()
                    * hit.scattering_color()
                    * self.sample_scattering(r, hit.normal());
            }

            col *= 1.0 / scol;

            if !scat.scatter {
                break;
            }

            r = scat.ray;
            hit = self.trace(r);
            r = r.at(r.pd(hit.dist()));
            iter += 1;
        }

        col = 1.0 / col;
        col
    }

    pub fn get_color(&self, r: Ray) -> Vec3 {
        let res = self.trace(r);

        if !res.valid() {
            // TODO - back to atmos
            return self.sample_atmos(r);
        }

        let pos = r.pd(res.dist());

        let mut fresnel = 0.0;
        let (mut diffuse, mut scatter, mut specular) = (Vec3::ZERO, Vec3::ZERO, Vec3::ZERO);

        let diffuse_pass: bool = ((self.params.flags >> 0) & 1) == 1;
        let scatter_pass: bool = ((self.params.flags >> 1) & 1) == 1;
        let specular_pass: bool = ((self.params.flags >> 2) & 1) == 1;

        if res.diffuse() > 0.0 && diffuse_pass {
            diffuse = res.diffuse()
                * res.albedo()
                * (self.sample_indirect_diff(r.clone().at(pos), res.normal()));
        }

        if res.scattering_scale() > 0.0 && scatter_pass {
            scatter = res.scattering_scale()
                * res.scattering_color()
                * self.sample_scattering(r.clone().at(pos), res.normal());
        }

        if res.specular() > 0.0 && specular_pass {
            let v = -r.d;
            specular = res.specular()
                * self.spec_brdf(
                    r.at(pos).offset_uv(vec2(1.0, -1.0)),
                    v,
                    res.normal(),
                    res.roughness(),
                    res.f0(),
                    &mut fresnel,
                );
        }

        return (1.0 - fresnel) * (diffuse + scatter) + specular;
    }

    pub fn map(&self, posi: Vec3) -> Vec2 {
        let l = sphere(posi - LIGHT_POS, LIGHT_RAD);
        let s = shape(posi, self.globals.time.x, self.globals.seed);
        let p = plane(posi, vec4(0.0, -1.0, 0.0, 3.0)); // TODO - readd

        let l = vec2(l, 0.0);
        let s = vec2(s, 1.0);
        let p = vec2(p, 2.0);

        let s2 = vec2(sphere(posi - vec3(-1.0, 1.0, 0.0), 0.6), 3.0);

        min_sd(min_sd(min_sd(l, s), s2), p)
    }

    pub fn lookup_mat(&self, _r: Ray, p: Vec3, h: Vec2, t: f32, normal: Vec3) -> Material {
        let i = h.y as usize;

        if i > self.materials.len() - 1 {
            return Material::default().with_normal(normal).with_dist(t);
        }

        self.materials[i].with_normal(normal).with_dist(t)
    }

    pub fn calc_normal(&self, pos: Vec3) -> Vec3 {
        let ep = 0.0001;
        let e = Vec2::new(1.0, -1.0) * 0.5773;

        (0. + e.xyy() * self.map(pos + ep * e.xyy()).x
            + e.yyx() * self.map(pos + ep * e.yyx()).x
            + e.yxy() * self.map(pos + ep * e.yxy()).x
            + e.xxx() * self.map(pos + ep * e.xxx()).x)
            .normalize()
    }

    pub fn spherical_light_sample(&self, cl: Light, r: Ray) -> Vec3 {
        let u0 = rng01(
            r.spos.xy() + vec2(2.0, 3.0),
            r.seed.y,
            self.camera.screen.x as u32,
        )
        .c(0.0, 1.0);
        let u1 = rng01(
            r.spos.yx() - vec2(1.0, 1.0),
            r.seed.y,
            self.camera.screen.x as u32,
        )
        .c(0.0, 1.0);

        let d = (cl.pos - r.o).length();
        let lv = (cl.pos - r.o) / d;

        let sin_theta_max_sq = (cl.radius * cl.radius) / (d * d);
        let cos_theta_max = (1.0 - sin_theta_max_sq).max(0.0).sqrt();

        let cos_theta = (u0 * cos_theta_max) + (1.0 - u0);
        let sin_theta = (1.0 - (cos_theta * cos_theta)).max(0.0).sqrt();
        let phi = u1 * 2.0 * PI;

        let sample_direction = vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta);

        translate_to_ws(sample_direction, lv)
    }

    pub fn get_random_sample(&self, r: Ray) -> Vec3 {
        let ct = (1.0 - rng01(r.spos.xy(), r.seed.y, self.camera.screen.y as u32)).sqrt();
        let st = (1.0 - (ct * ct)).max(0.0).sqrt();
        let phi = rng01(r.spos.yx(), r.seed.y, self.camera.screen.x as u32) * 2.0 * PI;
        return vec3((phi).cos() * st, ct, (phi).sin() * st);
    }

    // TODO - remove and do path tracing
    pub fn light_map(&self, posi: Vec3) -> Light {
        let dist = sphere(posi - LIGHT_POS, LIGHT_RAD);

        Light {
            dist,
            pos: LIGHT_POS,
            radius: LIGHT_RAD,
        }
    }

    pub fn sample_atmos(&self, sr: Ray) -> Vec3 {
        sample(
            self.atmos_tx,
            self.atmos_sampler,
            world_space_to_uv(sr.o + (sr.d * 1000.0)),
        )
        .xyz()
    }
}

// direct + indirect
// need to sample specular and scatter in the bounces.
impl Scene<'_> {
    pub fn sample_indirect_diff(&self, r: Ray, n: Vec3) -> Vec3 {
        let mut t = self.sample_direct_diff_spherical(r.clone().offset_uv(vec2(1.2233, 2.111)), n);
        let mut albedo = Vec3::splat(1.0);
        let mut r = r;
        let mut n = n;

        for i in 0..self.bounces + 1 {
            let l = translate_to_ws(
                self.get_random_sample(r.clone().offset_seed(UVec2::splat(i * 2))),
                n,
            );

            let cos_theta = n.dot(l).max(0.0); // TODO - this can sometimes be negative...
            let sr = r.clone().dir(l);
            let h = self.trace(sr);

            // TODO put sampling into some kind of helper
            if !h.valid() {
                t += albedo * cos_theta * self.sample_atmos(sr);
                break;
            }

            // // todo && i > 0??
            if h.emissive() > 0.0 {
                t += albedo * cos_theta;
                break;
            }

            albedo *= h.albedo();
            n = h.normal();
            r = r.at(sr.pd(h.dist()));
            t += albedo * cos_theta * self.sample_direct_diff_spherical(r, n);
        }

        return t;
    }

    fn sample_direct_diff_spherical(&self, r: Ray, n: Vec3) -> Vec3 {
        let cl = self.light_map(r.o);

        // assumed spherical
        let l = self.spherical_light_sample(cl, r);

        let cos_theta = n.dot(l);
        if cos_theta < 0.0 {
            return Vec3::ZERO;
        }

        let lsr = r.clone().at(r.o + l).dir(l);
        let hit = self.trace(lsr);

        if !hit.valid() {
            return Vec3::ZERO;
        }

        if hit.emissive() > 0.0 {
            let attenuation = hit.dist() / cl.radius + 1.0; // direct light attenuation factor
                                                            // hit.albedo() * cos_theta / (attenuation * attenuation) /*  * hit.emissive() */
            (hit.albedo() * hit.emissive()) * cos_theta / (attenuation * attenuation)
        } else {
            Vec3::ZERO
        }
    }
}

// scatter
impl Scene<'_> {
    fn trace_inside(&self, r: Ray) -> Material {
        // TODO - change to a Material struct
        let mut t = 0.01;

        for _ in 0..RMAX {
            let p = r.o + t * r.d;

            let mut h = self.map(p);
            h.x *= -1.0;

            if h.x < 0.002 {
                return self.lookup_mat(r, p, h, t, self.calc_normal(p));
            }

            if t > TMAX {
                break;
            }

            t += h.x
        }

        Material::default()
    }

    pub fn sample_scattering(&self, r: Ray, n: Vec3) -> Vec3 {
        let p1 = r.o - (n * 0.02);

        let cl = self.light_map(p1);

        let mut out = Vec3::ZERO;

        let l = self.spherical_light_sample(cl, r.clone().at(p1));

        let sr = r.clone().at(p1).dir(l);
        let h = self.trace_inside(sr);

        let sr = r.clone().at(p1 + (l * h.dist()) + (0.03 * l)).dir(l);

        let h1 = self.trace(sr);

        if h1.valid() {
            if h1.emissive() > 0.0 {
                let scale = 3.0;
                let bias = 0.01;

                let n1 = -h1.normal();
                let cos_theta = n1.dot(l);
                let s = scale * (h.dist() + bias);

                let e = (0.3 + cos_theta).max(0.0);

                let a = 0.2 / (h1.dist() * h1.dist());

                out += t(s) * e * a * (h1.albedo() * h1.emissive());
            }
        }

        out
    }
}

// specular
impl Scene<'_> {
    fn sample_brdf(&self, normal: Vec3, alpha2: f32, r: Ray) -> Vec3 {
        let u0 = rng01(
            r.spos.xy() + vec2(0.0, 0.0),
            r.seed.y,
            self.camera.screen.y as u32,
        );
        let u1 = rng01(
            r.spos.yx() + vec2(1.3, 2.7),
            r.seed.y,
            self.camera.screen.y as u32,
        );

        let cos_theta = ((1.0 - u0) / ((alpha2 - 1.0) * u0 + 1.0)).sqrt();
        let sin_theta = ((1.0 - (cos_theta * cos_theta)).max(0.0)).sqrt();
        let phi = u1 * 2.0 * PI;

        translate_to_ws(
            vec3(phi.cos() * sin_theta, cos_theta, phi.sin() * sin_theta),
            normal,
        )
    }

    pub fn spec_brdf(
        &self,
        r: Ray,
        v: Vec3,
        n: Vec3,
        roughness: f32,
        f0: f32,
        fresnel: &mut f32,
    ) -> Vec3 {
        let mut specular_light = Vec3::ZERO;

        let alpha = roughness * roughness;
        let alpha2 = alpha * alpha;
        let k_direct = (alpha2 + 1.0) / 8.0;
        let k_ibl = alpha / 2.0;

        let h = self.sample_brdf(
            n,
            alpha2,
            r.offset_seed(UVec2::splat(1 + 5))
                .offset_uv(vec2(5.220, 2.530)),
        );
        let v_dot_h = v.dot(h).max(0.000001);
        let l = (2.0 * (v_dot_h * h)) - v;
        let n_dot_v = n.dot(v).max(0.0);
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = r.clone().at(r.o + (l * 0.02)).dir(l);

            let hit = self.trace(sr);

            let in_radiance = if hit.valid() {
                if hit.emissive() > 0.0 {
                    hit.albedo()
                } else {
                    let mut col = hit.albedo()
                        * self.sample_indirect_diff(
                            sr.at(r.o + (l * hit.dist()))
                                .offset_seed(UVec2::splat(1 + 30)),
                            hit.normal(),
                        );

                    if hit.scattering_scale() > 0.0 {
                        col += hit.scattering_scale()
                            * hit.scattering_color()
                            * (self.sample_scattering(
                                r.clone()
                                    .at(r.o + (l * hit.dist()))
                                    .offset_seed(UVec2::splat(2 + 31)),
                                hit.normal(),
                            ));
                    }

                    col
                }
            } else {
                self.sample_atmos(sr)
            };

            *fresnel = f0 + (1.0 - f0) * (1.0 - n_dot_v).pow(5.0);
            let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_ibl);
            specular_light = in_radiance * (g_term * (*fresnel) * v_dot_h / (n_dot_h * n_dot_v));
        }

        let cl = self.light_map(r.o);
        let l = self.spherical_light_sample(cl, r);
        let h = (v + l) / (v + l).length();
        let n_dot_l = n.dot(l);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            let sr = r.at(r.o + (l * 0.02)).dir(l);
            let hit = self.trace(sr);

            if hit.emissive() > 0.0 {
                let attn = 1.0 / (hit.dist() * hit.dist());
                let in_radiance = hit.albedo() * attn;
                let d_term = d_term_ggxtr(n_dot_h, alpha);
                let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
                specular_light += in_radiance * g_term * *fresnel * d_term / (4.0 / n_dot_v);
            }
        }

        specular_light
    }
}

fn t(s: f32) -> Vec3 {
    Vec3::new(0.233, 0.455, 0.649) * (-s * s / 0.0064).exp()
        + Vec3::new(0.1, 0.336, 0.344) * (-s * s / 0.0484).exp()
        + Vec3::new(0.118, 0.198, 0.0) * (-s * s / 0.187).exp()
        + Vec3::new(0.113, 0.007, 0.007) * (-s * s / 0.567).exp()
        + Vec3::new(0.358, 0.004, 0.0) * (-s * s / 1.99).exp()
        + Vec3::new(0.078, 0.0, 0.0) * (-s * s / 7.41).exp()
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

pub fn linear_to_gamma(splat: Vec3) -> Vec3 {
    vec3(
        linear_to_gamma_f32(splat.x),
        linear_to_gamma_f32(splat.y),
        linear_to_gamma_f32(splat.z),
    )
}

pub fn linear_to_gamma_f32(f: f32) -> f32 {
    if f > 0. {
        f.sqrt()
    } else {
        0.0
    }
}

impl Scene<'_> {
    pub fn random_in_unit_sphere(&self, r: Ray) -> Vec3 {
        let rand = vec3(
            rng01(r.spos.xy() + 0.011, r.seed.y, self.camera.screen.y as u32),
            rng01(r.spos.yx() + 0.033, r.seed.y, self.camera.screen.y as u32),
            rng01(r.spos.xy() + 0.025, r.seed.y, self.camera.screen.y as u32),
        );
        let phi = 2.0 * PI * rand.x;
        let cos_theta = 2.0 * rand.y - 1.0;
        let u = rand.z;

        let theta = cos_theta.acos();
        let r = u.powf(1.0 / 3.0);

        let x = r * theta.sin() * phi.cos();
        let y = r * theta.sin() * phi.sin();
        let z = r * theta.cos();

        Vec3::new(x, y, z)
    }

    pub fn random_on_hemisphere(&self, normal: Vec3, r: Ray) -> Vec3 {
        let rd = self.random_in_unit_sphere(r); // random vector from 0.0, 1.0
        let res = rd + normal;

        if res.abs() == Vec3::splat(0.0) {
            normal
        } else {
            res.normalize()
        }
    }
}
