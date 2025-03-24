//* #import types::{
//*     PassParams, Camera
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> pass_params: PassParams;
@group(0) @binding(2) var render: texture_storage_2d<rgba16float, read_write>;
@group(0) @binding(3) var accum: texture_storage_2d<rgba16float, read_write>;

@compute @workgroup_size(1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
    let pos = id.xy;

    let col = textureLoad(render, pos).xyz;

    let multi_frame: bool = ((pass_params.flags >> 3) & 1) == 1;

    if !multi_frame {
        textureStore(accum, pos, vec4f(col, 0.0));
        return;
    }

    let prv = textureLoad(accum, pos);

    let a = prv.w + 1.0;

    let c = vec4f(mix(col, prv.xyz, 1.0 - (1.0 / a)), a);

    textureStore(accum, pos, c);
}
