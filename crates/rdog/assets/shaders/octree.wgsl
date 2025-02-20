var<private> rng_state: u32;

struct PassParams {
    sun_x: f32,
    sun_y: f32,
    pass_count: u32,
    bounce_count: u32,
    flags: u32,
    voxel_dim: u32,
}

struct Globals {
    time: vec2f,
    seed: vec2u,
}

@group(0) @binding(0) var<uniform> pass_params: PassParams;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var out: texture_storage_3d<rgba16float, read_write>;

fn map(pos: vec3f) -> vec4f {
    let rng = vec3f(worley(pos, 4.0));
    let s1 = length(pos) - ((sin(0.0) * 0.25) + 0.5);
    let s2 = length(pos - vec3f(-0.5)) - 0.2;
    let d = smin(s1, s2, 0.15).x;
    return vec4f(rng, d);
}

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {
    let vd = pass_params.voxel_dim;
    rng_state = u32(id.x + (id.y * vd) + (id.z * vd * vd)) * globals.seed.y;

    let pos = ((vec3f(id) / f32(vd)) - .5) * 2.;

    let col = map(pos);

    textureStore(out, vec3u(id), col);
}

fn rand_f() -> f32 {
    rng_state = rng_state * 747796405u + 2891336453u;
    let word = ((rng_state >> ((rng_state >> 28u) + 4u)) ^ rng_state) * 277803737u;
    return f32((word >> 22u) ^ word) * bitcast<f32>(0x2f800004u);
}

fn sd_min(d1: vec2f, d2: vec2f) -> vec2f {
    if d1.x < d2.x { return d1; }
    return d2;
}

// https://www.shadertoy.com/view/MXfXzM
fn smin(a: f32, b: f32, ki: f32) -> vec2f {
    let k = ki * 6.0;
    let h = max(k - abs(a - b), 0.0) / k;
    let m = h * h * h * 0.5;
    let s = m * k * (1.0 / 3.0);
    if a < b {
        return vec2f(a - s, m);
    }

    return vec2f(b - s, 1.0 - m);
}

// https://www.shadertoy.com/view/3d3fWN
fn hash33(p3: vec3f) -> vec3f {
    var p = fract(p3 * vec3f(.1031, .11369, .13787));
    p += dot(p, p.yxz + 19.19);
    return -1.0 + 2.0 * fract(vec3((p.x + p.y) * p.z, (p.x + p.z) * p.y, (p.y + p.z) * p.x));
}
fn worley(p: vec3f, s: f32) -> f32 {
    let id = floor(p * s);
    let fd = fract(p * s);
    var md = 1.;
    for (var x = -1; x <= 1; x++) {
        for (var y = -1; y <= 1; y++) {
            for (var z = -1; z <= 1; z++) {
                let c = vec3f(vec3i(x, y, z));
                let rId = hash33(mod33(id + c, vec3f(s))) * .5 + .5;
                let r = c + rId - fd;
                let d = dot(r, r);
                if d < md { md = d; }
            }
        }
    }
    return 1. - md;
}
fn mod33(x: vec3f, y: vec3f) -> vec3f {
    return x - y * floor(x / y);
}
