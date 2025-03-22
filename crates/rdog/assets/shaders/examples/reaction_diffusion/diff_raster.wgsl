//* #import rng::{
//*     rng_state, rand_f, get_random_sample
//* }
//* #import scene::{
//*     sample_atmos, map, light_map, MIN_DIST, TMAX, mat_2, mat, rbi, DEFAULT_MAT, DANGER, pass_params
//* }
//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, ScatterRes, OCTree, OutputParams, Hit
//* }
//* #import ray::{
//*     pd, dir, mv
//* }
//* #import cam::{
//*     project_point3, calculate_coc, depth_aware_jitter
//* }
//* #import util::{
//*     EPSILON, ONE, ZERO, PI, translate_to_ws
//* }
//* #import light::{
//*     calc_attenuation, spherical_light_sample
//* }
//* #import scatter::scatter;
//* #import trace::{
//*    sample, trace_voxel_mask, calc_normal_vox, calc_normal
//* }

var<private> num_levels: u32;

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;

@group(1) @binding(0) var<storage, read> material: array<MaterialIn>;
@group(1) @binding(1) var<storage, read> light_in: array<LightIn>;

@group(2) @binding(0) var voxel: texture_3d<f32>;
@group(2) @binding(1) var voxel_sample: sampler;

@fragment
fn fs(@builtin(position) vertex: vec4f) -> @location(0) vec4f {
    var pos = vertex.xy;

    rng_state = u32(u32(pos.x) + (u32(pos.y) * u32(camera.screen.y))) * globals.seed.y;
    num_levels = u32(log2(f32(pass_params.voxel_dim))) + 1;

    let ss = vec2f(camera.screen.xy);

    var col = vec3f(0.0);

    for (var i: u32 = 0; i < pass_params.pass_count; i++) {
        var uv = ((pos + vec2f(0.5)) * 2.0) / ss - vec2f(1.0);
        uv.y *= -1.0;

        // no dof
        if camera.af.x == 0.0 {
            let position = 2.0 * vec2f(rand_f(), rand_f()) - 1.0;
            uv += position * 0.005;

            let fp = project_point3(camera.ndc_to_world, vec3f(uv, EPSILON));
            let np = project_point3(camera.ndc_to_world, vec3f(uv, 1.0));

            let r = Ray(np, normalize(fp - np));
            col += ray_trace(r);
        } else {
            let focal_dist = camera.fpd.w;
            let world_pos = camera.fpd.xyz;
            let coc = calculate_coc(world_pos, focal_dist, camera);

            let dof_jitter = depth_aware_jitter(abs(coc));
            uv += dof_jitter * (rand_f() * 2.0 - 1.0);

            let fp = project_point3(camera.ndc_to_world, vec3f(uv, EPSILON));
            let np = project_point3(camera.ndc_to_world, vec3f(uv, 1.0));

            let focal_point = np + normalize(fp - np) * focal_dist;
            let jittered_origin = np + vec3f(rand_f(), rand_f(), rand_f()) * camera.af.x;
            let r = Ray(jittered_origin, normalize(focal_point - jittered_origin));
            col += ray_trace(r);
        }
    }

    col /= f32(pass_params.pass_count);

    return vec4f(srgb_vec(pow(col, vec3f(2.2))), 1.0);
//    return vec4f(col, 1.0);
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

@vertex
fn vs(@builtin(vertex_index) vidx: u32) -> @builtin(position) vec4f {
    return full_screen_triangle(vidx);
}

fn full_screen_triangle(vert_idx: u32) -> vec4f {
    let uv = vec2(f32((vert_idx << 1) & 2), f32(vert_idx & 2));
    let pos = 2.0 * uv - vec2f(1.0);

    return vec4(pos, 0.0, 1.0);
}

fn ray_trace(ri: Ray) -> vec3f {
    var r = ri;

    var t = vec3f(0.0);
    var a = vec3f(1.0);

    var ct = 1.0;
    var rad = ONE;

    for (var i: u32 = 0; i < pass_params.bounce_count; i++) {
        var h = trace_voxel_mask(r);
        r.o = pd(r, h.d);

        if !h.h {
            t += sample_atmos(r) * a * rad + h.a;
            break;
        }

        if h.d >= TMAX {
            t += sample_atmos(r) * a * rad;
            break;
        }

        if h.m.emissive > 0.0 {
            t += h.m.emissive * h.m.a * a * rad;
            break;
        }

        if h.v {
            h.n = calc_normal_vox(r.o) * (2.0 * f32(!h.i) - 1.0);
        } else {
            h.n = calc_normal(r.o) * (2.0 * f32(!h.i) - 1.0);
        }

        let l = scatter(h, &r);

        ct = max(dot(h.n, l.dir), 0.0);
        a *= l.a * rad;

        let s = sample(h, r, l);
        t += a * s * rad;

        rad *= l.radiance;

        if !l.scatter {
            break;
        }

        r.d = l.dir;
    }

    return t;
}
