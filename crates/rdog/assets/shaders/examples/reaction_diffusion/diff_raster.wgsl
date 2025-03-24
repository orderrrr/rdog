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
//* #import scatter::calculate_probabilities;

const TSTART: f32 = 0.01;
const RMAX: u32 = 600;

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

        if !h.h && i == 0 {
            break;
        }

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












fn trace_voxel_mask(ri: Ray) -> Hit {
    var r = ri;

    let vd = f32(pass_params.voxel_dim);

    var map_pos = vec3i(floor(r.o));

    let full_step = dot(abs(r.d), vec3f(1.0 / vd));
    let min_step = dot(abs(r.d), vec3f(.5 / vd));

    var total = vec4f(0.0);

    var t = 0.0;

    let dist = rbi(r, vec3f(-1.0), vec3f(1.0));
    if dist == -1.0 {
        return Hit(TMAX, DANGER, DANGER, false, mat(u32(1)), false, false);
    }

    let mv = (max(dist, 0.0) + 0.01);
    t += mv;

    r.o += r.d * mv;

    var pd = 0.0;
    var cdt = TMAX;

    // Ray marching loop
    for (var i: u32 = 0; i < pass_params.voxel_dim * 4; i++) {
        let d = get_voxel(r.o);

        if cdt >= pd / 2.0 {
            var h = map(r.o);

            let interior = h.x <= 0.0;
            h.x = abs(h.x);
            pd = h.x;

            if h.x <= MIN_DIST {
                return Hit(t, DANGER, ONE, interior, mat_2(h), true, false);
            }

            cdt = 0.0;
        }

        if d.z >= 0.0001 {
            let c1 = vec3f(-1.9, -1.0, 1.5);
            let c2 = vec3f(1.4, -1.2, -2.4);
            let color = vec3f(0.05) + d.x * (vec3f(1.0) - c1) + d.y * (c1 - c2);

            total += vec4f(color * d.z * 1.0, d.z);

            // total += vec4f(sample_light(r, r.d), d.z);

//            return Hit(t, DANGER, 1. / sample_light(r, r.d), false, mat(u32(1)), false, true);


            if d.z > (rand_f() * 2.0 - 1.0) * 0.01 + .025 {
                return Hit(t, DANGER, total.xyz, true, mat(u32(1)), true, true);
            }
        }

        // we only want to lower res when we get close to dense areas
        let density_factor = smoothstep(0.0, 1.0, d.z / .025);
        let current_step_size = mix(full_step, min_step, density_factor);
        let mv = min(current_step_size, pd);
        cdt += mv;
        t += mv;

        r.o += r.d * mv;

        // here we leave the voxel but didn't actually hit anything...
        if any(r.o < vec3f(-1.0) || r.o > vec3f(1.0)) {
//            if all(total.xyz <= vec3f(1.0)) {
//                break;
//            }

            return Hit(t, ZERO, total.xyz, false, mat(u32(1)), false, true);
        }
    }

    return Hit(TMAX, DANGER, DANGER, false, mat(u32(1)), false, false);
}

fn trace_voxel_mask_only(ri: Ray) -> Hit {
    var r = ri;

    let vd = f32(pass_params.voxel_dim);

    var map_pos = vec3i(floor(r.o));

    let full_step = dot(abs(r.d), vec3f(4.0 / vd));
    let min_step = dot(abs(r.d), vec3f(3.0 / vd));

    var total = vec4f(0.0);

    var t = 0.0;

    if any(r.o < vec3f(-1.0) || r.o > vec3f(1.0)) {
        let dist = rbi(r, vec3f(-1.0), vec3f(1.0));
        if dist < 0.0 {
            return Hit(TMAX, DANGER, DANGER, false, mat(u32(1)), false, false);
        }

        let mv = (dist + 0.01);
        t += mv;

        r.o += r.d * mv;
    }

    var pd = 0.0;
    var cdt = TMAX;

    // Ray marching loop
    for (var i: u32 = 0; i < pass_params.voxel_dim; i++) {
        let d = get_voxel(r.o);

        if cdt >= pd / 2.0 {
            var h = map(r.o);

            let interior = h.x <= 0.0;
            h.x = abs(h.x);
            pd = h.x;

            if h.x <= MIN_DIST {
                return Hit(t, DANGER, ONE, interior, mat_2(h), true, false);
            }

            cdt = 0.0;
        }

        if d.z >= 0.0001 {
            let c1 = vec3f(-1.9, -1.0, 1.5);
            let c2 = vec3f(1.4, -1.2, -2.4);
            let color = vec3f(0.05) + d.x * (vec3f(1.0) - c1) + d.y * (c1 - c2);

            total += vec4f(color * d.z * 1.0, d.z);

//            if d.z > (rand_f() * 2.0 - 1.0) * 0.01 + .025 {
//               return Hit(t, DANGER, total.xyz, false, mat(u32(1)), true, true);
//            }
        }

        // we only want to lower res when we get close to dense areas
        let density_factor = smoothstep(0.0, 1.0, d.z / .025);
        let current_step_size = mix(full_step, min_step, density_factor);
        let mv = min(current_step_size, pd);
        cdt += mv;
        t += mv;

        r.o += r.d * mv;

        // here we leave the voxel but didn't actually hit anything...
        if any(r.o < vec3f(-1.0) || r.o > vec3f(1.0)) {
//            if all(total.xyz <= vec3f(1.0)) {
//                break;
//            }

            return Hit(t, ZERO, total.xyz, false, mat(u32(1)), false, true);
        }
    }

    return Hit(TMAX, DANGER, DANGER, false, mat(u32(1)), false, false);
}

