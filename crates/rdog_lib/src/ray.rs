use bytemuck::{Pod, Zeroable};
use spirv_std::num_traits::Pow;

use crate::prelude::*;

const DANGER: Vec3 = vec3(1.0, 0.0, 1.0);
const ZERO: Vec3 = Vec3::ZERO;
const ONE: Vec3 = Vec3::ONE;

pub const TMAX: f32 = 4.0;
pub const MIN_DIST: f32 = 0.001;
pub const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, 3.0, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

pub struct Hit {
    pub d: f32,
    pub n: Vec3,
    pub i: bool,
    pub m: Material,
}

#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
#[derive(Copy, Clone)]
pub struct Ray {
    pub o: Vec3,
    pub d: Vec3,
    pub spos: Vec2,
    pub t: u32,
}

impl Ray {
    pub fn ray(ss: Vec2, ndc_to_world: Mat4, pos: Vec2, seed: UVec2, s: &mut u32, i: u32) -> Ray {
        let mut uv = ((pos + vec2(0.5, 0.5)) * 2.0) / ss - Vec2::ONE;
        uv.y = -uv.y;

        let position = rand_f(s) - 0.5;
        uv += position * 0.0005;

        let fp = ndc_to_world.project_point3(uv.extend(f32::EPSILON));
        let np = ndc_to_world.project_point3(uv.extend(1.0));

        return Ray::new(np, (fp - np).normalize(), pos, *s);
    }

    pub fn new(o: Vec3, d: Vec3, pos: Vec2, s: u32) -> Self {
        Ray {
            o,
            d,
            spos: pos,
            t: s,
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
}

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Light {
    pub posf: Vec4,
    pub rmd: Vec4,
}

impl Default for Light {
    fn default() -> Self {
        Self {
            posf: vec4(10000.0, 10000.0, 10000.0, 8.0),
            rmd: vec4(0.0, 0.0, 0.0, 0.0),
        }
    }
}

impl Light {
    pub fn pos(&self) -> Vec3 {
        self.posf.xyz()
    }

    pub fn falloff(&self) -> f32 {
        self.posf.w
    }

    fn radius(&self) -> f32 {
        self.rmd.x
    }

    fn material_id(&self) -> f32 {
        self.rmd.y
    }

    fn dist(&self) -> f32 {
        self.rmd.z
    }
}

impl Light {
    pub fn with_pos(mut self, pos: Vec3) -> Self {
        self.posf = pos.extend(self.falloff());
        self
    }

    pub fn with_falloff(mut self, falloff: f32) -> Self {
        self.posf.w = falloff;
        self
    }

    pub fn with_radius(mut self, radius: f32) -> Self {
        self.rmd.x = radius;
        self
    }

    pub fn with_material_id(mut self, material_id: f32) -> Self {
        self.rmd.y = material_id;
        self
    }

    pub fn with_dist(mut self, dist: f32) -> Self {
        self.rmd.z = dist;
        self
    }
}

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable)]
#[cfg_attr(not(target_arch = "spirv"), derive(Debug))]
pub struct Material {
    pub irrs: Vec4,
    pub albedo: Vec4,
    pub scattering_color: Vec4,
    pub dsei: Vec4,
}

impl Default for Material {
    fn default() -> Self {
        Self {
            irrs: Vec4::new(0.0, 0.04, 0.0, 0.0),
            albedo: Vec4::new(0.0, 0.0, 0.0, 0.0),
            scattering_color: Vec4::new(0.0, 0.0, 0.0, 0.0),
            dsei: Vec4::new(1.0, 1.0, 0.0, 0.0),
        }
    }
}

impl Material {
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

impl Hit {
    pub fn specular_scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        let eta = match !self.i {
            true => 1.0 / self.m.ior(),
            false => self.m.ior() / 1.0,
        };

        let mut n = self.n;
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
        let a: f32 = (scene.rng(r) - 0.5) * self.m.roughness() * 2.0;
        let b: f32 = (scene.rng(r) - 0.5) * self.m.roughness() * 2.0;

        n += u * a + v * b;
        n = n.normalize();

        let cos_theta = v_ud.dot(n).min(1.0).max(-1.0);

        let r0 = (1.0 - eta) / (1.0 + eta);
        let fresnel = r0.pow(2.0) + (1.0 - r0) * (1.0 - cos_theta).pow(5.0);

        let dir = if scene.rng(r) > self.m.refraction() {
            scene.reflect(ud, n)
        } else {
            r.at(r.o + (self.n * (MIN_DIST * 4.0) * -1.0));
            scene.refract(ud, n, eta)
        };

        let reflection_radiance = fresnel * Vec3::new(1.0, 1.0, 1.0); // Placeholder for reflected light
        let refraction_radiance = (1.0 - fresnel) * Vec3::new(1.0, 1.0, 1.0); // Placeholder for refracted light
        let radiance = reflection_radiance + refraction_radiance;

