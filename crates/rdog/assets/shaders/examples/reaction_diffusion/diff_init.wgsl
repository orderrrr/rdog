//* #import types::{
//*     PassParams, Globals, Camera
//* }
//* #import rng::{
//*     rng_state, worley, rand_f
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(2) @binding(0) var voxel_depth: texture_storage_3d<rgba32float, read_write>;

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
//     let vd = pass_params.voxel_dim;
//     rng_state = u32(id.x + (id.y * vd) + (id.z * vd * vd)) * globals.seed.y;
//
//     let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;
//
//     let r = length(pos);
//     let ball = smoothstep(0.5, 0.2, r);
//     let a = 1.0;
//     let f = 12.0;
//     let b = max(0.0, min(1.0, (pow(0.5 * worley(pos, 16.0), 5.) + pow(worley(pos + f32(globals.time.x) , 4.0), 5.))));
//     let out = vec4(a, b * ball, 0.0, 1);
//
// //     let rng = worley(pos, 1.23) * 1.0;
// //     let a = 1.0;
// //     let f = 12.0;
// //     let r = ((length(pos) - 1.0) * -1.0) * 2.0;
// //     let b = max((rng * (worley(pos * f32(rng_state), 1.44) * 0.25)) * r, 0.0);
// //     let out = vec4(a, b, 0, 1);
//
//     textureStore(voxel_depth, vec3u(id), out);
}

fn smoothstep(edge0: f32, edge1: f32, x: f32) -> f32 {
    // Clamp x to the range [edge0, edge1]
    let t = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0);
    
    // Apply the smoothstep polynomial: 3t² - 2t³
    return t * t * (3.0 - 2.0 * t);
}



    // let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;
    //
    // let r = (length(pos) - 1.0) * -2.0;
    // let ball = r;
    // let a = 1.0;
    // let f = 4.0;
    // let b = r;
    // // let b = max(0.0, min(1.0, 0.5 + 4.0 * cos(pos.x * f - 1.0) * cos(pos.y * f - 2.0) * cos(pos.z * f - 3.0)));
    //
    // let out = vec4(a, b * ball, 0, 1);
