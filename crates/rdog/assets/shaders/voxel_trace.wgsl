//* #import rng::{
//*     rng_state, rand_f
//* }
//* #import scene::{
//*     sample_atmos, map, light_map, MIN_DIST, TMAX, mat_2, rbi, DEFAULT_MAT, DANGER
//* }
//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, Hit, ScatterRes, OCTree, OutputParams
//* }
//* #import ray::{
//*     pd, dir, mv
//* }
//* #import cam::{
//*     project_point3
//* }
//* #import util::{
//*     EPSILON, ONE, ZERO, PI
//* }

const TSTART: f32 = 0.01;
const RMAX: u32 = 600;

var<private> num_levels: u32;

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;
@group(0) @binding(3) var<storage, read> march: vec4f;
@group(0) @binding(4) var out: texture_storage_2d<rgba32float, read_write>;

@group(1) @binding(0) var<storage, read> material: array<MaterialIn>;
@group(1) @binding(1) var<storage, read> light_in: array<LightIn>;

@group(2) @binding(0) var voxel_depth: texture_storage_3d<rgba16float, read_write>;
@group(2) @binding(1) var voxel_data: texture_storage_3d<rgba16float, read_write>;

@compute @workgroup_size(1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
) {

    rng_state = u32(id.x + (id.y * u32(camera.screen.y))) * globals.seed.y;
    num_levels = u32(log2(f32(pass_params.voxel_dim))) + 1;

    var pos = vec2f(id.xy);

    let ss = vec2f(camera.screen.xy);

    var col = vec3f(0.0);

    for (var i: u32 = 0; i < pass_params.pass_count; i++) {
        var uv = ((pos + vec2f(0.5)) * 2.0) / ss - vec2f(1.0);
        uv.y *= -1.0;

        let focal_dist = camera.fpd.w;
        let world_pos = camera.fpd.xyz;
        let coc = calculate_coc(world_pos, focal_dist);

        let dof_jitter = depth_aware_jitter(abs(coc));
        uv += dof_jitter * (rand_f() * 2.0 - 1.0);

        let fp = project_point3(camera.ndc_to_world, vec3f(uv, EPSILON));
        let np = project_point3(camera.ndc_to_world, vec3f(uv, 1.0));

        let focal_point = np + normalize(fp - np) * focal_dist;
        let jittered_origin = np + vec3f(rand_f(), rand_f(), rand_f()) * camera.af.x;
        let r = Ray(jittered_origin, normalize(focal_point - jittered_origin));

        col += ray_trace(r);
    }

    col /= f32(pass_params.pass_count);

    combine(id.xy, col);
    // combine(id.xy, srgb_vec(pow(col, vec3f(2.2))));
}

fn calculate_coc(world_pos: vec3f, focal_dist: f32) -> f32 {
    // Calculate circle of confusion based on depth difference
    let depth = length(world_pos - camera.origin.xyz);
    return (depth - focal_dist) * camera.af.y * camera.af.x / focal_dist;
}