        let albedo = self.m.albedo(); // todo may want to apply tint to reflections in future.

        ScatterRes::new(dir, true, radiance, fresnel, albedo)
    }

    fn diffuse_scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        let dir = translate_to_ws(
            scene.get_random_sample(r.offset_uv(vec2(-1.03322, 3.299))),
            self.n,
        );

        ScatterRes::new(dir, true, ONE, 0.0, self.m.albedo())
    }

    pub fn scatter(&self, scene: &Scene, r: &mut Ray) -> ScatterRes {
        if self.m.specular() > 0.0 && self.m.diffuse() > 0.0 {
            let diffuse_weight = self.m.diffuse() / 10.0;
            let specular_weight = self.m.specular() / 10.0;
            let sum_weights = diffuse_weight + specular_weight;
            let diffuse_prob = diffuse_weight / sum_weights;

            if scene.rng(r) > diffuse_prob {
                self.specular_scatter(scene, r)
            } else {
                self.diffuse_scatter(scene, r)
            }
        } else if self.m.specular() > 0.0 {
            self.specular_scatter(scene, r)
        } else if self.m.diffuse() > 0.0 {
            self.diffuse_scatter(scene, r)
        } else {
            ScatterRes::new(Vec3::Y, false, ONE, 0.0, self.m.albedo())
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
    pub globals: &'a Globals,
    materials: &'a [Material],
    pub lights: &'a [Light],
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
        lights: &'a [Light],
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
            lights,
            params,
            bounces,
            // atmos_tx,
            // atmos_sampler,
            diffuse,
            scatter,
            specular,
        }
    }

    fn sample_specular(&self, r: &mut Ray, h: Hit, l: &ScatterRes) -> Vec3 {
        let cl = self.light_map(r);

        if cl.dist() > cl.falloff() {
            return Vec3::ZERO;
        }

        let ls = self.spherical_light_sample(cl, r);
        let v = -r.d;
        let n = h.n;
        let n_dot_v = n.dot(v).max(0.0);
        let alpha = h.m.roughness().powf(2.0);
        let alpha2 = alpha.powf(2.0);
        let h = (v + ls) / (v + ls).length();
        let n_dot_l = n.dot(ls);
        let n_dot_h = n.dot(h).max(0.0);

        if n_dot_l > 0.0 {
            r.at(r.o + (ls * 0.02));
            r.dir(ls);

            let hit = self.trace(r);

            let k_direct = (alpha2 + 1.0) / 8.0;

            if hit.m.emissive() > 0.0 {
                let attn = 1.0 / (hit.d * hit.d);
                let in_radiance = hit.m.albedo() * attn;
                let d_term = d_term_ggxtr(n_dot_h, alpha);
                let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
                let a = calc_attenuation(r, &cl);
                return in_radiance * g_term * l.fresnel * d_term / (4.0 / n_dot_v)
                    * (a * hit.m.emissive());
            }
        }

        Vec3::ZERO
    }
}

