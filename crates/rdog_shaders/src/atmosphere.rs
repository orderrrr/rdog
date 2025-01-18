use coord::gather_pos;
use rdog_lib::prelude::*;
use spirv_std::glam::{UVec3, Vec2, Vec3Swizzles};

pub const NOISE_DIM: UVec2 = UVec2::new(64, 64);
pub const ATMOS_MULT: f32 = 4.0;

const DEPOLARIZATION_FACTOR: f32 = 0.035;
const MIE_COEFFICIENT: f32 = 0.005;
const MIE_DIRECTIONAL_G: f32 = 0.8;
const MIE_K_COEFFICIENT: Vec3 = vec3(0.686, 0.678, 0.666);
const MIE_V: f32 = 4.0;
const MIE_ZENITH_LENGTH: f32 = 1.25e3;
const NUM_MOLECULES: f32 = 2.542e25f32;
const PRIMARIES: Vec3 = vec3(6.8e-7f32, 5.5e-7f32, 4.5e-7f32);
const RAYLEIGH: f32 = 1.0;
const RAYLEIGH_ZENITH_LENGTH: f32 = 8.4e3;
const REFRACTIVE_INDEX: f32 = 1.0003;
const SUN_ANGULAR_DIAMETER_DEGREES: f32 = 0.0093333;
const SUN_INTENSITY_FACTOR: f32 = 1000.0;
const SUN_INTENSITY_FALLOFF_STEEPNESS: f32 = 1.5;
const TURBIDITY: f32 = 2.0;

pub struct PositionStruct {
    world_vector: Vec3,
    sun_vector: Vec3,
}

pub mod coord {
    use super::{PositionStruct, HPI};
    use rdog_lib::prelude::*;

    fn sphere_to_cart(sc: Vec3) -> Vec3 {
        let c = sc.xy().cos();
        let s = sc.xy().sin();
        sc.z * vec3(c.x * c.y, s.y, s.x * c.y)
    }

    pub fn calculate_world_space_position(p: Vec2, sphere: bool) -> Vec3 {
        let p = (p * 2.0) - 1.0;
        let mut world_space_position = vec3(p.x, p.y, 1.0);

        if sphere {
            world_space_position = sphere_to_cart(world_space_position * vec3(PI, HPI, 1.0));
        }

        world_space_position
    }

    pub fn gather_pos_with_coord(sphere: bool, uv: Vec3, _el: f32, _seed: UVec2) -> PositionStruct {
        let mouse_coord = vec2(
            0.0,
            0.0,
            // ((globals.time.x * 0.2).sin() * 0.5) + 0.5,
            // (((globals.time.x.cos() * 0.5) + 0.5) * 0.5) + 0.5,
        );

        // sun position
        let sun_vector = (calculate_world_space_position(mouse_coord, sphere)).normalize();

        PositionStruct {
            world_vector: uv,
            sun_vector,
        }
    }

    pub fn gather_pos(sphere: bool, frag_coord: Vec2, screen_res: Vec2, el: f32) -> PositionStruct {
        let mut tx_coord = frag_coord / screen_res;
        tx_coord.y = 1.0 - tx_coord.y;

        let mouse_coord = vec2(el.sin(), el.cos());
        // let mouse_coord = vec2(0.8, 0.55);

        let w_pos = calculate_world_space_position(tx_coord, sphere);
        let world_vector = w_pos.normalize();

        // sun position
        let sun_vector = (calculate_world_space_position(mouse_coord, sphere)).normalize();

        PositionStruct {
            world_vector,
            sun_vector,
        }
    }
}

pub fn tonemap(col: Vec3) -> Vec3 {
    // see https://www.desmos.com/calculator/0eo9pzo1at
    const A: f32 = 2.35;
    const B: f32 = 2.8826666;
    const C: f32 = 789.7459;
    const D: f32 = 0.935;

    let z = col.powf(A);
    z / (z.powf(D) * B + Vec3::splat(C))
}

fn total_rayleigh(lambda: Vec3) -> Vec3 {
    (8.0 * PI.powf(3.0)
        * (REFRACTIVE_INDEX.powf(2.0) - 1.0).powf(2.0)
        * (6.0 + 3.0 * DEPOLARIZATION_FACTOR))
        / (3.0 * NUM_MOLECULES * lambda.powf(4.0) * (6.0 - 7.0 * DEPOLARIZATION_FACTOR))
}

fn total_mie(lambda: Vec3, k: Vec3, t: f32) -> Vec3 {
    let c = 0.2 * t * 10e-18;
    0.434 * c * PI * (((2.0 * PI) / lambda).powf(MIE_V - 2.0)) * k
}

fn rayleigh_phase(cos_theta: f32) -> f32 {
    (3.0 / (16.0 * PI)) * (1.0 + cos_theta.powf(2.0))
}

fn henyey_greenstein_phase(cos_theta: f32, g: f32) -> f32 {
    (1.0 / (4.0 * PI)) * ((1.0 - g.powf(2.0)) / (1.0 - 2.0 * g * cos_theta + g.powf(2.0)).powf(1.5))
}

