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
    let y = textureLoad(voxel_depth, id).xy;

    let vis = compute_voxel_visibility(y.y);

    textureStore(voxel_depth, vec3u(id), vec4f(y.x, y.y, vis.y, 1.0));
}

fn compute_voxel_visibility(chemical_b_concentration: f32) -> vec2f {
    // Hardcoded constants from the UI defaults
    let exponent: f32 = 3.3;
    let alpha_global: f32 = 1.0;
    let alpha_threshold: f32 = 0.0001;

    // Compute the alpha value
    let alpha = pow(chemical_b_concentration, exponent) * alpha_global;

    // Determine if the voxel is visible
    let visible = alpha >= alpha_threshold;

    return vec2f(f32(visible), alpha);
}