#define_import_path cam
//* #import types::{
//*     Camera
//* }
//* #import rng::{
//*     rand_f
//* }

fn project_point3(transform: mat4x4f, rhs: vec3f) -> vec3f {
    var res: vec4f = transform[0] * rhs.x;
    res = (transform[1] * rhs.y) + res;
    res = (transform[2] * rhs.z) + res;
    res = transform[3] + res;
    res = res / res.w;
    return res.xyz;
}

fn calculate_coc(world_pos: vec3f, focal_dist: f32, camera: Camera) -> f32 {
    // Calculate circle of confusion based on depth difference
    let depth = length(world_pos - camera.origin.xyz);
    return (depth - focal_dist) * camera.af.y * camera.af.x / focal_dist;
}

fn depth_aware_jitter(coc: f32) -> vec2f {
    // Poisson disk samples for quality jittering
    let poisson = array<vec2f, 12>(
        vec2f(-0.326, -0.406), vec2f(-0.840, -0.074),
        vec2f(-0.696, 0.457), vec2f(-0.203, 0.621),
        vec2f(0.962, -0.195), vec2f(0.519, 0.767),
        vec2f(0.507, -0.641), vec2f(0.185, -0.893),
        vec2f(0.896, 0.412), vec2f(-0.322, -0.933),
        vec2f(-0.792, -0.598), vec2f(0.291, 0.195)
    );

    // Select jitter sample based on RNG state
    let idx = u32(rand_f() * 12.0);
    return poisson[idx] * coc * 0.05;
}
