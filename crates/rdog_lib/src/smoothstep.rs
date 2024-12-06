use spirv_std::glam::{Vec2, Vec3, Vec4};

/// Linear interpolation between two values, similar to GLSL's mix function
pub trait Smoothstep<T> {
    fn smoothstep(self, other: T, t: f32) -> T;
}

// Implementation for f32
impl Smoothstep<f32> for f32 {
    fn smoothstep(self, other: f32, x: f32) -> f32 {
        let t = ((x - self) / (other - self)).clamp(0.0, 1.0);
        t * t * (3.0 - 2.0 * t)
    }
}

// Implementation for Vec2
impl Smoothstep<Vec2> for Vec2 {
    fn smoothstep(self, other: Vec2, x: f32) -> Vec2 {
        let t = ((x - self) / (other - self)).clamp(Vec2::ZERO, Vec2::ONE);
        t * t * (Vec2::splat(3.0) - Vec2::splat(2.0) * t)
    }
}

// Implementation for Vec3
impl Smoothstep<Vec3> for Vec3 {
    fn smoothstep(self, other: Vec3, x: f32) -> Vec3 {
        let t = ((x - self) / (other - self)).clamp(Vec3::ZERO, Vec3::ONE);
        t * t * (Vec3::splat(3.0) - Vec3::splat(2.0) * t)
    }
}

// Implementation for Vec4
impl Smoothstep<Vec4> for Vec4 {
    fn smoothstep(self, other: Vec4, x: f32) -> Vec4 {
        let t = ((x - self) / (other - self)).clamp(Vec4::ZERO, Vec4::ONE);
        t * t * (Vec4::splat(3.0) - Vec4::splat(2.0) * t)
    }
}
