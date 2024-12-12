use glam::Vec3;

pub fn sd_round_box(p: Vec3, b: Vec3, r: f32) -> f32 {
    let q = p.abs() - b + r;
    (q.max(Vec3::splat(0.0))).length() + q.y.max(q.z).max(q.x).min(0.0) - r
}

pub fn sphere(p: Vec3, r: f32) -> f32 {
    p.length() - r
}

pub fn plane(p: Vec3, n: Vec3, h: f32) -> f32 {
    return p.dot(n) + h;
}