fn sun_intensity(zenith_angle_cos: f32) -> f32 {
    let cutoff_angle = PI / 1.95; // Earth shadow hack
    SUN_INTENSITY_FACTOR
        * 0.0f32.max(
            1.0 - (-((cutoff_angle - acos_approx(zenith_angle_cos))
                / SUN_INTENSITY_FALLOFF_STEEPNESS))
                .exp(),
        )
}

fn sky(dir: Vec3, sun_position: Vec3, sun_intensity_extra_spec_const_factor: u32) -> Vec3 {
    let up = vec3(0.0, 1.0, 0.0);
    let sunfade = 1.0 - (1.0 - (sun_position.y / 450000.0).clamp(0.0, 1.0).exp());
    let rayleigh_coefficient = RAYLEIGH - (1.0 * (1.0 - sunfade));
    let beta_r = total_rayleigh(PRIMARIES) * rayleigh_coefficient;

    // Mie coefficient
    let beta_m = total_mie(PRIMARIES, MIE_K_COEFFICIENT, TURBIDITY) * MIE_COEFFICIENT;

    // Optical length, cutoff angle at 90 to avoid singularity
    let zenith_angle = acos_approx(up.dot(dir).max(0.0));
    let denom = (zenith_angle).cos() + 0.15 * (93.885 - ((zenith_angle * 180.0) / PI)).powf(-1.253);

    let s_r = RAYLEIGH_ZENITH_LENGTH / denom;
    let s_m = MIE_ZENITH_LENGTH / denom;

    // Combined extinction factor
    let fex = (-(beta_r * s_r + beta_m * s_m)).exp();

    // In-scattering
    let sun_direction = sun_position.normalize();
    let cos_theta = dir.dot(sun_direction);
    let beta_r_theta = beta_r * rayleigh_phase(cos_theta * 0.5 + 0.5);

    let beta_m_theta = beta_m * henyey_greenstein_phase(cos_theta, MIE_DIRECTIONAL_G);
    let sun_e = sun_intensity(sun_direction.dot(up))

    // HACK(eddyb) this acts like an integration test for specialization constants,
    // but the correct value is only obtained when this is a noop (multiplies by `1`).
        * (sun_intensity_extra_spec_const_factor as f32 / 100.0);

    let mut lin =
        (sun_e * ((beta_r_theta + beta_m_theta) / (beta_r + beta_m)) * (Vec3::splat(1.0) - fex))
            .powf(1.5);

    lin *= Vec3::splat(1.0).lerp(
        (sun_e * ((beta_r_theta + beta_m_theta) / (beta_r + beta_m)) * fex).powf(0.5),
        ((1.0 - up.dot(sun_direction)).powf(5.0)).clamp(0.0, 1.0),
    );

    // Composition + solar disc
    let sun_angular_diameter_cos = SUN_ANGULAR_DIAMETER_DEGREES.cos();
    let sundisk =
        (sun_angular_diameter_cos).smoothstep(sun_angular_diameter_cos + 0.00002, cos_theta);
    let mut l0 = 0.1 * fex;
    l0 += sun_e * 19000.0 * fex * sundisk;

    lin + l0
}

fn get_ray_dir(uv: Vec2, pos: Vec3, look_at_pos: Vec3) -> Vec3 {
    let forward = (look_at_pos - pos).normalize();
    let right = vec3(0.0, 1.0, 0.0).cross(forward).normalize();
    let up = forward.cross(right);
    (forward + uv.x * right + uv.y * up).normalize()
}

fn calc_atmosphere(
    coord: Vec2,
    camera: &Camera,
    el: f32,
    seed: UVec2,

    noise_tx: Tex<'_>,
    noise_sampler: &Sampler,
) -> Vec3 {
    let pos = gather_pos(true, coord, camera.screen.xy() * ATMOS_MULT, el);

    let col = sky(pos.world_vector, pos.sun_vector, 100);

    col
}

#[spirv(compute(threads(1)))]
pub fn atmosphere(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,

    #[spirv(descriptor_set = 0, binding = 2)] noise_tx: Tex<'_>,
    #[spirv(descriptor_set = 0, binding = 3)] noise_sampler: &Sampler,

    #[spirv(descriptor_set = 0, binding = 4)] out: TexRgba16<'_>,
) {
    let pos = global_id.xy().as_vec2();
    // pos.y = (camera.screen.y * ATMOS_MULT) - pos.y;

    let col = calc_atmosphere(
        pos,
        camera,
        globals.time.x,
        globals.seed,
        noise_tx,
        noise_sampler,
    );

    // Tonemapping
    let col = col.max(Vec3::splat(0.0)).min(Vec3::splat(1024.0));
    let col = tonemap(col);
    let col = col.powf(1.0 / 2.2);

    unsafe {
        out.write(global_id.xy(), col.extend(1.0));
    }
}

#[spirv(compute(threads(1)))]
pub fn noise(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 1)] out: TexRgba16<'_>,
) {
    let rng = rng01(global_id.xy().as_vec2(), globals.seed.x, NOISE_DIM.x) * 0.97;

    unsafe {
        out.write(global_id.xy(), Vec3::splat(rng).extend(1.0));
    }
}