fn sample(h: Hit, ri: Ray, l: ScatterRes) -> vec3f {
    let prob = calculate_probabilities(h);
    let rng = rand_f();

    var r = ri;
    r.o = r.o + (h.n * 0.005);

    if rng < prob.x {
        return (1.0 - l.fresnel) * (h.m.dif * h.m.a * sample_direct(r, h.n));
    }

    if rng < prob.x + prob.y || true {
        return (1.0 - l.fresnel) * (h.m.scat * h.m.scatter_col * sample_scattering(r, h.n));
    }

    return h.m.spec * sample_specular(h, r, l);
}

fn sample_scattering(ri: Ray, n: vec3f) -> vec3f {
    var out = ZERO;

    var r = ri;
    let p1 = r.o - (n * 0.02);

    let cl = light_map(r);

    if cl.d > cl.falloff {
        return out;
    }

    r.o = p1;
    let l = spherical_light_sample(cl, r);
    r.d = l;

    let h = trace_voxel_mask(r);

    r.o = p1 + (l * h.d) + (0.03 * l);

    let h1 = trace_voxel_mask(r);

    if h1.d < TMAX {
        if h1.m.emissive > 0.0 {
            let scale = 3.0;
            let bias = 0.01;

            let n1 = -h1.n;
            let cos_theta = dot(n1, r.d);
            let s = scale * (h.d + bias);

            let e = max(0.3 + cos_theta, .0);

            let a = calc_attenuation(r, cl);

            out += t(s) * e * a * (h1.m.a * h1.m.emissive * a);
        }
    }

    return out;
}

fn sample_light(ri: Ray, n: vec3f) -> vec3f {
    var r = ri;

    var out = ZERO;

    let cl = light_map(r);

    if cl.d > cl.falloff {
        return out;
    }

    let l = spherical_light_sample(cl, r);

    r.d = l;

    let h1 = trace_voxel_mask_only(r);

    if h1.d < TMAX {
        if h1.m.emissive > 0.0 {
            let scale = 3.0;
            let bias = 0.01;

            let n1 = -n;
            let cos_theta = dot(n1, l);
            let s = scale * (h1.d + bias);

            let e = max(0.3 + cos_theta, .0);

            let a = calc_attenuation(r, cl);

            out += (t(s) * h1.a * 0.1 * vec3f(1.0, 1.0, 1.0)) * e * a * (h1.m.a * h1.m.emissive * a);
        }
    }

    return out;
}

fn t(s: f32) -> vec3f {
    return
        vec3f(0.233, 0.455, 0.649) * exp(-s * s / 0.0064) + vec3f(0.100, 0.336, 0.344) * exp(-s * s / 0.0484) + vec3f(0.118, 0.198, 0.000) * exp(-s * s / 0.187) + vec3f(0.113, 0.007, 0.007) * exp(-s * s / 0.567) + vec3f(0.358, 0.004, 0.000) * exp(-s * s / 1.99) + vec3f(0.078, 0.000, 0.000) * exp(-s * s / 7.41);
}

