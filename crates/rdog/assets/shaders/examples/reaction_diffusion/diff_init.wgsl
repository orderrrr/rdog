//* #import types::{
//*     PassParams, Globals, Camera
//* }
//* #import rng::{
//*     rng_state
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(2) @binding(0) var voxel_depth: texture_storage_3d<rgba32float, read_write>;

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
    let vd = pass_params.voxel_dim;
    rng_state = u32(id.x + (id.y * vd) + (id.z * vd * vd)) * globals.seed.y;

    let pos = (vec3f(id) + 0.5) / f32(vd);

    let r = length(pos - 0.5);
    let ball = smoothstep(0.25, 0.2, r);
    let a = 1.0;
    let f = 12.0;
    let b = max(0.0, min(1.0, 0.5 + 4.0 * cos(pos.x * f - 1.0) * cos(pos.y * f - 2.0) * cos(pos.z * f - 3.0)));

    let out = vec4(a, b * ball, 0, 1);

    textureStore(voxel_depth, vec3u(id), out);
}

fn smoothstep(edge0: f32, edge1: f32, x: f32) -> f32 {
    // Clamp x to the range [edge0, edge1]
    let t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    
    // Apply the smoothstep polynomial: 3t² - 2t³
    return t * t * (3.0 - 2.0 * t);
}
