use rdog_lib::prelude::*;
use spirv_std::glam::{vec4, Vec2, Vec4};

use crate::atmosphere::atmosphere::{EARTH_RADIUS, HPI};

// Function to rotate a vector using a rotor
fn rotate_vector(q: Vec4, v: Vec3) -> Vec3 {
    let u = q.xyz();
    let s = q.w;
    2.0 * u.dot(v) * u + (s * s - u.dot(u)) * v + 2.0 * s * u.cross(v)
}

// Function to create a rotor (quaternion) for rotation around y-axis
fn rotor_y(a: f32) -> Vec4 {
    let ha = a * 0.5;
    vec4(0.0, ha.sin(), 0.0, ha.cos())
}

fn axis_angle_rotate(v: Vec3, axis: Vec3, a: f32) -> Vec3 {
    let ha = a * 0.5;
    let sh = ha.sin();

    let s = ha.cos();
    let b = axis * sh;

    let temp = b.cross(v) + s * v;
    v + 2.0 * b.cross(temp)
}

fn sd_round_box(p: Vec3, b: Vec3, r: f32) -> f32 {
    let q = p.abs() - b + r;
    (q.max(Vec3::splat(0.0))).length() + q.y.max(q.z).max(q.x).min(0.0) - r
}

fn sphere(p: Vec3, r: f32) -> f32 {
    p.length() - r
}

fn map(pos: Vec3, elapsed: f32) -> f32 {
    let p = axis_angle_rotate(pos, vec3(0.2, 0.0, 1.5).normalize(), elapsed);
    let b = sd_round_box(p, Vec3::splat(0.2), 0.05);
    let s = sphere(pos - vec3(0.0, EARTH_RADIUS, 0.0), EARTH_RADIUS);

    s.min(b)
}

fn calc_normal(pos: Vec3, el: f32) -> Vec3 {
    let ep = 0.0001;
    let e = Vec2::new(1.0, -1.0) * 0.5773;

    (e.xyy() * map(pos + ep * e.xyy(), el)
        + e.yyx() * map(pos + ep * e.yyx(), el)
        + e.yxy() * map(pos + ep * e.yxy(), el)
        + e.xxx() * map(pos + ep * e.xxx(), el))
    .normalize()
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

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] atmosphere_tx: Tex,
    #[spirv(descriptor_set = 1, binding = 1)] atmosphere_sampler: &Sampler,
    output: &mut Vec4,
) {
    let uv = (2.0 * pos - camera.screen).xy() / camera.screen.y;
    // let uv = uv * -1.0;

    let rotation_angle = globals.time.x * 0.5;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 0.0, 1.0));

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, -1.5))).normalize();

    let mut t = 0.;

    let mut col = sample(
        atmosphere_tx,
        atmosphere_sampler,
        world_space_to_uv(ro + rd * 1000.0),
    )
    .xyz();

    for _ in 0..84 {
        let p = ro + t * rd;
        let h = map(p, globals.time.x);
        if h < 0.001 || t > 22.0 {
            break;
        }
        t += h;
    }

    if t < 22.0 {
        let pos = ro + t * rd;
        col = calc_normal(pos, globals.time.x);
    }

    col = col.powf(2.2);

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
