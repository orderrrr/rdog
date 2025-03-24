#define_import_path util

const PI: f32 = 3.14159265358979323846264338327950288;
const EPSILON: f32 = 1.19209290e-07f;

const ONE = vec3f(1.0);
const ZERO = vec3f(0.0);

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
