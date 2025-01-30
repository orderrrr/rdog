use bytemuck::{Pod, Zeroable};
use spirv_std::num_traits::Pow;

use crate::prelude::*;

const DANGER: Vec3 = vec3(1.0, 0.0, 1.0);
const ZERO: Vec3 = Vec3::ZERO;
const ONE: Vec3 = Vec3::ONE;

pub const TMAX: f32 = 40.0;
const RMAX: u32 = 300;
pub const LIGHT_POS: Vec3 = vec3(0.0, 3.0, 2.5);
pub const LIGHT_RAD: f32 = 1.0;

const HPI: f32 = PI * 0.5; // TODO move out

#[derive(Copy, Clone)]
pub struct Ray {
    o: Vec3,
    d: Vec3,
    spos: Vec2,
    seed: UVec2,
    trace_interior: bool,
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

    fn new(o: Vec3, d: Vec3, pos: Vec2, seed: UVec2) -> Self {
        Ray {
            o,
            d,
            spos: pos,
            seed,
            trace_interior: false,
        }
    }

    fn should_trace_interior(&self) -> bool {
        self.trace_interior
    }

    fn trace_interior(mut self, t: bool) -> Ray {
        self.trace_interior = t;
        self
    }

    fn pd(&self, t: f32) -> Vec3 {
        (self.d * t) + self.o
    }

    fn mv(&self, t: f32) -> Ray {
        self.at(self.pd(t))
    }

    fn at(mut self, p: Vec3) -> Ray {
        self.o = p;
        self
    }

    fn dir(mut self, d: Vec3) -> Ray {
        self.d = d;
        self
    }

    fn offset_uv(mut self, offset: Vec2) -> Ray {
        self.spos += offset;
        self
    }

    fn offset_seed(mut self, offset: UVec2) -> Ray {
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
            dsei: Vec4::new(1.0, 1.0, 0.0, 0.0),
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
    fn specular_scatter(&self, scene: &Scene, r: Ray) -> ScatterRes {
        let inside = self.dist() < 0.0;
        let mut refracted = false;

        let ri = if inside { self.ior() } else { 1.0 / self.ior() };

        let cos_theta = (-r.d).dot(self.normal());
        let sin_theta = (1.0 - (cos_theta * cos_theta)).sqrt();
        let cannot_refract = ri * sin_theta > 1.0;

        let n = self.normal();
        let v = -r.d;

        let alpha = self.roughness() * self.roughness();
        let alpha2 = alpha * alpha;
        let k_ibl = alpha / 2.0;
        let h = if cannot_refract {
            scene.sample_reflection_brdf(
                n,
                alpha2,
                r.offset_seed(uvec2(3, 2)).offset_uv(vec2(1.220, 2.530)),
            )
        } else {
            refracted = true;
            scene.sample_refractive_brdf(
                n,
                ri,
                alpha2,
                r.offset_seed(uvec2(3, 2)).offset_uv(vec2(1.220, 2.530)),
            )
        };
        let v_dot_h = v.dot(h).max(0.000001);
        let dir = (2.0 * (v_dot_h * h)) - v;
        let n_dot_v = n.dot(v).max(0.0);
        let n_dot_l = n.dot(dir);
        let n_dot_h = n.dot(h).max(0.0);

        let scat = n_dot_l > 0.0;

        let fresnel = self.f0() + (1.0 - self.f0()) * (1.0 - n_dot_v).pow(5.0);
        let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_ibl);
        let radiance = g_term * fresnel * v_dot_h / (n_dot_h * n_dot_v);

        let albedo = ONE; // todo may want to apply tint to reflections in future.

        ScatterRes::new(dir, scat, radiance, fresnel, albedo, refracted)
    }

    fn diffuse_scatter(&self, scene: &Scene, r: Ray) -> ScatterRes {
        let dir = translate_to_ws(
            scene.get_random_sample(r.offset_uv(vec2(-1.03322, 3.299))),
            self.normal(),
        );

        ScatterRes::new(dir, true, 1.0, 0.0, self.albedo(), false)
    }

    fn scatter(&self, scene: &Scene, r: Ray) -> ScatterRes {
        if self.specular() > 0.0 && self.diffuse() > 0.0 {
            if rng01(r.spos, r.seed.y * 40, scene.camera.screen.y as u32) >= 0.5 {
                self.specular_scatter(scene, r)
            } else {
                self.diffuse_scatter(scene, r)
            }
        } else if self.specular() > 0.0 {
            self.specular_scatter(scene, r)
        } else if self.diffuse() > 0.0 {
            self.diffuse_scatter(scene, r)
        } else {
            ScatterRes::new(Vec3::Y, false, 1.0, 0.0, self.albedo(), false)
        }
    }
}

struct ScatterRes {
    dir: Vec3,
    scatter: bool,
    albedo: Vec3,
    fresnel: f32,
    radiance: f32,
    refracted: bool,
}

impl ScatterRes {
    fn new(
        dir: Vec3,
        scatter: bool,
        radiance: f32,
        fresnel: f32,
        albedo: Vec3,
        refracted: bool,
    ) -> Self {
        Self {
            dir,
            scatter,
            albedo,
            fresnel,
            radiance,
            refracted,
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
    atmos_tx: Tex<'a>,
    atmos_sampler: &'a Sampler,
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
        atmos_tx: Tex<'a>,
        atmos_sampler: &'a Sampler,
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
            atmos_tx,
            atmos_sampler,
            diffuse,
            scatter,
            specular,
        }
    }
}

