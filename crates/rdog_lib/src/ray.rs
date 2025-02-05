use bytemuck::{Pod, Zeroable};
use spirv_std::num_traits::Pow;

use crate::prelude::*;

const DANGER: Vec3 = vec3(1.0, 0.0, 1.0);
const ZERO: Vec3 = Vec3::ZERO;
const ONE: Vec3 = Vec3::ONE;

pub const TMAX: f32 = 10.0;
pub const MIN_DIST: f32 = 0.001;
const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, 3.0, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
#[derive(Copy, Clone)]
pub struct Ray {
    pub o: Vec3,
    pub d: Vec3,
    pub spos: Vec2,
    pub seed: UVec2,
    pub t: u32,
}

impl Ray {
    pub fn ray(ss: Vec2, ndc_to_world: Mat4, pos: Vec2, seed: UVec2, i: u32) -> Ray {
        let mut uv = ((pos + vec2(0.5, 0.5)) * 2.0) / ss - Vec2::ONE;
        uv.y = -uv.y;

        let offset = i as f32 * pos;
        let position = rng01(offset, seed.y, ss.y as u32) - 0.5;

        uv += position * 0.0005;

        let fp = ndc_to_world.project_point3(uv.extend(f32::EPSILON));
        let np = ndc_to_world.project_point3(uv.extend(1.0));

        let seed = uvec2(seed.x, seed.y.wrapping_mul(i + 1));

        return Ray::new(np, (fp - np).normalize(), pos, seed);
    }

    pub fn new(o: Vec3, d: Vec3, pos: Vec2, seed: UVec2) -> Self {
        Ray {
            o,
            d,
            spos: pos,
            seed,
            t: 0,
        }
    }

    fn pd(&self, t: f32) -> Vec3 {
        (self.d * t) + self.o
    }

    pub fn mv(&mut self, t: f32) {
        self.at(self.pd(t))
    }

    pub fn at(&mut self, p: Vec3) {
        self.o = p;
    }

    pub fn dir(&mut self, d: Vec3) {
        self.d = d;
    }

    fn offset_uv(&mut self, offset: Vec2) -> &mut Self {
        self.spos += offset;
        self
    }

    fn offset_seed(&mut self, offset: UVec2) -> &mut Self {
        self.seed += offset;
        self
    }
}

#[derive(Copy, Clone)]
struct Light {
    _dist: f32,
    pos: Vec3,
    radius: f32,
}

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Material {
    irrs: Vec4,
    nd: Vec4,
    pub albedo: Vec4,
    scattering_color: Vec4,
    dsei: Vec4,
}

impl Default for Material {
    fn default() -> Self {
        Self {
            // ifrs: (index, refraction, roughness, scattering_scale)
            irrs: Vec4::new(0.0, 0.04, 0.0, 0.0),

            // nd: (normal.xyz, dist)
            nd: Vec4::new(0.0, 0.0, 0.0, TMAX),

            // albedo: (albedo.xyz, w unused)
            albedo: Vec4::new(0.0, 0.0, 0.0, 0.0),

            // scattering_color: (scattering_color.xyz, w unused)
            scattering_color: Vec4::new(0.0, 0.0, 0.0, 0.0),

            // dsei: (diffuse_scale, specular_scale, emissive, ior)
            dsei: Vec4::new(1.0, 1.0, 0.0, 0.0),
        }
    }
}

impl Material {
    pub fn valid(&self) -> bool {
        self.normal().length() > 0.0 // means its an object.
    }

    pub fn interior(&self) -> bool {
        self.albedo.w < 0.0
    }

    pub fn index(&self) -> f32 {
        self.irrs.x
    }

    pub fn refraction(&self) -> f32 {
        self.irrs.y
    }

    pub fn roughness(&self) -> f32 {
        self.irrs.z
    }

    pub fn scattering_scale(&self) -> f32 {
        self.irrs.w
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
        self.irrs.x = index;
        self
    }

    pub fn with_refraction(mut self, refraction: f32) -> Self {
        self.irrs.y = refraction;
        self
    }

    pub fn with_roughness(mut self, roughness: f32) -> Self {
        self.irrs.z = roughness;
        self
    }

    pub fn with_interior(mut self, interior: bool) -> Self {
        self.albedo.w = ((!interior as i32) as f32) * 2.0 - 1.0;
        self
    }

