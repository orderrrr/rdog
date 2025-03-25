#define_import_path scatter
//* #import scene::{
//*     sample_atmos, map, light_map, MIN_DIST, TMAX, mat_2, mat, rbi, DEFAULT_MAT, DANGER
//* }
//* #import light::{
//*     calc_attenuation, spherical_light_sample
//* }
//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, ScatterRes, OCTree, OutputParams, Hit
//* }
//* #import rng::{
//*     rng_state, rand_f, get_random_sample
//* }
//* #import util::{
//*     EPSILON, ONE, ZERO, PI, translate_to_ws
//* }

fn scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {

    let prob = calculate_probabilities(h);

    let rng = rand_f();

    if rng < prob.x {
        return diffuse_scatter(h, r);
    }

    if rng < prob.x + prob.y {
        return subsurface_scatter(h, r);
    }

    if rng < prob.x + prob.y + prob.z {
        return specular_scatter(h, r);
    }

    return ScatterRes(ZERO, false, h.m.a, 0.0, ONE, false, false, -1.0);
}

fn subsurface_scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {
    let cl = light_map(*r);

    if cl.d > cl.falloff {
        return ScatterRes(ZERO, false, h.m.a, 0.0, ONE, false, false, -1.0);
    }

    (*r).o -= (h.n * 0.02);

    let ls = spherical_light_sample(cl, *r);

    return ScatterRes(ls, true, h.m.a, 0.0, ONE, false, false, 3.0);
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

fn diffuse_scatter(h: Hit, r: ptr<function, Ray>) -> ScatterRes {
    let dir = translate_to_ws(get_random_sample(), h.n);
    return ScatterRes(dir, true, h.m.a, 0.0, ONE, false, false, 1.0);
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

    return ScatterRes(dir, true, albedo, fresnel, radiance, !reflect, reflect, 2.0);
}
