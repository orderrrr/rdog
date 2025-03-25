#define_import_path scene

//* #import types::{
//*     Ray, Light, LightIn, Material, MaterialIn, Camera, Globals, PassParams
//* }
//* #import rng::{
//*     rng_state, rand_f, simplex_33, worley
//* }
//* #import noisy::{
//*     simplex_noise_3d, fbm_simplex_3d
//* }

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(1) @binding(0) var<storage, read> material: array<MaterialIn>;
@group(1) @binding(1) var<storage, read> light_in: array<LightIn>;

const TMAX: f32 = 80.0;
const MIN_DIST: f32 = 0.001;
const DEFAULT_MAT: Material = Material(0.0, 0.0, 0.0, DANGER, DANGER, 0.0, 0.0, 0.0, 0.0);
const DANGER = vec3f(1.0, 0.0, 1.0);

fn map(p: vec3f) -> vec3f {
    let l = lights(p);

//    var dt = sd_fbm(p, length(p) - 1.0);
//    dt.y = 1.0 + dt.y * 2.0; dt.y = dt.y * dt.y;
//    var out = vec3(vec3f(dt.x, pack_material_ids(1.0, 2.0), dt.y));

    // var out = vec3f(length(p) - 1.0, pack_material_ids(1.0, 2.0), 0.0);

    // var out = vec3f(sd_torus(p, vec2f(0.5, 0.2)), pack_material_ids(1.0, 2.0), 0.0);
    // out.x = max(op_onion(out.x, 0.05), p.y);

    let s = vec3f(length(p - vec3f(.6, 0.0, 0.0)) - 0.4, pack_material_ids(1.0, 2.0), 0.0);

    // // if pass_params.voxel_debug > 0 {
    // var out = vec3f(sd_box_frame(p, vec3(1.0), 0.01), pack_material_ids(1.0, 1.0), 1.0);
    // // }
    // var out = vec3f(length(p - vec3f(1.0)) - 0.5, pack_material_ids(1.0, 1.0), 0.0);
    // out = sd_min3(vec3f(length(p) - 2.0, pack_material_ids(2.0, 2.0), 0.0), out);

    // var out = vec3(length(p) - 0.5, pack_material_ids(1.0, 2.0), 0.0);

//    return sd_min3(out, l);
    return sd_min3(l, s);
}

fn op_intersection(i: f32, j: f32) -> f32 {
    return max(i, j);
}

fn sample_atmos(sr: Ray) -> vec3f {
    return vec3f(
        sin(sr.o.x * 0.01) / 2.0 + 1.0,
        cos(sr.o.y * 0.005) / 2.0 + 1.0,
        sin(sr.o.y * 0.01) / 2.0 + 1.0
    ) * .2;
}

fn lights(p: vec3f) -> vec3f {
    var d = vec3f(TMAX, 0.0, 0.0);
    for (var i: u32 = 0; i < arrayLength(&light_in); i++) {
        let l = light(i);
        d = sd_min3(d, vec3f(length(p - l.p) - l.r, pack_material_ids(l.mi, l.mi), 0.0));
    }

    return d;
}

fn sd_min(d1: vec2f, d2: vec2f) -> vec2f {
    if d1.x < d2.x {
        return d1;
    }

    return d2;
}

fn sd_min3(d1: vec3f, d2: vec3f) -> vec3f {
    if d1.x < d2.x {
        return d1;
    }

    return d2;
}

fn rotor_y(angle: f32) -> vec4<f32> {
    let half_angle = angle * 0.5;
    return vec4<f32>(
        0.0,
        sin(half_angle),
        0.0,
        cos(half_angle)
    );
}

fn rotate_vector(q: vec4<f32>, v: vec3<f32>) -> vec3<f32> {
    let u = q.xyz;
    let s = q.w;
    return 2.0 * dot(u, v) * u + (s * s - dot(u, u)) * v + 2.0 * s * cross(u, v);
}

