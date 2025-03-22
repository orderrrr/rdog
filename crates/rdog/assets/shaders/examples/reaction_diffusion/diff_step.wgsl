//* #import types::{
//*     PassParams, Globals, Camera
//* }
//* #import rng::{
//*     rng_state, worley
//* }
//* #import scene::{
//*     sd_torus
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

    let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;

    let y = textureLoad(voxel_depth, id).xy;
    let laplacian =
        textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(1., 0., 0.) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy
        + textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(-1, 0., 0.) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy
        + textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(0., 1., 0.) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy
        + textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(0., -1, 0.) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy
        + textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(0., 0., 1.) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy
        + textureLoad(voxel_depth, vec3u(md(vec3f(id) + vec3f(0., 0., -1) + 0.5, vec3f(pass_params.voxel_dim)) - 0.5)).xy - 6.0 * y;

    let a = y.x;
    let b = y.y;
    let ab2 = a * b * b;

        // TODO: constants
        let da_db = vec2f(1.0, 0.5);
        let k = 0.064;
        let f = 0.03;

//     // TODO: constants
//     let da_db = vec2f(1.0, 0.2);
//     let k = 0.053;
//     let f = 0.016;

     let x = max(pow(((length(pos) - 1.0) * -1.0), 2.2), 0.0);

//    let x = 1.0;
    let lap = x * laplacian;

    // let x = pow(worley(pos * f32(rng_state * 23), 0.2), 2.2);

    let dydt = da_db * lap + vec2(
        -ab2 + f * (1.0 - a),
        ab2 - (k + f) * b
    );


    let dt = 0.15;

    let out = vec4f(max(vec2(0.0), min(vec2(1.0), y + dydt * dt)), 0, 0);

    textureStore(voxel_depth, vec3u(id), vec4f(out.x, out.y, 0.0, 1.0));
}

fn md(x: vec3f, y: vec3f) -> vec3f {
    return x - y * floor(x / y);
}

// // TODO: constants
// let da_db = vec2f(1.0, 0.7);
// let k = 0.053;
// let f = 0.006;
//
// let x = max(pow(((length(pos) - 1.0) * -1.0), 2.2), 0.0);
// let lap = x * laplacian;
//
// let dydt = da_db * lap + vec2(
//     -ab2 + f * (1.0 - a),
//     ab2 - (k + f) * b
// );