    pub fn with_scattering_scale(mut self, scale: f32) -> Self {
        self.irrs.w = scale;
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
    pub fn specular_scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        let eta = match !self.interior() {
            true => 1.0 / self.ior(),
            false => 1.0 / self.ior(),
        };

        let mut n = self.normal();
        let ud = r.d.normalize();
        let v_ud = -ud;

        let u = if n.dot(ud) == 1.0 {
            // If ray direction is aligned with normal, use fallback vector for u
            n.cross(Vec3::Y).normalize()
        } else {
            n.cross(ud).normalize()
        };
        let v = u.cross(n).normalize();

        // Perturb the normal based on roughness using RNG
        let a: f32 = (scene.rng(r) - 0.5) * self.roughness() * 2.0;
        let b: f32 = (scene.rng(r) - 0.5) * self.roughness() * 2.0;

        n += u * a + v * b;
        n = n.normalize();

        let cos_theta = v_ud.dot(n).min(1.0).max(-1.0);

        let r0 = (1.0 - eta) / (1.0 + eta);
        let fresnel = r0.pow(2.0) + (1.0 - r0) * (1.0 - cos_theta).pow(5.0);

        let dir = if scene.rng(r) > self.refraction() {
            scene.reflect(ud, n)
        } else {
            r.at(r.o + (self.normal() * (MIN_DIST * 4.0) * -1.0));
            scene.refract(ud, n, eta)
        };

        let reflection_radiance = fresnel * Vec3::new(1.0, 1.0, 1.0); // Placeholder for reflected light
        let refraction_radiance = (1.0 - fresnel) * Vec3::new(1.0, 1.0, 1.0); // Placeholder for refracted light
        let radiance = reflection_radiance + refraction_radiance;

        let albedo = self.albedo(); // todo may want to apply tint to reflections in future.

        ScatterRes::new(dir, true, radiance, fresnel, albedo)
    }

    fn diffuse_scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        let dir = translate_to_ws(
            scene.get_random_sample(r.offset_uv(vec2(-1.03322, 3.299))),
            self.normal(),
        );

        ScatterRes::new(dir, true, ONE, 0.0, self.albedo())
    }

    pub fn scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        if self.specular() > 0.0 && self.diffuse() > 0.0 {
            let diffuse_weight = self.diffuse() / 10.0;
            let specular_weight = self.specular() / 10.0;
            let sum_weights = diffuse_weight + specular_weight;
            let diffuse_prob = diffuse_weight / sum_weights;

            if scene.rng(r) < diffuse_prob {
                self.specular_scatter(scene, r)
            } else {
                self.diffuse_scatter(scene, r)
            }
        } else if self.specular() > 0.0 {
            self.specular_scatter(scene, r)
        } else if self.diffuse() > 0.0 {
            self.diffuse_scatter(scene, r)
        } else {
            ScatterRes::new(Vec3::Y, false, ONE, 0.0, self.albedo())
        }
    }
}

pub struct ScatterRes {
    pub dir: Vec3,
    scatter: bool,
    albedo: Vec3,
    fresnel: f32,
    radiance: Vec3,
}

impl ScatterRes {
    fn new(dir: Vec3, scatter: bool, radiance: Vec3, fresnel: f32, albedo: Vec3) -> Self {
        Self {
            dir,
            scatter,
            albedo,
            fresnel,
            radiance,
        }
    }
}

fn shape(posi: Vec3, _el: f32, _seed: UVec2) -> f32 {
    // let pos = aar(posi + Vec3::NEG_Y, vec3(0.2, 1.0, 0.0).normalize(), el);
    let pos = aar(posi + Vec3::NEG_Y, vec3(0.2, 1.0, 0.0).normalize(), 0.5);
    let po = aar(pos, vec3(0.0, 0.0, 1.0).normalize(), -90.0_f32.to_radians());
    let pp = aar(pos, vec3(1.0, 0.0, 0.0).normalize(), -45.0_f32.to_radians());
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    op_smooth_union(o, r, 0.1)
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

pub struct Scene<'a> {
    camera: &'a Camera,
    globals: &'a Globals,
    materials: &'a [Material],
    #[allow(dead_code)]
    params: &'a PassParams,
    bounces: u32,
    // atmos_tx: Tex<'a>,
    // atmos_sampler: &'a Sampler,
    #[allow(dead_code)]
    diffuse: bool,
    #[allow(dead_code)]
    scatter: bool,
    #[allow(dead_code)]
    specular: bool,
}

impl<'a> Scene<'a> {
    pub fn new(
        camera: &'a Camera,
        globals: &'a Globals,
        materials: &'a [Material],
        params: &'a PassParams,
        bounces: u32,
        // atmos_tx: Tex<'a>,
        // atmos_sampler: &'a Sampler,
        diffuse: bool,
        scatter: bool,
        specular: bool,
    ) -> Scene<'a> {
        Self {
            camera,
            globals,
            materials,
            params,
            bounces,
            // atmos_tx,
            // atmos_sampler,
            diffuse,
            scatter,
            specular,
        }
    }
}