impl Scene<'_> {
    #[inline(never)]
    fn trace(&self, r: Ray) -> Material {
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
        let mut r = r;
        let mut t = ZERO;
        let mut albedo = ONE;
        let mut cos_theta = 1.0;
        let mut radiance = 1.0;

        for i in 0..self.bounces {
            let h = if r.should_trace_interior() {
                self.trace_inside(r)
            } else {
                self.trace(r)
            };

            // let h = self.trace(r);
            r = r.at(r.pd(h.dist()));

            {
                if !h.valid() {
                    t += albedo * self.sample_atmos(r) * radiance;
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

            // sample light at this location
            albedo *= l.albedo * radiance;
            t += albedo * self.sample_point(h, r, &l) * radiance;

            radiance *= l.radiance;

            if !l.scatter {
                break;
            }

            r = r.dir(l.dir).trace_interior(l.refracted && h.dist() > 0.0);
        }

        t
    }

    fn sample_point(&self, h: Material, r: Ray, l: &ScatterRes) -> Vec3 {
        let mut col = ZERO;

        if h.diffuse() > 0.0 {
            col += h.diffuse()
                * h.albedo()
                * self.sample_direct_diff_spherical(r.offset_seed(UVec2::ONE * 23), h.normal())
        }

        if h.scattering_scale() > 0.0 {
            col += h.scattering_scale()
                * h.scattering_color()
                * self.sample_scattering(r.offset_seed(UVec2::ONE * 24), h.normal())
        }

        // todo specular highlights...
        col = (1.0 - l.fresnel) * col;

        if h.specular() > 0.0 {
            let cl = self.light_map(r.o);
            let ls = self.spherical_light_sample(cl, r);
            let v = -r.d;
            let n = h.normal();
            let n_dot_v = n.dot(v).max(0.0);
            let alpha = h.roughness().powf(2.0);
            let alpha2 = alpha.powf(2.0);
            let h = (v + ls) / (v + ls).length();
            let n_dot_l = n.dot(ls);
            let n_dot_h = n.dot(h).max(0.0);

            if n_dot_l > 0.0 {
                let sr = r.at(r.o + (ls * 0.02)).dir(ls);
                let hit = self.trace(sr);

                let k_direct = (alpha2 + 1.0) / 8.0;

                if hit.emissive() > 0.0 {
                    let attn = 1.0 / (hit.dist() * hit.dist());
                    let in_radiance = hit.albedo() * attn;
                    let d_term = d_term_ggxtr(n_dot_h, alpha);
                    let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
                    col += in_radiance * g_term * l.fresnel * d_term / (4.0 / n_dot_v);
                }
            }
        }

        col
    }

    fn map(&self, posi: Vec3) -> Vec2 {
        let l = sphere(posi - LIGHT_POS, LIGHT_RAD);
        let s = shape(posi, self.globals.time.x, self.globals.seed);
        let p = plane(posi, vec4(0.0, 1.0, 0.0, 0.0)); // TODO - readd

        let l = vec2(l, 0.0);
        let s = vec2(s, 1.0);
        let p = vec2(p, 2.0);

        let s2 = vec2(sphere(posi - vec3(-1.0, 1.0, 0.0), 0.6), 3.0);

        min_sd(min_sd(min_sd(l, s), s2), p)
        // min_sd(l, s2)
        // min_sd(min_sd(l, s2), p)
    }

    fn lookup_mat(&self, _r: Ray, _p: Vec3, h: Vec2, t: f32, normal: Vec3) -> Material {
        let i = h.y as usize;

        if i > self.materials.len() - 1 {
            return Material::default().with_normal(normal).with_dist(t);
        }

        self.materials[i].with_normal(normal).with_dist(t)
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

    fn spherical_light_sample(&self, cl: Light, r: Ray) -> Vec3 {
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

    fn get_random_sample(&self, r: Ray) -> Vec3 {
        let ct = (1.0 - rng01(r.spos.xy(), r.seed.y, self.camera.screen.y as u32)).sqrt();
        let st = (1.0 - (ct * ct)).max(0.0).sqrt();
        let phi = rng01(r.spos.yx(), r.seed.y, self.camera.screen.x as u32) * 2.0 * PI;
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

    fn sample_atmos(&self, sr: Ray) -> Vec3 {
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

            if h.x < 0.001 {
                return self.lookup_mat(r, p, h, t, self.calc_normal(p));
            }

            if t > TMAX {
                break;
            }

            t += h.x
        }

        Material::default()
    }

    fn sample_scattering(&self, r: Ray, n: Vec3) -> Vec3 {
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
    fn sample_refractive_brdf(&self, normal: Vec3, ri: f32, alpha2: f32, r: Ray) -> Vec3 {
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

        // Compute the angles based on refraction index
        let cos_theta_i = ((1.0 - u0) / (alpha2 * u0 + 1.0 - alpha2)).sqrt();
        let sin_theta_i = ((1.0 - (cos_theta_i * cos_theta_i)).max(0.0)).sqrt();

        // Apply Snell's law to compute the refracted angle
        let sin_theta_t_max = (ri * sin_theta_i).min(1.0);
        let cos_theta_t = ((ri.powi(2)) * (1.0 - sin_theta_t_max.powi(2))).sqrt();

        // Clamp to avoid numerical errors
        let cos_theta_t = cos_theta_t.clamp(-1.0, 1.0);

        let phi = u1 * 2.0 * PI;
        let direction = vec3(
            phi.cos() * sin_theta_t_max,
            cos_theta_t,
            phi.sin() * sin_theta_t_max,
        );

        // Transform the direction to world space
        translate_to_ws(direction, normal)
    }

    fn sample_reflection_brdf(&self, normal: Vec3, alpha2: f32, r: Ray) -> Vec3 {
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
