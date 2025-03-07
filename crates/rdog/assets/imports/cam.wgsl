#define_import_path cam

fn project_point3(transform: mat4x4f, rhs: vec3f) -> vec3f {
    var res: vec4f = transform[0] * rhs.x;
    res = (transform[1] * rhs.y) + res;
    res = (transform[2] * rhs.z) + res;
    res = transform[3] + res;
    res = res / res.w;
    return res.xyz;
}
