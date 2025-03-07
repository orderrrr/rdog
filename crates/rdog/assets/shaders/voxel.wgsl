//* #import rng::{
//*     rng_state
//* }
//* #import scene::{
//*     map
//* }
//* #import types::{
//*     PassParams, Globals, Camera
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(2) @binding(0) var out: texture_storage_3d<rgba16float, read_write>;

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
    let vd = pass_params.voxel_dim;
    rng_state = u32(id.x + (id.y * vd) + (id.z * vd * vd)) * globals.seed.y;

    let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;

    let dist = map(pos);
    var col = vec4f(pos.zy, 0.0, dist.x);

    let voxel_size = 2.0 / f32(vd);
    col.w = floor(col.w / voxel_size);

    textureStore(out, vec3u(id), col);
}
