use crate::{prelude::*, Clamp};

pub fn sd_round_box(p: Vec3, b: Vec3, r: f32) -> f32 {
    let q = p.abs() - b + r;
    (q.max(Vec3::splat(0.0))).length() + q.y.max(q.z).max(q.x).min(0.0) - r
}

pub fn sphere(p: Vec3, r: f32) -> f32 {
    p.length() - r
}

pub fn sd_rounded_cylinder(p: Vec3, ra: f32, rb: f32, h: f32) -> f32 {
    let d = Vec2::new(p.xz().length() - 2.0 * ra + rb, p.y.abs() - h);
    (d.max_element().min(0.0) + d.max(Vec2::ZERO).length()) - rb
}

pub fn op_smooth_union(d1: f32, d2: f32, k: f32) -> f32 {
    let h = (0.5 + 0.5 * (d2 - d1) / k).c(0.0, 1.0);
    d2 + (d1 - d2) * h - k * h * (1.0 - h)
}

pub fn op_smooth_subtraction(d1: f32, d2: f32, k: f32) -> f32 {
    let h = (0.5 - 0.5 * (d2 + d1) / k).c(0.0, 1.0);
    d2.lerp(-d1, h) + k * h * (1.0 - h)
}

pub fn min_sd(d1: Vec2, d2: Vec2) -> Vec2 {
    if d1.x < d2.x {
        d1
    } else {
        d2
    }
}

pub fn plane(pos: Vec3, n: Vec4) -> f32 {
    pos.dot(n.xyz()) + n.w
}

pub struct SdSphere {
    pub r: f32,
    pub p: Vec3,
    pub m: f32,
}

impl SdSphere {
    pub fn new(p: Vec3, r: f32, m: f32) -> Self {
        Self { p, r, m }
    }
}

pub struct SdRoundedCylinder {
    pub p: Vec3,
    pub ra: f32,
    pub rb: f32,
    pub h: f32,
    pub m: f32, // TODO - should probably be a u32...
}

impl SdRoundedCylinder {
    pub fn new(p: Vec3, ra: f32, rb: f32, h: f32, m: f32) -> Self {
        Self { p, ra, rb, h, m }
    }
}

pub struct SdPlane {
    pub n: Vec4,
    pub p: Vec3,
    pub m: f32,
}

impl SdPlane {
    pub fn new(p: Vec3, n: Vec4, m: f32) -> Self {
        Self { p, n, m }
    }
}

pub enum Prim {
    Sphere(SdSphere),
    Plane(SdPlane),
    RoundedCylinder,
    Op(((usize, usize), Op)),
}

impl Prim {
    pub fn sphere(p: Vec3, r: f32, m: f32) -> Self {
        Prim::Sphere(SdSphere::new(p, r, m))
    }

    pub fn plane(p: Vec3, n: Vec4, m: f32) -> Self {
        Prim::Plane(SdPlane::new(p, n, m))
    }

    pub fn op(p: (usize, usize), op: Op) -> Self {
        Prim::Op((p, op))
    }
}

pub struct SdOp {
    pub k: f32,
}

impl SdOp {
    pub fn new(k: f32) -> Self {
        Self { k }
    }
}

pub enum Op {
    SmoothUnion(SdOp),
    SmoothSubtraction(SdOp),
}

impl Op {
    pub fn smooth_union(k: f32) -> Self {
        Self::SmoothUnion(SdOp::new(k))
    }

    pub fn smooth_subtraction(k: f32) -> Self {
        Self::SmoothSubtraction(SdOp::new(k))
    }
}
