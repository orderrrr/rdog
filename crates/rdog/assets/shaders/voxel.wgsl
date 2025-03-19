//* #import rng::{
//*     rng_state
//* }
//* #import scene::{
//*     map, MIN_DIST, mat_2
//* }
//* #import types::{
//*     PassParams, Globals, Camera
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(2) @binding(0) var voxel_depth: texture_storage_3d<rgba16float, read_write>;
@group(2) @binding(1) var voxel_data: texture_storage_3d<rgba16float, read_write>;

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
    let vd = pass_params.voxel_dim;
    rng_state = u32(id.x + (id.y * vd) + (id.z * vd * vd)) * globals.seed.y;

    let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;

    let dist = map(pos);

    var col = vec4f(0.0, 0.0, 0.0, dist.x);
    var data = vec4f(0.0);

    if dist.x <= MIN_DIST * 8.0 && dist.x >= -MIN_DIST * 8.0 { // TODO: check if 1.1 can be lowered

        let no = calc_normal(pos);
        col.x = no.x;
        col.y = no.y;
        col.z = no.z;
    }

    // let voxel_size = 2.0 / f32(vd);
    // col.w = floor(col.w / voxel_size);

    textureStore(voxel_depth, vec3u(id), col);
    // textureStore(depth, vec3u(id), col);
}

fn calc_normal(pos: vec3f) -> vec3f {
    let ep = 0.0001;
    let e = vec2f(1.0, -1.0) * 0.5773;

    return normalize(
        0. + e.xyy * map(pos + ep * e.xyy).x + e.yyx * map(pos + ep * e.yyx).x + e.yxy * map(pos + ep * e.yxy).x + e.xxx * map(pos + ep * e.xxx).x
    );
}

            // return Hit(t, vec3f(0.0), interior, mat_2(h));
