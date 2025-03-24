#define_import_path light
//* #import rng::{
//*     rand_f
//* }
//* #import types::{
//*     Ray, Light
//* }
//* #import util::{
//*    PI, translate_to_ws
//* }

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