impl Scene<'_> {
    #[inline(never)]
    pub fn trace(&self, r: &mut Ray) -> Material {
        // TODO - change to a Material struct
        let mut t = 0.01;
        let mut interior;
        let mut h;

        for _ in 0..RMAX {
            let p = r.pd(t);

            h = self.map(p);
            interior = h.x <= 0.0;
            h.x = h.x.abs();

            if h.x < MIN_DIST {
                return self.lookup_material(r, p, h, t, self.calc_normal(p), interior);
            }

            if t > TMAX {
                break;
            }

            t += h.x
        }

        Material::default().with_albedo(DANGER)
    }

    pub fn rt(&self, r: &mut Ray) -> Vec3 {
        let mut t = ZERO;
        let mut albedo = ONE;
        let mut cos_theta = 1.0;
        let mut radiance = ONE;

        for i in 0..self.bounces {
            let h = self.trace(r);
            r.mv(h.dist());

            {
                if !h.valid() {
                    t += albedo * self.sample_atmos(&r) * radiance;
                    break;
                }
                if h.emissive() > 0.0 {
                    t += albedo * h.albedo() * cos_theta * radiance;
                    break;
                }
            }

            let l = h.scatter(
                &self,
                r.offset_seed(UVec2::ZERO + (i * 2))
                    .offset_uv(vec2(8.2, 3.3)),
            );
            cos_theta = h.normal().dot(l.dir).max(0.0);

            // {
            //     t = l.albedo;
            //     break;
            // }

            // sample light at this location
            albedo *= l.albedo * radiance;
            t += albedo * self.sample_point(h, r, &l) * radiance;

            radiance *= l.radiance;

            if !l.scatter {
                break;
            }

            r.dir(l.dir);
        }

        t
    }

    fn sample_point(&self, h: Material, r: &mut Ray, l: &ScatterRes) -> Vec3 {
        let mut rc = r.clone();
        let mut col = ZERO;

        if h.diffuse() > 0.0 {
            col += h.diffuse()
                * h.albedo()
                * self.sample_direct_diff_spherical(rc.offset_seed(UVec2::ONE * 23), h.normal());
            r.seed = rc.seed;
            rc = r.clone();
        }

        if h.scattering_scale() > 0.0 {
            col += h.scattering_scale()
                * h.scattering_color()
                * self.sample_scattering(rc.offset_seed(UVec2::ONE * 24), h.normal());
            r.seed = rc.seed;
            rc = r.clone();
        }

        // todo specular highlights...
        col = (1.0 - l.fresnel) * col;

        if h.specular() > 0.0 {
            let cl = self.light_map(rc.o);
            let ls = self.spherical_light_sample(cl, &mut rc);
            let v = -rc.d;
            let n = h.normal();
            let n_dot_v = n.dot(v).max(0.0);
            let alpha = h.roughness().powf(2.0);
            let alpha2 = alpha.powf(2.0);
            let h = (v + ls) / (v + ls).length();
            let n_dot_l = n.dot(ls);
            let n_dot_h = n.dot(h).max(0.0);

            if n_dot_l > 0.0 {
                rc.at(rc.o + (ls * 0.02));
                rc.dir(ls);

                let hit = self.trace(&mut rc);

                let k_direct = (alpha2 + 1.0) / 8.0;

                if hit.emissive() > 0.0 {
                    let attn = 1.0 / (hit.dist() * hit.dist());
                    let in_radiance = hit.albedo() * attn;
                    let d_term = d_term_ggxtr(n_dot_h, alpha);
                    let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
                    col += in_radiance * g_term * l.fresnel * d_term / (4.0 / n_dot_v);
                }
            }
            r.seed = rc.seed;
        }

        col
    }

    fn map(&self, posi: Vec3) -> Vec2 {
        let l = sphere(posi - LIGHT_POS, LIGHT_RAD);

        let d = de(posi);
        min_sd(vec2(d, 1.0), vec2(l, 0.0))
        // let s = shape(posi, self.globals.time.x, self.globals.seed);
        // // let s = sd_round_box(posi + Vec3::NEG_Y, ONE * 0.5, 0.1);
        // // let s = shape(posi, self.globals.time.x, self.globals.seed);
        // let p = plane(posi, vec4(0.0, 1.0, 0.0, 1.0)); // TODO - readd
        //
        // let l = vec2(l, 0.0);
        // let s = vec2(s, 1.0);
        // let p = vec2(p, 2.0);
        //
        // let s2 = vec2(sphere(posi - vec3(-2.0, 1.0, 0.0), 0.6), 3.0);
        //
        // min_sd(min_sd(min_sd(l, s), s2), p)
    }

    fn lookup_material(
        &self,
        _r: &mut Ray,
        _p: Vec3,
        h: Vec2,
        t: f32,
        normal: Vec3,
        interior: bool,
    ) -> Material {
        let i = h.y as usize;

        let normal = normal * (2.0 * (!interior as i32 as f32) - 1.0);

        if i > self.materials.len() - 1 || self.materials.is_empty() {
            return Material::default()
                .with_normal(normal)
                .with_dist(t)
                .with_interior(interior);
        }

        self.materials[i]
            .with_normal(normal)
            .with_dist(t)
            .with_interior(interior)
    }

    fn calc_normal(&self, pos: Vec3) -> Vec3 {
        let ep = 0.0001;
        let e = Vec2::new(1.0, -1.0) * 0.5773;

        (0. + e.xyy() * self.map(pos + ep * e.xyy()).x
            + e.yyx() * self.map(pos + ep * e.yyx()).x
            + e.yxy() * self.map(pos + ep * e.yxy()).x
            + e.xxx() * self.map(pos + ep * e.xxx()).x)
            .normalize()
    }

    fn spherical_light_sample(&self, cl: Light, r: &mut Ray) -> Vec3 {
        let u0 = self.rng(r).c(0.0, 1.0);
        let u1 = self.rng(r).c(0.0, 1.0);

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

    fn get_random_sample(&self, r: &mut Ray) -> Vec3 {
        let ct = (1.0 - self.rng(r)).sqrt();
        let st = (1.0 - (ct * ct)).max(0.0).sqrt();
        let phi = self.rng(r) * 2.0 * PI;
        return vec3((phi).cos() * st, ct, (phi).sin() * st);
    }

    // TODO - remove and do path tracing
    fn light_map(&self, posi: Vec3) -> Light {
        let dist = sphere(posi - LIGHT_POS, LIGHT_RAD);

        Light {
            _dist: dist,
            pos: LIGHT_POS,
            radius: LIGHT_RAD,
        }
    }

    fn sample_atmos(&self, _sr: &Ray) -> Vec3 {
        vec3(0.4, 0.35, 0.37) * 0.1
        // sample(
        //     self.atmos_tx,
        //     self.atmos_sampler,
        //     world_space_to_uv(sr.o + (sr.d * 1000.0)) * vec2(1.0, -1.0),
        // )
        // .xyz()
    }
}