fn aar(v: vec3f, axis: vec3f, angle: f32) -> vec3f {
    let half_angle = 0.5 * angle;
    let sin_half = sin(half_angle);

    // Rotor components
    let s = cos(half_angle);
    let b = axis * sin_half;

    // Rotor multiplication: R * v * R^-1
    let temp = cross(b, v) + s * v;
    return v + 2.0 * cross(b, temp);
}

fn light(i: u32) -> Light {

    let l = light_in[i];

    return Light(
        l.posf.xyz, l.rmd.x, l.rmd.z, l.posf.w, l.rmd.y
    );
}


fn mat(i: u32) -> Material {
    let m = material[i];

    return Material(
        m.irrs.y, m.irrs.z, m.irrs.w, m.albedo.xyz, m.scattering_color.xyz, m.dsei.x, m.dsei.y, m.dsei.z, m.dsei.w
    );
}

fn mat_2(h: vec3f) -> Material {

    let unpack = unpack_material_ids(h.y);
    let mat1 = mat(u32(unpack.x));
    let mat2 = mat(u32(unpack.y));
    return lerp_mat(mat1, mat2, h.z);
}

fn lerp_mat(a: Material, b: Material, k: f32) -> Material {

    return Material(
        mix(a.refraction, b.refraction, k),
        mix(a.roughness, b.roughness, k),
        mix(a.scat, b.scat, k),
        mix(a.a, b.a, k),
        mix(a.scatter_col, b.scatter_col, k),
        mix(a.dif, b.dif, k),
        mix(a.spec, b.spec, k),
        mix(a.emissive, b.emissive, k),
        mix(a.ior, b.ior, k)
    );
}

fn rbi(r: Ray, vmin: vec3f, vmax: vec3f) -> f32 {
    let t1 = (vmin.x - r.o.x) / r.d.x;
    let t2 = (vmax.x - r.o.x) / r.d.x;
    let t3 = (vmin.y - r.o.y) / r.d.y;
    let t4 = (vmax.y - r.o.y) / r.d.y;
    let t5 = (vmin.z - r.o.z) / r.d.z;
    let t6 = (vmax.z - r.o.z) / r.d.z;
    let t7 = max(max(min(t1, t2), min(t3, t4)), min(t5, t6));
    let t8 = min(min(max(t1, t2), max(t3, t4)), max(t5, t6));
    var t9: f32;
    if t8 < 0 || t7 > t8 { t9 = -1.0; } else { t9 = t7; }
    return t9;
}

fn shape(posi: vec3f) -> f32 {
    let pos = aar(posi, normalize(vec3f(0.2, 1.0, 0.0)), 0.5); // Vec3::NEG_Y -> VEC3_NEG_Y
    let po = aar(pos, normalize(vec3f(0.0, 0.0, 1.0)), radians(-90.0)); // 90.0_f32.to_radians() -> radians(-90.0)
    let pp = aar(pos, normalize(vec3f(1.0, 0.0, 0.0)), radians(-45.0)); // 45.0_f32.to_radians() -> radians(-45.0)
    let o = sd_rounded_cylinder(pp + vec3f(0.0, 0.0, -0.35), 0.3, 0.1, 0.1);
    let r = sd_rounded_cylinder(po + vec3f(-0.35, 0.0, 0.35), 0.3, 0.1, 0.1);
    let v = sd_rounded_cylinder(po + vec3f(-0.35, 0.0, 0.35), 0.15, 0.1, 0.4);
    let r_shape = op_smooth_subtraction(v, r, 0.1);

    return op_smooth_union(o, r_shape, 0.1);
}

fn op_smooth_subtraction(d1: f32, d2: f32, k: f32) -> f32 {
    let h = saturate(0.5 - 0.5 * (d2 + d1) / k);
    return mix(d2, -d1, h) + k * h * (1.0 - h);
}

fn op_smooth_union(d1: f32, d2: f32, k: f32) -> f32 {
    let h = saturate(0.5 + 0.5 * (d2 - d1) / k);
    return d2 + (d1 - d2) * h - k * h * (1.0 - h);
}

