
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
    mouse_x: f32,
    mouse_y: f32,
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
    out = vec4f(1.0);
}

