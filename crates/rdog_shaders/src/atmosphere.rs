use coord::gather_pos;
use rdog_lib::prelude::*;
use spirv_std::glam::{UVec3, Vec2, Vec3Swizzles};

pub const ATMOS_MULT: f32 = 4.0;

#[inline]
fn d0(x: Vec3) -> Vec3 {
    x.abs() + 1e-8
}

#[inline]
fn d02(x: Vec3) -> Vec3 {
    x.abs() + 1e-3
}

// TODO - I would prefer to do vec3 instantiation and then * 1e-5 but for some reason does not work
// const RAYLEIGH_COEFF: Vec3 = vec3(0.27, 0.5, 1.0) * 1e-5;
pub const NOISE_DIM: UVec2 = UVec2::new(64, 64);
const SPHERICAL_PROJECTION: bool = true;
const RAYLEIGH_COEFF: Vec3 = vec3(0.27 * 1e-5, 0.5 * 1e-5, 1.0 * 1e-5);
const MIE_COEFF: Vec3 = Vec3::splat(0.5e-6);
const TOTAL_COEFF: Vec3 = Vec3::new(
    RAYLEIGH_COEFF.x + MIE_COEFF.x,
    RAYLEIGH_COEFF.y + MIE_COEFF.y,
    RAYLEIGH_COEFF.z + MIE_COEFF.z,
);
const SUN_BRIGHTNESS: f32 = 2.5;
pub const EARTH_RADIUS: f32 = 6371000.0; // TODO move
const CLOUD_HEIGHT: f32 = 1600.0;
const CLOUD_THICKNESS: f32 = 500.0;
const CLOUD_MIN_HEIGHT: f32 = CLOUD_HEIGHT;
pub const CLOUD_MAX_HEIGHT: f32 = CLOUD_THICKNESS + CLOUD_MIN_HEIGHT;
const CLOUD_DENSITY: f32 = 0.03;
const CLOUD_SPEED: f32 = 0.02;

const VOLUMETRIC_CLOUD_STEPS: u32 = 16; //Higher is a better result with rendering of clouds.
const CLOUD_SHADOWING_STEPS: u32 = 8; //Higher is a better result with shading on clouds.