fn depth_aware_jitter(coc: f32) -> vec2f {
    // Poisson disk samples for quality jittering
    let poisson = array<vec2f, 12>(
        vec2f(-0.326, -0.406), vec2f(-0.840, -0.074),
        vec2f(-0.696, 0.457), vec2f(-0.203, 0.621),
        vec2f(0.962, -0.195), vec2f(0.519, 0.767),
        vec2f(0.507, -0.641), vec2f(0.185, -0.893),
        vec2f(0.896, 0.412), vec2f(-0.322, -0.933),
        vec2f(-0.792, -0.598), vec2f(0.291, 0.195)
    );

    // Select jitter sample based on RNG state
    let idx = u32(rand_f() * 12.0);
    return poisson[idx] * coc * 0.05;
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

fn combine(pos: vec2u, col: vec3f) {

    let multi_frame: bool = ((pass_params.flags >> 3) & 1) == 1;

    if !multi_frame {
        textureStore(out, pos, vec4f(col, 0.0));
        return;
    }

    let prv = textureLoad(out, pos);

    let a = prv.w + 1.0;

    let c = vec4f(mix(col, prv.xyz, 1.0 - (1.0 / a)), a);

    textureStore(out, pos, c);
}



















fn de(p_in: vec3f) -> f32 {
    var p: vec3f = p_in;
    var scale: f32 = 1.0;
    var orb: f32 = 10000.0;
    for (var i: i32 = 0; i < 7; i++) {
        p = -1.0 + 2.0 * fract(0.5 * p + 0.5);
        p -= sign(p) * 0.1;
        let a: f32 = f32(i) * acos(-1.0) / 4.0; // using acos instead of acos_approx
        let pt: vec2f = mat2x2(vec2f(cos(a), sin(a)), vec2f(-sin(a), cos(a))) * p.xz;
        p.x = pt.x;
        p.z = pt.y;

        let r2: f32 = dot(p, p);
        let k: f32 = 0.95 / r2;
        p *= k;
        scale *= k;
        orb = min(orb, r2);
    }

    let d1: f32 = sqrt(min(dot(p.xy, p.xy), min(dot(p.yz, p.yz), dot(p.zx, p.zx)))) - 0.02;
    let d2: f32 = abs(p.y);
    var dmi: f32 = d2;
    if d1 < d2 {
        dmi = d1;
    }
    return 0.5 * dmi / scale;
}

// fn scene_1(p: vec3f) -> vec2f {
//     let l = lights(p);
//
//     var posi = p + vec3f(1.0, 0.0, 0.0);
//
//     let pos = aar(posi, normalize(vec3f(0.05, 0.5, 0.1)), 1.0);
//     let s1 = sd_round_box(pos + vec3f(-1.0, -1.0, 1.0), vec3f(0.5, 0.5, 0.5), 0.1); // Vec3::splat(0.5) -> vec3f(0.5, 0.5, 0.5)
//     let s2 = shape(posi + vec3f(-0.5, -1.0, 0.0));
//     let s3 = length(posi + vec3f(-1.0, -1.0, -1.0)) - 0.4;
//
//     let p1 = dot(posi, vec3f(0.0, 1.0, 0.0)) + 0.0;
//
//     let p1_vec2 = vec2f(p1, 4.0); // vec2(p, 4.0) -> vec2f(p, 4.0)
//     let s1_vec2 = vec2f(s1, 3.0); // vec2(s1, 3.0) -> vec2f(s1, 3.0)
//     let s2_vec2 = vec2f(s2, 2.0); // vec2(s2, 2.0) -> vec2f(s2, 2.0)
//     let s3_vec2 = vec2f(s3, 5.0); // vec2(s3, 5.0) -> vec2f(s3, 5.0)
//
//     return sd_min(sd_min(sd_min(sd_min(s2_vec2, l), p1_vec2), s1_vec2), s3_vec2);
// }



fn calc_normal(pos: vec3f) -> vec3f {
    let ep = 0.0001;
    let e = vec2f(1.0, -1.0) * 0.5773;

    return normalize(
        0. + e.xyy * map(pos + ep * e.xyy).x + e.yyx * map(pos + ep * e.yyx).x + e.yxy * map(pos + ep * e.yxy).x + e.xxx * map(pos + ep * e.xxx).x
    );
}

fn id_to_vec3u_bitwise(idx: u32) -> vec3u {
    let x = idx & 3u;        // Extract least significant 2 bits (0b11 = 3)
    let y = (idx >> 2u) & 3u; // Shift right by 2, then extract least significant 2 bits
    let z = (idx >> 4u) & 3u; // Shift right by 4, then extract least significant 2 bits
    return vec3u(x, y, z);
}

// fn brute_octree_sample(p: vec3f) -> f32 {
//
//     var d = TMAX;
//     for (var i: u32 = 0; i < 64; i++) {
//
//         var b: u32 = 0;
//         if i < 32 {
//             b = extractBits(octrees[0].lower_mask, i, 1u);
//         } else {
//             b = extractBits(octrees[0].upper_mask, i - 32, 1u);
//         }
//
//         if b < 1 {
//             continue;
//         }
//
//         var id = id_to_vec3u_bitwise(i);
//
//         // let nd = sd_round_box(p, vec3f(2.0), 0.00);
//         let nd = length(p - vec3f(id)) - 0.3;
//
//         if d > nd {
//             d = nd;
//         }
//     }
//
//     return d;
// }

fn trace_voxel_mask(ri: Ray) -> vec4f {
    var r = ri;
    r.o.y += 1.0;

    let vd = f32(pass_params.voxel_dim);
    r.o = (r.o * vd + vd) / 2.0 - vec3f(0.0, vd / 2.0, 0.0);

    var map_pos = vec3i(floor(r.o));
    var total = vec4f(0.0);

    if !all(map_pos >= vec3i(0) && map_pos <= vec3i(pass_params.voxel_dim)) {
        let dist = rbi(r, vec3f(0.0), vec3f(pass_params.voxel_dim));
        if dist < 0.0 {
            return total;
        }
        r.o += r.d * (dist + 0.01);
        map_pos = vec3i(floor(r.o));
    }

    for (var i: u32 = 0; i < RMAX * 2; i++) {
        let d = get_voxel(map_pos);

        if d.w < MIN_DIST {
            return vec4f(d.xyz, 1.0);
        }

        r.o += r.d * (d.w * vd / 32.0);

        map_pos = vec3i(floor(r.o));

        if any(map_pos < vec3i(0) || map_pos >= vec3i(pass_params.voxel_dim)) {
            return vec4f(0.0);
        }
    }

    return vec4f(0.5, 0.0, 0.5, 1.0);
}

fn trace_voxel_mask_dda(ri: Ray) -> vec4f {
    var r = ri;
    let vd = f32(pass_params.voxel_dim);
    r.o = (r.o * vd + vd) / 2.0 - vec3f(0.0, vd / 2.0, 0.0);

    var map_pos = vec3i(floor(r.o));

    if !all(map_pos >= vec3i(0) && map_pos <= vec3i(pass_params.voxel_dim)) {
        let dist = rbi(r, vec3f(0.0), vec3f(pass_params.voxel_dim));
        if dist == -1.0 {
            return vec4f(0.0);
        }
        r.o += r.d * dist;
        map_pos = vec3i(floor(r.o));
    }

    let delta_dist = abs(vec3(length(r.d)) / r.d);
    let ray_step = vec3i(sign(r.d));
    var side_dist = (sign(r.d) * (vec3f(map_pos) - r.o) + (sign(r.d) * 0.5) + 0.5) * delta_dist;

    var mask = vec3<bool>(false);

    for (var i: u32 = 0; i < pass_params.voxel_dim * 3; i++) {
        let d = get_voxel(map_pos);
        if d.w < MIN_DIST {
            return vec4f(d.xyz, 1.0);
        }

        mask = less_than_equal(side_dist.xyz, min(side_dist.yzx, side_dist.zxy));
        side_dist += vec3f(mask) * delta_dist;
        map_pos += vec3i(vec3f(mask)) * ray_step;

        if i > 1 && any(map_pos < vec3i(0) || map_pos >= vec3i(pass_params.voxel_dim)) {
            return vec4f(0.0, 1.0, 0.5, 1.0);
        }
    }

    return vec4f(1.0, 0.0, 1.0, 1.0);
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

fn get_voxel(c: vec3i) -> vec4f {
    return textureLoad(voxel_depth, vec3u(c));
}

fn less_than_equal(a: vec3f, b: vec3f) -> vec3<bool> {
    return vec3<bool>(a.x <= b.x, a.y <= b.y, a.z <= b.z);
}

fn ray_trace(ri: Ray) -> vec3f {
    var r = ri;
    var t = vec3f(0.0);
    var a = vec3f(1.0);
    var ct = 1.0;
    var rad = ONE;

    for (var i: u32 = 0; i < pass_params.bounce_count; i++) {
        if true {
            var h = trace_voxel_mask(r);
            return h.xyz;
        }

        if true {
            var h = trace_voxel_mask_dda(r);
            return h.xyz;
        }

        var h = trace(r);
        r.o = pd(r, h.d);

        if true {
            h.n = calc_normal(r.o);
            return h.n;
        }

        if h.d >= TMAX {
            if i == 0 {
                t += sample_atmos(r) * a * rad * ct * 0.05;
                break;
            }

            t += sample_atmos(r) * a * rad;
            break;
        }

        if h.m.emissive > 0.0 {
            t += h.m.emissive * h.m.a * a * rad;
            break;
        }

        h.n = calc_normal(r.o) * (2.0 * f32(!h.i) - 1.0);

        let l = scatter(h, &r);

        if false {
            return l.dir;
        }

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
































































fn scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {

    let prob = calculate_probabilities(h);

    let rng = rand_f();

    if rng < prob.x {
        return diffuse_scatter(h, r);
    } else if rng < prob.x + prob.z {
        return specular_scatter(h, r);
    } else {
        return ScatterRes(vec3f(0.0, 1.0, 0.0), false, h.m.a, 0.0, ONE, false, false);
    }
}

fn diffuse_scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {
    let dir = translate_to_ws(get_random_sample(), h.n);
    return ScatterRes(dir, true, h.m.a, 0.0, ONE, false, false);
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


fn specular_scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {
    var eta: f32;
    if !(h.i) {
        eta = 1.0 / h.m.ior;
    } else {
        eta = h.m.ior / 1.0;
    }

    var n = h.n;
    let ud = normalize((*r).d);
    let v_ud = -ud;

    var u: vec3f;
    if dot(n, ud) == 1.0 {
        // If ray direction is aligned with normal, use fallback vector for u
        u = normalize(cross(n, vec3f(0.0, 1.0, 0.0)));
    } else {
        u = normalize(cross(n, ud));
    }
    let v = normalize(cross(u, n));

    // Perturb the normal based on roughness using RNG
    let a: f32 = (rand_f() - 0.5) * h.m.roughness * 2.0;
    let b: f32 = (rand_f() - 0.5) * h.m.roughness * 2.0;

    n += u * a + v * b;
    n = normalize(n);

    let cos_theta = clamp(dot(v_ud, n), -1.0, 1.0);

    let r0 = (1.0 - eta) / (1.0 + eta);
    let fresnel = pow(r0, 2.0) + (1.0 - r0) * pow(1.0 - cos_theta, 5.0);

    var dir: vec3f;
    let reflect = rand_f() > h.m.refraction;
    if reflect {
        dir = reflect(ud, n);
    } else {
        (*r).o = ((*r).o + (h.n * (MIN_DIST * 4.0) * -1.0));
        dir = refract(ud, n, eta);
    }

    var radiance = ONE;
    if reflect {
        radiance = vec3f(saturate(1.0 - fresnel));
    } else {
        radiance = vec3f(saturate(1.0 - fresnel));
    }

    let albedo = h.m.a; // todo may want to apply tint to reflections in future.

    return ScatterRes(dir, true, albedo, fresnel, radiance, !reflect, reflect);
}


























fn calculate_probabilities(h: Hit) -> vec3f {
    let diffuse_weight = h.m.dif / 10.0;
    let specular_weight = h.m.spec / 10.0;
    let scatter_weight = h.m.scat / 10.0;

    let sum_weights = diffuse_weight + specular_weight + scatter_weight;

    let diffuse_prob = diffuse_weight / sum_weights;
    let scatter_prob = scatter_weight / sum_weights;
    let specular_prob = specular_weight / sum_weights;

    return vec3f(diffuse_prob, scatter_prob, specular_prob);
}

fn sample(h: Hit, ri: Ray, l: ScatterRes) -> vec3f {
    let prob = calculate_probabilities(h);
    let rng = rand_f();

    var r = ri;
    r.o = r.o + (h.n * 0.005);

    if rng < prob.x {
        return (1.0 - l.fresnel) * (h.m.dif * h.m.a * sample_direct(r, h.n));
    }

    if rng < prob.x + prob.y {
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
    let h = trace(r);

    r.o = p1 + (l * h.d) + (0.03 * l);

    let h1 = trace(r);

    if h1.d < TMAX {
        if h1.m.emissive > 0.0 {
            let scale = 3.0;
            let bias = 0.01;

            let n1 = -h1.n;
            let cos_theta = dot(n1, l);
            let s = scale * (h.d + bias);

            let e = max(0.3 + cos_theta, .0);

            let a = calc_attenuation(r, cl);

            out += t(s) * e * a * (h1.m.a * h1.m.emissive * a);
        }
    }

    return out;
}

fn t(s: f32) -> vec3f {
    return vec3f(0.233, 0.455, 0.649) * exp(-s * s / 0.0064) + vec3f(0.1, 0.336, 0.344) * exp(-s * s / 0.0484) + vec3f(0.118, 0.198, 0.0) * exp(-s * s / 0.187) + vec3f(0.113, 0.007, 0.007) * exp(-s * s / 0.567) + vec3f(0.358, 0.004, 0.0) * exp(-s * s / 1.99) + vec3f(0.078, 0.0, 0.0) * exp(-s * s / 7.41);
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

    let h = trace(r);

    if h.d >= TMAX {
        return vec3f(0.0);
    }

    if h.m.emissive > 0.0 {
        let a = calc_attenuation(r, cl);
        return (h.m.a * cos_theta * h.m.emissive) * a;
    }

    return vec3f(0.0);
}

fn calc_attenuation(r: Ray, cl: Light) -> f32 {
    let atten = max((1.0 - length(cl.p - r.o) / cl.falloff), 0.0);
    return pow(atten, 1.0);
}

fn spherical_light_sample(cl: Light, r: Ray) -> vec3f {
    let u0 = rand_f();
    let u1 = rand_f();

    let d = distance(cl.p, r.o);
    let lv = (cl.p - r.o) / d;

    let sin_theta_max_sq = (cl.r * cl.r) / (d * d);
    let cos_theta_max = max(0.0, sqrt(1.0 - sin_theta_max_sq));

    let cos_theta = (u0 * cos_theta_max) + (1.0 - u0);
    let sin_theta = max(0.0, sqrt(1.0 - (cos_theta * cos_theta)));
    let phi = u1 * 2.0 * PI;

    let sample_direction = vec3f(cos(phi) * sin_theta, cos_theta, sin(phi) * sin_theta);

    return translate_to_ws(sample_direction, lv);
}

fn translate_to_ws(d: vec3f, n: vec3f) -> vec3f {
    var r = ZERO;
    if abs(n.x) > abs(n.y) {
        r = vec3f(n.z, 0.0, -n.x) / sqrt((n.x * n.x) + (n.z * n.z));
    } else {
        r = vec3f(0.0, -n.z, n.y) / sqrt((n.y * n.y) + (n.z * n.z));
    };

    let f = cross(n, r);

    return vec3f(
        (d.x * f.x) + (d.y * n.x) + (d.z * r.x),
        (d.x * f.y) + (d.y * n.y) + (d.z * r.y),
        (d.x * f.z) + (d.y * n.z) + (d.z * r.z),
    );
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

        let h = trace(r);

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






























































































// fn signBit(x: f32) -> bool { return (bitcast<i32>(x) & i32(-2147483648)) != 0i; }
// fn signBit_vec3(v: vec3<f32>) -> vec3<bool> { return vec3<bool>(signBit(v.x), signBit(v.y), signBit(v.z)); }
// fn min3(v: vec3<f32>) -> f32 { return min(min(v.x, v.y), v.z); }
// fn max3(v: vec3<f32>) -> f32 { return max(max(v.x, v.y), v.z); }
//
// fn mip(pos: vec3<i32>, level: i32) -> bool {
//     if u32(level) >= num_levels { return true; }
//
//     var p = (pos * i32(pass_params.voxel_dim) + 1i) << vec3(u32(level));
//     let bounds = 1i << num_levels - u32(level);
//
//     if any(pos < vec3i(0)) || any(pos >= vec3i(bounds)) {
//         return false;
//     }
//
//     if u32(level) == 1 {
//         let po = vec3u(pos);
//         let id = po.x + po.y * pass_params.voxel_dim + po.z * pass_params.voxel_dim * pass_params.voxel_dim;
//         return octrees[id].upper_mask > 1 || octrees[id].lower_mask > 1;
//     }
//
//     return true;
// }
//
// fn bmix(a: vec3<bool>, b: vec3<bool>, s: vec3<bool>) -> vec3<bool> {
//     return vec3(select(a.x, b.x, s.x), select(a.y, b.y, s.y), select(a.z, b.z, s.z));
// }
//
// fn trace_mask(ri: Ray, s: ptr<function, i32>) -> vec4<i32> {
//     var r = ri;
//     r.o += f32(2u << num_levels) / 4.0;
//
//     let idir = vec3(1.0) / r.d;
//     let sgn = signBit_vec3(r.d);
//     let stp = vec3(1i) - (select(vec3(0i), vec3(1i), sgn) * 2i);
//     var level = i32(num_levels - 1);
//     var bnd = vec3<i32>(r.o) >> vec3(u32(level));
//     var previdx = 0i;
//
//     for (var iter = 0i; iter < 1000i; iter++) {
//         *s = iter;
//
//         if any(bmix(bnd >= vec3((1i << num_levels) >> u32(level)), bnd < (vec3(0i) << vec3(u32(level))), sgn)) {
//             return vec4(-1i);
//         }
//
//         if mip(bnd, level) {
//             let dists = (vec3<f32>((bnd + select(vec3(0i), vec3(1i), sgn)) << vec3(u32(level))) - r.o) * idir;
//             level--;
//             let dist = max(dists[previdx], 0.0);
//             if level == 0i {
//
//                 let id = u32(bnd.x) + u32(bnd.y) * pass_params.voxel_dim + u32(bnd.z) * pass_params.voxel_dim * pass_params.voxel_dim;
//
//                 // return vec4(bnd.x, bnd.y, bnd.z, previdx + (select(0i, 1i, sgn[previdx]) * 3i));
//                 let vm = trace_voxel_mask(Ray((((r.o + r.d * dist) - vec3f(bnd.xyz * 2)) * 2.0), r.d), u32(id));
//                 if any(vm) {
//                     return vec4(bnd.x, bnd.y, bnd.z, previdx + (select(0i, 1i, sgn[previdx]) * 3i));
//                     // return vec4(vec3i(vm), previdx + (select(0i, 1i, sgn[previdx]) * 3i));
//                 } else {
//                     level ++;
//                 }
//             } else {
//                 bnd = clamp(vec3<i32>(r.o + r.d * dist) >> vec3(u32(level)), bnd << vec3(1u), (bnd << vec3(1u)) + vec3(1i));
//                 continue;
//             }
//         }
//
//         if !mip(bnd >> vec3(1u), level + 1i) {
//             level++;
//             bnd >>= vec3(1u);
//         }
//
//         let dists = (vec3<f32>((bnd + select(vec3(0i), vec3(1i), !sgn)) << vec3(u32(level))) - r.o) * idir;
//         let min_dist = min3(dists);
//         let idx = select(select(2i, 1i, dists.y == min_dist), 0i, dists.x == min_dist);
//         bnd[idx] += stp[idx];
//         previdx = idx;
//     }
//     return vec4(-1i);
// }
//
// fn trace_voxel_mask(ri: Ray, octee_idx: u32) -> vec3<bool> {
//     var r = ri;
//     r.o -= r.d * 0.00001;
//
//     var map_pos = vec3i(floor(r.o));
//
//     let delta_dist = abs(vec3(length(r.d)) / r.d);
//     let ray_step = vec3i(sign(r.d));
//     var side_dist = (sign(r.d) * (vec3f(map_pos) - r.o) + (sign(r.d) * 0.5) + 0.5) * delta_dist;
//
//     var mask = vec3<bool>(false); // calculate normal here
//
//     for (var i: u32 = 0; i < RMAX; i++) {
//         if any(map_pos < vec3i(-1) || map_pos > vec3i(4)) {
//             return vec3<bool>(false);
//         }
//
//         if get_voxel(map_pos, octee_idx) {
//             if any(mask) {
//                 return mask;
//             } else {
//                 return less_than_equal(side_dist.xyz, min(side_dist.yzx, side_dist.zxy));
//             }
//         }
//
//         mask = less_than_equal(side_dist.xyz, min(side_dist.yzx, side_dist.zxy));
//         side_dist += vec3f(mask) * delta_dist;
//         map_pos += vec3i(vec3f(mask)) * ray_step;
//     }
//
//     return vec3<bool>(false);
// }