impl Scene<'_> {
    pub fn map(&self, pos: Vec3) -> Vec2 {
        // scene::map_scene_1(self, pos)

        let l = self.lights(pos);
        let d = de(pos);
        min_sd(l, vec2(d, 2.0))
    }

    #[inline(never)]
    pub fn trace(&self, r: &mut Ray) -> Hit {
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
                return self.lookup_material(r, p, h, t, interior);
            }

            if t > TMAX {
                break;
            }

            t += h.x
        }

        Hit {
            d: TMAX,
            n: ZERO,
            i: false,
            m: self.mat(0), // todo, not this.
        }
    }

    pub fn rt(&self, r: &mut Ray) -> Vec3 {
        let mut t = ZERO;
        let mut albedo = ONE;
        let mut cos_theta = 1.0;
        let mut radiance = ONE;

        for i in 0..self.bounces + 1 {
            let mut h = self.trace(r);
            r.mv(h.d);

            if h.d >= TMAX {
                t += albedo * self.sample_atmos(&r) * radiance;
                break;
            }
            if h.m.emissive() > 0.0 {
                t += h.m.emissive() * albedo * h.m.albedo() * cos_theta * radiance;
                break;
            }

            h.n = self.calc_normal(r.o) * (2.0 * (!h.i as i32 as f32) - 1.0);
            let l = h.scatter(&self, r);
            cos_theta = h.n.dot(l.dir).max(0.0);

            // sample light at this location
            albedo *= l.albedo * radiance;
            let sample = self.sample_point(h, r, &l);

            t += albedo * sample * radiance;

            radiance *= l.radiance;

            if !l.scatter {
                break;
            }

            r.dir(l.dir);
        }

        t
    }

    pub fn calculate_probabilities(&self, h: &Hit) -> Vec3 {
        let diffuse_weight = h.m.diffuse() / 10.0; // Assuming self.m.diffuse() exists
        let specular_weight = h.m.specular() / 10.0; // Assuming self.m.specular() exists
        let scatter_weight = h.m.scattering_scale() / 10.0; // Assuming self.m.scatter() exists - ADD THIS LINE

        let sum_weights = diffuse_weight + specular_weight + scatter_weight; // Update sum_weights

        let diffuse_prob = diffuse_weight / sum_weights;
        let scatter_prob = scatter_weight / sum_weights; // Calculate scatter probability
        let specular_prob = specular_weight / sum_weights;

        vec3(diffuse_prob, scatter_prob, specular_prob) // Return all three probabilities
    }

    fn sample_point(&self, h: Hit, r: &mut Ray, l: &ScatterRes) -> Vec3 {
        let mut rc = r.clone();

        let prob = self.calculate_probabilities(&h);
        let rng = self.rng(r);

        if rng < prob.x {
            let col =
                h.m.diffuse() * h.m.albedo() * self.sample_direct_diff_spherical(&mut rc, h.n);
            r.t = rc.t;
            return (1.0 - l.fresnel) * col;
        }

        if rng < prob.x + prob.y {
            let col = h.m.scattering_scale()
                * h.m.scattering_color()
                * self.sample_scattering(&mut rc, h.n);
            r.t = rc.t;
            return (1.0 - l.fresnel) * col;
        }

        let col = h.m.specular() * self.sample_specular(&mut rc, h, l);
        r.t = rc.t;
        return col;
    }

    pub fn lights(&self, posi: Vec3) -> Vec2 {
        let mut d = vec2(TMAX, 0.0);
        for i in 0..self.lights.len() {
            let l = self.lights[i];
            d = min_sd(vec2(sphere(posi - l.pos(), l.radius()), l.material_id()), d);
        }

        d
    }

    // get a random light.
    fn light_map(&self, r: &mut Ray) -> Light {
        let rng = (self.rng(r) * ((self.lights.len() - 1) as f32)).floor() as usize;
        let l = self.lights[rng];
        return l.with_dist(sphere(r.o - l.pos(), l.radius()));
    }

    fn mat(&self, i: usize) -> Material {
        self.materials[i]
    }

    fn lookup_material(&self, _r: &mut Ray, _p: Vec3, h: Vec2, t: f32, interior: bool) -> Hit {
        let i = h.y as usize;
        Hit {
            d: t,
            n: ZERO,
            i: interior,
            m: self.mat(i),
        }
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

        let d = (cl.pos() - r.o).length();
        let lv = (cl.pos() - r.o) / d;

        let sin_theta_max_sq = (cl.radius() * cl.radius()) / (d * d);
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

    fn sample_atmos(&self, _sr: &Ray) -> Vec3 {
        vec3(0.4, 0.35, 0.37) * 0.002
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
        let cl = self.light_map(r);

        if cl.dist() > cl.falloff() {
            // TODO don't hard code.
            return Vec3::ZERO;
        }

        // assumed spherical
        let l = self.spherical_light_sample(cl, r);

        let cos_theta = n.dot(l);
        if cos_theta < 0.0 {
            return Vec3::ZERO;
        }

        // let lsr = r.clone().at(r.o + l).dir(l);
        r.dir(l);
        let hit = self.trace(r);

        if hit.d >= TMAX {
            return Vec3::ZERO;
        }

        if hit.m.emissive() > 0.0 {
            let a = calc_attenuation(r, &cl);
            (hit.m.albedo() * cos_theta * hit.m.emissive()) * a
        } else {
            Vec3::ZERO
        }
    }
}

fn calc_attenuation(r: &mut Ray, cl: &Light) -> f32 {
    let attenuation = (1.0 - (r.o.distance(cl.pos()) / cl.falloff())).max(0.0);
    attenuation.powf(4.0)
}

// scatter
impl Scene<'_> {
    fn sample_scattering(&self, r: &mut Ray, n: Vec3) -> Vec3 {
        let p1 = r.o - (n * 0.02);
        let mut out = Vec3::ZERO;

        r.at(p1);
        let cl = self.light_map(r);

        if cl.dist() > cl.falloff() {
            return out;
        }

        r.at(p1);
        let l = self.spherical_light_sample(cl, r);

        r.dir(l);
        let h = self.trace(r);

        r.at(p1 + (l * h.d) + (0.03 * l));

        let h1 = self.trace(r);

        if h1.d < TMAX {
            if h1.m.emissive() > 0.0 {
                let scale = 3.0;
                let bias = 0.01;

                let n1 = -h1.n;
                let cos_theta = n1.dot(l);
                let s = scale * (h.d + bias);

                let e = (0.3 + cos_theta).max(0.0);

                let a = calc_attenuation(r, &cl);

                out += t(s) * e * a * (h1.m.albedo() * h1.m.emissive() * a);
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
    }

    pub fn rng(&self, r: &mut Ray) -> f32 {
        rand_f(&mut r.t)
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
