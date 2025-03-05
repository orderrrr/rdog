
const TSTART: f32 = 0.01;
const RMAX: u32 = 600;
const TMAX: f32 = 80.0;
const MIN_DIST: f32 = 0.001;
const PI: f32 = 3.14159265358979323846264338327950288;
const EPSILON: f32 = 1.19209290e-07f;

const ONE = vec3f(1.0);
const DANGER = vec3f(1.0, 0.0, 1.0);
const ZERO = vec3f(0.0);

const DEFAULT_MAT: Material = Material(0.0, 0.0, 0.0, DANGER, DANGER, 0.0, 0.0, 0.0, 0.0);

var<private> rng_state: u32; // Global or per-invocation state for RNG
var<private> num_levels: u32; // Global or per-invocation state for RNG

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
    mouse: vec2f,
}

struct Camera {
    projection_view: mat4x4f,
    ndc_to_world: mat4x4f,
    origin: vec4f,
    screen: vec4f,
    fpd: vec4f,
    ftd: vec4f,
}

struct Ray {
    o: vec3f,
    d: vec3f,
}

struct Hit {
    d: f32,
    n: vec3f,
    i: bool,
    m: Material,
}

struct MaterialIn {
    irrs: vec4f,
    albedo: vec4f,
    scattering_color: vec4f,
    dsei: vec4f,
}

struct Material {
    refraction: f32,
    roughness: f32,
    scat: f32,
    a: vec3f,
    scatter_col: vec3f,
    dif: f32,
    spec: f32,
    emissive: f32,
    ior: f32,
}

struct LightIn {
    posf: vec4f,
    rmd: vec4f,
}

struct Light {
    p: vec3f,
    r: f32,
    d: f32,
    falloff: f32,
    mi: f32,
}

struct ScatterRes {
    dir: vec3f,
    scatter: bool,
    a: vec3f,
    fresnel: f32,
    radiance: vec3f,
    refract: bool,
    reflect: bool,
}

struct OCTree {
    upper_mask: u32,
    lower_mask: u32,
}

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<storage, read> material: array<MaterialIn>;
@group(0) @binding(3) var<storage, read> light_in: array<LightIn>;
@group(0) @binding(4) var<uniform> pass_params: PassParams;
@group(0) @binding(5) var<storage, read_write> out: vec4f;

@compute @workgroup_size(1)
fn read_mouse(
    @builtin(global_invocation_id) id: vec3u,
) {
    let pos = floor(globals.mouse);

    let ss = vec2f(camera.screen.xy);

    var uv = ((pos + vec2f(0.5)) * 2.0) / ss - vec2f(1.0);
    uv.y *= -1.0;

    let fp = project_point3(camera.ndc_to_world, vec3f(uv, EPSILON));
    let np = project_point3(camera.ndc_to_world, vec3f(uv, 1.0));

    let r = Ray(np, normalize(fp - np));

    let hit = trace(r);

    let di = pd(r, hit.d);

    out = vec4f(di, hit.d);
}

fn trace(r: Ray) -> Hit {
    var t = 0.01;

    for (var i: u32 = 0; i < RMAX; i++) {
        let p = pd(r, t);
        var h = map(p);
        let interior = h.x <= 0.0;
        h.x = abs(h.x);

        if h.x < MIN_DIST {
            return Hit(t, vec3f(0.0), interior, mat_2(h));
        }

        if t > TMAX {
            break;
        }

        t += h.x;
    }

    return Hit(TMAX, vec3f(0.0), false, DEFAULT_MAT);
}

fn map(p: vec3f) -> vec3f {
    let l = lights(p);
    let s = vec3f(sd_round_box(p - vec3f(0.0, 1.0, 1.0), vec3f(1.0), 0.1), pack_material_ids(2.0, 2.0), .0);
    return sd_min3(s, l);
}

fn lights(p: vec3f) -> vec3f {
    var d = vec3f(TMAX, 0.0, 0.0);
    for (var i: u32 = 0; i < arrayLength(&light_in); i++) {
        let l = light(i);
        d = sd_min3(d, vec3f(length(p - l.p) - l.r, pack_material_ids(l.mi, l.mi), 0.0));
    }

    return d;
}

fn pd(r: Ray, t: f32) -> vec3f {
    return (r.d * t) + r.o;
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

fn sd_min3(d1: vec3f, d2: vec3f) -> vec3f {
    if d1.x < d2.x {
        return d1;
    }

    return d2;
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

fn sd_round_box(p: vec3f, b: vec3f, r: f32) -> f32 {
    let q = abs(p) - b + r;
    return length(max(q, vec3f(0.0, 0.0, 0.0))) + min(0.0, max(q.x, max(q.y, q.z))) - r;
}

fn project_point3(transform: mat4x4f, rhs: vec3f) -> vec3f {
    var res: vec4f = transform[0] * rhs.x;
    res = (transform[1] * rhs.y) + res;
    res = (transform[2] * rhs.z) + res;
    res = transform[3] + res;
    res = res / res.w;
    return res.xyz;
}