const RPI: f32 = 1.0 / PI;
pub const HPI: f32 = PI * 0.5; // TODO move out
const RLOG2: f32 = 1.0 / 0.69314718056;

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

    pub fn gather_pos_with_coord(sphere: bool, uv: Vec3, globals: &Globals) -> PositionStruct {
        let mouse_coord = vec2(
            ((globals.time.x * 0.2).sin() * 0.5) + 0.5,
            (((globals.time.x.cos() * 0.5) + 0.5) * 0.5) + 0.5,
        );

        // sun position
        let sun_vector = (calculate_world_space_position(mouse_coord, sphere)).normalize();

        PositionStruct {
            world_vector: uv,
            sun_vector,
        }
    }

    pub fn gather_pos(sphere: bool, frag_coord: Vec2, screen_res: Vec2) -> PositionStruct {
        let mut tx_coord = frag_coord / screen_res;
        tx_coord.y = 1.0 - tx_coord.y;

        let mouse_coord = vec2(0.8, 0.55);

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

fn bayer_2(a: Vec2) -> f32 {
    let a = a.floor();
    a.dot(vec2(0.5, a.y * 0.75)).fract()
}
#[inline]
fn bayer_4(a: Vec2) -> f32 {
    bayer_2(0.5 * a) * 0.25 + bayer_2(a)
}
#[inline]
fn bayer_8(a: Vec2) -> f32 {
    bayer_4(0.5 * a) * 0.25 + bayer_2(a)
}
#[inline]
fn bayer_16(a: Vec2) -> f32 {
    bayer_8(0.5 * a) * 0.25 + bayer_2(a)
}

fn ray_sphere_intersection(position: Vec3, direction: Vec3, radius: f32) -> Vec2 {
    let pod = position.dot(direction);
    let radius_squared = radius * radius;

    let mut delta = (pod * pod) + radius_squared - position.dot(position);
    if delta < 0.0 {
        return Vec2::splat(-1.0);
    }
    delta = delta.sqrt();

    return -pod + vec2(-delta, delta);
}

fn scatter(coeff: Vec3, depth: f32) -> Vec3 {
    return coeff * depth;
}

fn absorb(coeff: Vec3, depth: f32) -> Vec3 {
    scatter(coeff, -depth).exp2()
}

fn calc_particle_thickness(depth: f32) -> f32 {
    return 100_000.0 / ((depth * 2.0) - 0.01).max(0.01);
}

fn rayleigh_phase(x: f32) -> f32 {
    0.375 * (1.0 + (x * x))
}

fn hg_phase(x: f32, g: f32) -> f32 {
    let g2 = g * g;
    0.25 * ((1.0 - g2) * (1.0 + g2 - (2.0 * g * x)).powf(-1.5))
}

fn mie_phase_sky(x: f32, depth: f32) -> f32 {
    return hg_phase(x, (-0.000003 * depth).exp2());
}

fn powder(od: f32) -> f32 {
    return 1.0 - (-od * 2.0).exp2();
}

fn calculate_scatter_integral(optical_depth: f32, coeff: f32) -> f32 {
    let a = -coeff * RLOG2;
    let b = -1.0 / coeff;
    let c = 1.0 / coeff;
    return (a * optical_depth).exp2() * b + c;
}

fn calc_atmospheric_scatter(pos: &PositionStruct, absorb_light: &mut Vec3) -> Vec3 {
    let ln2 = f32::ln(2.0);

    let l_dot_w = pos.sun_vector.dot(pos.world_vector);
    let l_dot_u = pos.sun_vector.dot(vec3(0.0, 1.0, 0.0));
    let u_dot_w = vec3(0.0, 1.0, 0.0).dot(pos.world_vector);

    let optical_depth = calc_particle_thickness(u_dot_w);
    let optical_depth_light = calc_particle_thickness(l_dot_u);

    let scatter_view = scatter(TOTAL_COEFF, optical_depth);
    let absorb_view = absorb(TOTAL_COEFF, optical_depth);

    let scatter_light = scatter(TOTAL_COEFF, optical_depth_light);
    *absorb_light = absorb(TOTAL_COEFF, optical_depth_light);

    let absorb_sun = (*absorb_light - absorb_view).abs() / d0((scatter_light - scatter_view) * ln2);

    let mie_scatter = scatter(MIE_COEFF, optical_depth) * mie_phase_sky(l_dot_w, optical_depth);
    let raylleigh_scatter = scatter(RAYLEIGH_COEFF, optical_depth) * rayleigh_phase(l_dot_w);

    let scatter_sun = mie_scatter + raylleigh_scatter;

    let sun_spot = Vec3::splat(0.9999.smoothstep(0.99993, l_dot_w)) * absorb_view * SUN_BRIGHTNESS;

    return (scatter_sun * absorb_sun + sun_spot) * SUN_BRIGHTNESS;
}

fn calc_atmospheric_scatter_top(pos: &PositionStruct) -> Vec3 {
    let ln2 = f32::ln(2.0);

    let l_dot_u = pos.sun_vector.dot(vec3(0.0, 1.0, 0.0));

    let optical_depth = calc_particle_thickness(1.0);
    let optical_depth_light = calc_particle_thickness(l_dot_u);

    let scatter_view = scatter(TOTAL_COEFF, optical_depth);
    let absorb_view = absorb(TOTAL_COEFF, optical_depth);

    let scatter_light = scatter(TOTAL_COEFF, optical_depth_light);
    let absorb_light = absorb(TOTAL_COEFF, optical_depth_light);

    let absorb_sun = d02(absorb_light - absorb_view) / d02((scatter_light - scatter_view) * ln2);

    let mie_scatter = scatter(MIE_COEFF, optical_depth) * 0.25;
    let raylleigh_scatter = scatter(RAYLEIGH_COEFF, optical_depth) * 0.375;

    let scatter_sun = mie_scatter + raylleigh_scatter;

    return (scatter_sun * absorb_sun) * SUN_BRIGHTNESS;
}

fn get_3d_noise(pos: Vec3, tx: Tex<'_>, smp: &Sampler) -> f32 {
    let p = pos.z.floor();
    let f = pos.z - p;

    let inv_noise_res = 1.0 / 64.0;

    let z_stretch = 17.0 * inv_noise_res;

    let coord = pos.xy() * inv_noise_res + (p * z_stretch);

    let noise = vec2(
        sample(tx, smp, coord).x,
        sample(tx, smp, coord + z_stretch).x,
    );

    noise.x.mix(noise.y, f)
}

fn get_clouds(p: Vec3, globals: &Globals, tx: Tex<'_>, sampler: &Sampler) -> f32 {
    let p = vec3(
        p.x,
        (p + vec3(0.0, EARTH_RADIUS, 0.0)).length() - EARTH_RADIUS,
        p.z,
    );

    if p.y < CLOUD_MIN_HEIGHT || p.y > CLOUD_MAX_HEIGHT {
        return 0.0;
    }

    let time = globals.time.x * CLOUD_SPEED;
    let movement = vec3(time, 0.0, time);
    let cloud_coord = (p * 0.001) + movement;

    let mut noise = get_3d_noise(cloud_coord, tx, sampler) * 0.5;
    noise += get_3d_noise(cloud_coord * (2.0 + movement), tx, sampler) * 0.25;
    noise += get_3d_noise(cloud_coord * (7.0 - movement), tx, sampler) * 0.125;
    noise += get_3d_noise((cloud_coord + movement) * 16.0, tx, sampler) * 0.0625;

    let top = 0.004;
    let bot = 0.01;

    let h_height = p.y - CLOUD_MIN_HEIGHT;
    let threshhold = (1.0 - (-bot * h_height).exp2()) * (-top * h_height).exp2();

    let clouds = (0.55.smoothstep(0.6, noise)) * threshhold;

    return clouds * CLOUD_DENSITY;
}

fn get_sun_visibility(
    p: Vec3,
    pos: &PositionStruct,
    globals: &Globals,
    tx: Tex<'_>,
    smp: &Sampler,
) -> f32 {
    let steps = CLOUD_SHADOWING_STEPS;
    let r_steps = CLOUD_THICKNESS / (steps as f32);

    let increment = pos.sun_vector * r_steps;
    let position = increment * 0.5 + p;

    let mut transmittance = 0.0;

    for _ in 0..CLOUD_SHADOWING_STEPS {
        transmittance += get_clouds(position, globals, tx, smp);
    }

    return (-transmittance * r_steps).exp2();
}

fn phase_2_lobes(x: f32) -> f32 {
    let m = 0.6;
    let gm = 0.8;

    let lobe1 = hg_phase(x, 0.8 * gm);
    let lobe2 = hg_phase(x, -0.5 * gm);

    return lobe2.mix(lobe1, m);
}

fn get_volumetric_clouds_scattering(
    optical_depth: f32,
    phase: f32,
    p: Vec3,
    sun_color: Vec3,
    sky_light: Vec3,
    pos: &PositionStruct,
    globals: &Globals,
    tx: Tex<'_>,
    smp: &Sampler,
) -> Vec3 {
    let integral = calculate_scatter_integral(optical_depth, 1.11);

    let beers_powder = powder(optical_depth * f32::ln(2.0));

    let sun_lighting = (sun_color * get_sun_visibility(p, pos, globals, tx, smp) * beers_powder)
        * phase
        * HPI
        * SUN_BRIGHTNESS;
    let sky_lighting = sky_light * 0.25 * RPI;

    return (sun_lighting + sky_lighting) * integral * PI;
}

fn calculate_volumetric_clouds(
    pos: &PositionStruct,
    color: Vec3,
    dither: f32,
    sun_color: Vec3,
    globals: &Globals,
    tx: Tex<'_>,
    sampler: &Sampler,
) -> Vec3 {
    let steps = VOLUMETRIC_CLOUD_STEPS;
    let isteps = 1.0 / (steps as f32);

    let bottom_sphere = ray_sphere_intersection(
        vec3(0.0, 1.0, 0.0) * EARTH_RADIUS,
        pos.world_vector,
        EARTH_RADIUS + CLOUD_MIN_HEIGHT,
    )
    .y;
    let top_sphere = ray_sphere_intersection(
        vec3(0.0, 1.0, 0.0) * EARTH_RADIUS,
        pos.world_vector,
        EARTH_RADIUS + CLOUD_MAX_HEIGHT,
    )
    .y;

    let start_position = pos.world_vector * bottom_sphere;
    let end_position = pos.world_vector + top_sphere;

    let increment = (end_position - start_position) * isteps;
    let mut cloud_pos = increment * dither + start_position;

    let step_len = increment.length();

    let mut scattering = Vec3::ZERO;
    let mut transmittance = 1.0;

    let l_dot_w = pos.sun_vector.dot(pos.world_vector);
    let phase = phase_2_lobes(l_dot_w);

    let sky_light = calc_atmospheric_scatter_top(pos);

    for _ in 0..steps {
        let optical_depth = get_clouds(cloud_pos, globals, tx, sampler) * step_len;

        if optical_depth <= 0.0 {
            continue;
        }

        scattering += get_volumetric_clouds_scattering(
            optical_depth,
            phase,
            cloud_pos,
            sun_color,
            sky_light,
            &pos,
            globals,
            tx,
            sampler,
        ) * transmittance;
        transmittance *= (-optical_depth).exp2();

        cloud_pos += increment;
    }

    return (color * transmittance + scattering)
        .mix(color, (start_position.length() * 0.00001).clamp(0.0, 1.0));
}

fn calc_atmosphere(
    coord: Vec2,
    camera: &Camera,
    globals: &Globals,

    noise_tx: Tex<'_>,
    noise_sampler: &Sampler,
) -> Vec3 {
    let pos = gather_pos(SPHERICAL_PROJECTION, coord, camera.screen.xy() * ATMOS_MULT);

    let dither = bayer_16(coord);

    let mut light_absorb = Vec3::ZERO;

    let mut col = calc_atmospheric_scatter(&pos, &mut light_absorb);
    col = calculate_volumetric_clouds(
        &pos,
        col,
        dither,
        light_absorb,
        globals,
        noise_tx,
        noise_sampler,
    );

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
    let mut pos = global_id.xy().as_vec2();
    pos.y = (camera.screen.y * ATMOS_MULT) - pos.y;

    let col = calc_atmosphere(pos, camera, globals, noise_tx, noise_sampler);

    unsafe {
        out.write(global_id.xy(), col.extend(1.0));
    }
}

#[spirv(compute(threads(1)))]
pub fn noise(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 1)] out: TexRgba8<'_>,
) {
    let rng = rng01(global_id.xy().as_vec2(), globals.seed.x, NOISE_DIM.x) * 0.97;

    unsafe {
        out.write(global_id.xy(), Vec3::splat(rng).extend(1.0));
    }
}
