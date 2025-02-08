use crate::prelude::*;

pub fn map_scene_1(scene: &Scene, p: Vec3) -> Vec2 {
    let l = scene.lights(p);

    let posi = p + vec3(1.0, 0.0, 0.0);

    let pos = aar(posi, vec3(0.05, 0.5, 0.1).normalize(), 1.0);

    let s1 = sd_round_box(pos + vec3(-1.0, -1.0, 1.0), Vec3::splat(0.5), 0.1);
    let s2 = shape(
        posi + vec3(-0.5, -1.0, 0.0),
        scene.globals.time.x,
        scene.globals.seed,
    );
    let s3 = sphere(posi + vec3(-1.0, -1.0, -1.0), 0.4);

    let p = plane(posi, vec4(0.0, 1.0, 0.0, 1.0));
    let p = vec2(p, 4.0);
    let s1 = vec2(s1, 3.0);
    let s2 = vec2(s2, 2.0);
    let s3 = vec2(s3, 5.0);

    min_sd(min_sd(min_sd(min_sd(s2, l), p), s1), s3)
}

fn shape(posi: Vec3, _el: f32, _seed: UVec2) -> f32 {
    // let pos = aar(posi + Vec3::NEG_Y, vec3(0.2, 1.0, 0.0).normalize(), el);
    let pos = aar(posi, vec3(0.2, 1.0, 0.0).normalize(), 0.5);
    let po = aar(pos, vec3(0.0, 0.0, 1.0).normalize(), -90.0_f32.to_radians());
    let pp = aar(pos, vec3(1.0, 0.0, 0.0).normalize(), -45.0_f32.to_radians());
    let o = sd_rounded_cylinder(pp + vec3(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r = op_smooth_subtraction(v, r, 0.1);

    op_smooth_union(o, r, 0.1)
}
