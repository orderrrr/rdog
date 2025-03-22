//* #import rng::{
//*     rng_state, rand_f
//* }
//* #import scene::{
//*     sample_atmos, map, light_map, MIN_DIST, TMAX, mat_2, rbi, DEFAULT_MAT, DANGER
//* }
//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, Hit, ScatterRes, OCTree
//* }
//* #import ray::{
//*     pd, dir
//* }
//* #import cam::{
//*     project_point3
//* }
//* #import util::{
//*     EPSILON, ONE, ZERO, PI
//* }

const RMAX: u32 = 600;
var<private> num_levels: u32;

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;
@group(0) @binding(3) var<storage, read_write> out: vec4f;

@group(1) @binding(0) var<storage, read> material: array<MaterialIn>;
@group(1) @binding(1) var<storage, read> light_in: array<LightIn>;

@compute @workgroup_size(1)
fn read_mouse(
    @builtin(global_invocation_id) id: vec3u,
) {
    rng_state = u32(id.x + (id.y * u32(camera.screen.y))) * globals.seed.y;
    num_levels = u32(log2(f32(pass_params.voxel_dim))) + 1;

    let pos = floor(globals.mouse * camera.screen.xy);

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
            return Hit(t, ZERO, ZERO, interior, mat_2(h), true ,false);
        }

        if t > TMAX {
            break;
        }

        t += h.x;
    }

    return Hit(TMAX, ZERO, ZERO, false, DEFAULT_MAT, false, false);
}
