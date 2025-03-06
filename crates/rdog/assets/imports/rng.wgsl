#define_import_path rng

var<private> rng_state: u32;

fn rand_f() -> f32 {
    rng_state = rng_state * 747796405u + 2891336453u;
    let word = ((rng_state >> ((rng_state >> 28u) + 4u)) ^ rng_state) * 277803737u;
    return f32((word >> 22u) ^ word) * bitcast<f32>(0x2f800004u);
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
