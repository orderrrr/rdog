#define_import_path ray

//* #import types::{
//*     Ray
//* }

fn pd(r: Ray, t: f32) -> vec3f {
    return (r.d * t) + r.o;
}

fn mv(ri: Ray, d: f32) -> Ray {
    var r = ri;
    r.o = pd(r, d);
    return r;
}

fn dir(ri: Ray, d: vec3f) -> Ray {
    var r = ri;
    r.d = d;
    return r;
}
