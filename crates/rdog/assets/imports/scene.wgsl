#define_import_path scene

#import types::{
    Ray,
}

fn sample_atmos(sr: Ray) -> vec3f {
    return vec3f(0.4, 0.35, 0.37) * 0.01;
}
