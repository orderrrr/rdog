use rdog_lib::mix::Mix;
use rdog_lib::prelude::*;
use spirv_std::{
    glam::{vec3, UVec3, Vec2, Vec3, Vec3Swizzles},
    num_traits::Pow,
};

pub const SIZE: u32 = 16;

const PI: f32 = 3.14159265358979323846;

pub const CAMERA_HEIGHT: f32 = 10.;

pub fn escape(p: Vec3, d: Vec3, r: f32) -> f32 {
    let v = p;
    let b = v.dot(d);
    let c = v.dot(v) - (r * r);
    let det2 = (b * b) - c;
    if det2 < 0. {
        return -1.;
    };
    let det = det2.sqrt();
    let t1 = -b - det;
    let t2 = -b + det;
    return if t1 >= 0. { t1 } else { t2 };
}

pub fn bg(rd: Vec3) -> Vec3 {
    let sd = (vec3(-0.5, -0.6, 0.9).normalize().dot(rd)) * 0.5 + 0.5;
    let sd = sd.pow(5.0);
    let col = vec3(0.05, 0.01, 0.15).mix(vec3(0.01, 0.05, 0.15), sd);
    col * 0.63
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] _camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _time: &Vec2,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16,
) {
    let global_id = global_id.xy();

    let uv: Vec2 = global_id.as_vec2() / Vec2::new(16.0, 16.0 * 16.0);

    let phi = uv.x * 2.0 * PI;
    let theta = (1.0 - uv.y) * PI;

    let direction = vec3(
        (theta).sin() * (phi).cos(),
        (theta).cos(),
        (theta).sin() * (phi).sin(),
    );

    let _bg = bg(direction);

    // let camera_position = vec3(0.0, CAMERA_HEIGHT, 0.0);
    // let camera_vector = direction; // TODO - see if this ok;

    // scatter(
    //     camera_position,
    //     camera_vector,
    //     light_dir,
    //     uvMouse,
    //     moon_light_dir,
    //     a_pos,
    //     aur.rgb,
    //     BR1,
    //     bM11,
    //     MI1,
    //     RI1,
    //     Hm1,
    //     g1,
    //     raleigh,
    //     scat,
    //     themie,
    //     thesun,
    //     themoon,
    //     depthM,
    //     auro,
    // );

    let col = Vec3::splat(escape(Vec3::splat(0.0), direction, 8.0));
    let col = uv.extend(col.x);

    unsafe {
        out.write(global_id, col.extend(1.0));
    }
}
