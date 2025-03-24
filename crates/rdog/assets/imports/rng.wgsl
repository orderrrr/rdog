#define_import_path rng
//* #import util::{
//*     EPSILON, ONE, ZERO, PI
//* }

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

fn random_in_unit_disk() -> vec2f {
    var p: vec2f;
    for (var i = 0; i < 100; i++) {
        p = 2.0 * vec2f(rand_f(), rand_f()) - vec2f(1.0, 1.0);
        if dot(p, p) < 1.0 {
            break;
        }
    }
    return p;
}

fn SPH(d: vec3f, r: f32) -> f32 {
    return length(d) - r * r * 0.55;
}

fn hash(pos: vec3f) -> f32 {
    let p = 17.0 * fract(pos * 0.3183099 + vec3(.11, .17, .13));
    return fract(p.x * p.y * p.z * (p.x + p.y + p.z));
}

fn simplex_33(p: vec3f) -> f32 {
    let K1 = 0.333333333;
    let K2 = 0.166666667;
    let i = floor(p + (p.x + p.y + p.z) * K1);
    let d0 = p - (i - (i.x + i.y + i.z) * K2);
    let e = step(d0.yzx, d0);
    let i1 = e * (1.0 - e.zxy);
    let i2 = 1.0 - e.zxy * (1.0 - e);

    let d1 = d0 - (i1 - 1.0 * K2);
    let d2 = d0 - (i2 - 2.0 * K2);
    let d3 = d0 - (1.0 - 3.0 * K2);
    let r0 = hash(i + 0.0);
    let r1 = hash(i + i1);
    let r2 = hash(i + i2);
    let r3 = hash(i + 1.0);
    return min(min(SPH(d0, r0),
        SPH(d1, r1)),
        min(SPH(d2, r2),
        SPH(d3, r3)));
}

fn step(edge: vec3f, x: vec3f) -> vec3f {
    return vec3f(
        select(0.0, 1.0, x.x >= edge.x),
        select(0.0, 1.0, x.y >= edge.y),
        select(0.0, 1.0, x.z >= edge.z)
    );
}

fn get_random_sample() -> vec3f {
    let ct = sqrt(1.0 - rand_f());
    let st = sqrt(max(1.0 - (ct * ct), 0.0));
    let phi = rand_f() * 2.0 * PI;
    return vec3f(cos(phi) * st, ct, sin(phi) * st);
}

fn random_in_unit_sphere() -> vec3f {
    let rand = vec3(rand_f(), rand_f(), rand_f());
    let phi = 2.0 * PI * rand.x;
    let cos_theta = 2.0 * rand.y - 1.0;
    let u = rand.z;

    let theta = acos(cos_theta);
    let r = pow(u, 1.0 / 3.0);

    let x = r * sin(theta) * cos(phi);
    let y = r * sin(theta) * sin(phi);
    let z = r * cos(theta);

    return vec3f(x, y, z);
}

fn random_on_hemisphere(normal: vec3f) -> vec3f {
    let rd = random_in_unit_sphere();
    let res = rd + normal;

    return normalize(res);
}