fn sample_direct(ri: Ray, n: vec3f) -> vec3f {
    var r = ri;

    let cl = light_map(r);

    if cl.d > cl.falloff {
        return vec3f(0.0);
    }

    let l = spherical_light_sample(cl, r);

    let cos_theta = dot(n, l);
    if cos_theta < 0.0 {
        return vec3f(0.0);
    }

    r = dir(r, l);

    let h = trace_voxel_mask(r);

    if h.d >= TMAX {
        return vec3f(0.0);
    }

    if h.m.emissive > 0.0 {
        let a = calc_attenuation(r, cl);
        return (h.m.a * cos_theta * h.m.emissive) * a;
    }

    return vec3f(0.0);
}

fn calc_normal_vox(p: vec3f) -> vec3f {
    let ep = 1.0 / f32(pass_params.voxel_dim);
    return normalize(vec3(
        get_voxel(p - vec3(ep, 0.0, 0.0)).z - get_voxel(p + vec3(ep, 0.0, 0.0)).z,
        get_voxel(p - vec3(0.0, ep, 0.0)).z - get_voxel(p + vec3(0.0, ep, 0.0)).z,
        get_voxel(p - vec3(0.0, 0.0, ep)).z - get_voxel(p + vec3(0.0, 0.0, ep)).z
    ));
}

fn calc_normal(pos: vec3f) -> vec3f {
    let ep = 0.0001;
    let e = vec2f(1.0, -1.0) * 0.5773;

    return normalize(
        0. + e.xyy * map(pos + ep * e.xyy).x + e.yyx * map(pos + ep * e.yyx).x + e.yxy * map(pos + ep * e.yxy).x + e.xxx * map(pos + ep * e.xxx).x
    );
}

fn compute_voxel_visibility(chemical_b_concentration: f32) -> vec2f {
    // Hardcoded constants from the UI defaults
    let exponent: f32 = 3.3;
    let alpha_global: f32 = 1.0;
    let alpha_threshold: f32 = 0.0001;

    // Compute the alpha value
    let alpha = pow(chemical_b_concentration, exponent) * alpha_global;

    // Determine if the voxel is visible
    let visible = alpha >= alpha_threshold;

    return vec2f(f32(visible), alpha);
}

fn get_voxel(c: vec3f) -> vec4f {
    return textureSample(voxel, voxel_sample, (c + 1.0) / 2.0 - vec3f(0.0, 0.0, 0.0));
}

fn less_than_equal(a: vec3f, b: vec3f) -> vec3<bool> {
    return vec3<bool>(a.x <= b.x, a.y <= b.y, a.z <= b.z);
}

fn sample_specular(h: Hit, ri: Ray, l: ScatterRes) -> vec3f {
    var r = ri;
    let cl = light_map(r);

    if cl.d > cl.falloff {
        return ZERO;
    }

    let ls = spherical_light_sample(cl, r);
    let v = -r.d;
    let n = h.n;
    let n_dot_v = max(dot(n, v), 0.0);
    let alpha = pow(h.m.roughness, 2.0);
    let alpha2 = pow(alpha, 2.0);
    let hv = (v + ls) / length(v + ls);
    let n_dot_l = dot(n, ls);
    let n_dot_h = max(dot(n, hv), 0.0);

    if n_dot_l > 0.0 {
        r.o = r.o + (ls * 0.02);
        r.d = ls;

        let h = trace_voxel_mask(r);

        let k_direct = (alpha2 + 1.0) / 8.0;

        if h.m.emissive > 0.0 {
            let a = calc_attenuation(r, cl);
            let in_radiance = h.m.a * a;
            let d_term = d_term_ggxtr(n_dot_h, alpha);
            let g_term = g_term_schlick_ggx(n_dot_v, n_dot_l, k_direct);
            return in_radiance * g_term * l.fresnel * d_term / (4.0 / n_dot_v) * (a * h.m.emissive);
        }
    }

    return ZERO;
}

fn d_term_ggxtr(n_dot_h: f32, alpha: f32) -> f32 {
    let alpha_val = n_dot_h * alpha;
    let kappa = alpha_val / (n_dot_h * n_dot_h * (alpha * alpha - 1.0) + 1.0);
    return kappa * kappa / PI;
}

fn g_term_schlick_ggx(n_dot_v: f32, n_dot_l: f32, k: f32) -> f32 {
    let g_term_v = n_dot_v / (n_dot_v * (1.0 - k) + k);
    let g_term_l = n_dot_l / (n_dot_l * (1.0 - k) + k);
    return g_term_v * g_term_l;
}