fn sd_round_box(p: vec3f, b: vec3f, r: f32) -> f32 {
    let q = abs(p) - b + r;
    return length(max(q, vec3f(0.0, 0.0, 0.0))) + min(0.0, max(q.x, max(q.y, q.z))) - r;
}

fn sd_rounded_cylinder(p: vec3f, ra: f32, rb: f32, h: f32) -> f32 {
    let d = vec2f(length(p.xz) - 2.0 * ra + rb, abs(p.y) - h);
    return (min(max_element(d), 0.0) + length(max(d, vec2f(0.0)))) - rb;
}

fn max_element(v: vec2f) -> f32 {
    return max(v.x, v.y);
}

// https://www.shadertoy.com/view/MXfXzM
fn smin(a: vec2f, b: vec2f, ki: f32) -> vec3f {
    let k = ki * 6.0;
    let h = max(k - abs(a.x - b.x), 0.0) / k;
    let m = h * h * h * 0.5;
    let s = m * k * (1.0 / 3.0);
    if a.x < b.x {
        return vec3f(a.x - s, pack_material_ids(a.y, b.y), m);
    }

    return vec3f(b.x - s, pack_material_ids(a.y, b.y), 1.0 - m);
}

fn pack_material_ids(id1: f32, id2: f32) -> f32 {
    let intId1 = u32(id1);
    let intId2 = u32(id2);
    let shiftedId1 = intId1 << 5;
    let packedInt = shiftedId1 | intId2;
    return bitcast<f32>(packedInt);
}

fn unpack_material_ids(packedFloat: f32) -> vec2<f32> {
    let packedInt = bitcast<u32>(packedFloat);
    let id2Int = packedInt & 31u; // 31u is 0b11111 in binary
    let id1Int = packedInt >> 5;
    return vec2<f32>(f32(id1Int), f32(id2Int));
}

fn light_map(r: Ray) -> Light {
    var l = light(u32(floor(rand_f() * f32(arrayLength(&light_in)))));
    l.d = length(r.o - l.p) - l.r;
    return l;
}

fn sd_box(p: vec3f, b: vec3f) -> f32 {
    let d = abs(p) - b;
    return min(max(d.x, max(d.y, d.z)), 0.0) + length(max(d, vec3f(0.0)));
}

// https://iquilezles.org/articles/smin
fn smax(a: f32, b: f32, k: f32) -> f32 {
    let h = max(k - abs(a - b), 0.);
    return max(a, b) + h * h * 0.25 / k;
}

fn sd_fbm(pin: vec3f, din: f32) -> vec2f {
    let m = mat3x3<f32>(0.00, 0.80, 0.60,
        -0.80, 0.36, -0.48,
        -0.60, -0.48, 0.64);
    var p = pin;
    var d = din;
    var t = 0.0;
    var s = 1.0;
    for (var i = 0u; i < 7; i++) {
        let n = s * simplex_33(p);
        d = smax(d, -n, 0.15 * s);
        t += d;
        p = 2.0 * m * p;
        s = 0.55 * s;
    }

    return vec2f(d, t);
}

fn sd_box_frame(pi: vec3f, b: vec3f, e: f32) -> f32 {
    let p = abs(pi) - b;
    let q = abs(p + e) - e;
    return min(min(
        length(max(vec3(p.x, q.y, q.z), vec3f(0.0))) + min(max(p.x, max(q.y, q.z)), 0.0),
        length(max(vec3(q.x, p.y, q.z), vec3f(0.0))) + min(max(q.x, max(p.y, q.z)), 0.0)
    ),
        length(max(vec3(q.x, q.y, p.z), vec3f(0.0))) + min(max(q.x, max(q.y, p.z)), 0.0));
}

fn sd_torus(p: vec3<f32>, t: vec2<f32>) -> f32 {
    var q: vec2<f32> = vec2<f32>(length(p.xz) - t.x, p.y);
    return length(q) - t.y;
}

fn op_onion(sdf: f32, thickness: f32) -> f32 {
    return abs(sdf) - thickness;
}
