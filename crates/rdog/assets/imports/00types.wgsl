#define_import_path types

struct Ray {
    o: vec3f,
    d: vec3f,
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

struct PassParams {
    sun_x: f32,
    sun_y: f32,
    pass_count: u32,
    bounce_count: u32,
    flags: u32,
    voxel_dim: u32,
    voexl_debug: u32,
}

struct Globals {
    time: vec2f,
    seed: vec2u,
    mouse: vec2f,
    true_res: vec2u,
}

struct Camera {
    projection_view: mat4x4f,
    ndc_to_world: mat4x4f,
    origin: vec4f,
    screen: vec4f,
    fpd: vec4f,
    af: vec4f,
}

struct Hit {
    d: f32,
    n: vec3f,
    i: bool,
    m: Material,
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

struct OutputParams {
    workgroup_offset: vec2u,
    tile_size: vec2u,
}
