//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, Hit, ScatterRes, OCTree
//* }

@group(0) @binding(0) var<uniform> pass_params: PassParams;
@group(0) @binding(1) var<uniform> camera: Camera;
@group(0) @binding(2) var<uniform> globals: Globals;
@group(1) @binding(0) var trace: texture_2d<f32>;
@group(1) @binding(1) var trace_sample: sampler;
@group(1) @binding(2) var voxel: texture_3d<f32>;
@group(1) @binding(3) var voxel_sample: sampler;

@fragment
fn fs(@builtin(position) vertex: vec4f) -> @location(0) vec4f {
    // let col = srgb_vec(textureLoad(trace, vec2u(vertex.xy)).xyz);
    // let col = textureLoad(trace, vec2u(vertex.xy)).xyz;

    let uv = vec2f(vertex.xy) / vec2f(globals.true_res);
    let col = textureSample(trace, trace_sample, uv);

    return vec4f(col.xyz, 1.0);
}

@vertex
fn vs(@builtin(vertex_index) vidx: u32) -> @builtin(position) vec4f {
    return full_screen_triangle(vidx);
}

fn srgb_vec(col: vec3f) -> vec3f {
    return vec3f(srgb(col.x), srgb(col.y), srgb(col.z));
}

fn srgb(channel: f32) -> f32 {
    if channel <= 0.00031308 {
        return channel * 12.92;
    } else {
        return 1.055 * pow(channel, 1.0 / 2.4) - 0.055;
    }
}

fn full_screen_triangle(vert_idx: u32) -> vec4f {
    let uv = vec2(f32((vert_idx << 1) & 2), f32(vert_idx & 2));
    let pos = 2.0 * uv - vec2f(1.0);

    return vec4(pos, 0.0, 1.0);
}