// direct + indirect
// need to sample specular and scatter in the bounces.
impl Scene<'_> {
    fn sample_direct_diff_spherical(&self, r: &mut Ray, n: Vec3) -> Vec3 {
        let cl = self.light_map(r.o);

        // assumed spherical
        let l = self.spherical_light_sample(cl, r);

        let cos_theta = n.dot(l);
        if cos_theta < 0.0 {
            return Vec3::ZERO;
        }

        // let lsr = r.clone().at(r.o + l).dir(l);
        r.at(r.o + l);
        r.dir(l);
        let hit = self.trace(r);

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
    fn sample_scattering(&self, r: &mut Ray, n: Vec3) -> Vec3 {
        let p1 = r.o - (n * 0.02);

        let cl = self.light_map(p1);

        let mut out = Vec3::ZERO;

        r.at(p1);
        let l = self.spherical_light_sample(cl, r);

        r.dir(l);
        let h = self.trace(r);

        r.at(p1 + (l * h.dist()) + (0.03 * l));

        let h1 = self.trace(r);

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
    fn reflect(&self, i: Vec3, n: Vec3) -> Vec3 {
        i - n * (2.0 * i.dot(n))
    }

    pub fn refract(&self, ud: Vec3, n: Vec3, ior: f32) -> Vec3 {
        let k = 1.0 - ior * ior * (1.0 - n.dot(ud) * n.dot(ud));
        if k < 0.0 {
            ud
        } else {
            ior * ud - (ior * n.dot(ud) + k.sqrt()) * n
        }
        // let cos_thior = ((-ud).dot(n)).min(1.0);
        // let r_out_perp = ior * (ud + (cos_thior * n));
        // let r_out_parallel = -((1.0 - r_out_perp.dot(r_out_perp)).abs().sqrt()) * n;
        // r_out_perp + r_out_parallel
    }

    pub fn rng(&self, r: &mut Ray) -> f32 {
        r.t += 1;
        rng01(
            r.spos,
            r.seed.y.wrapping_add(r.t - 1),
            self.camera.screen.y as u32,
        )
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
