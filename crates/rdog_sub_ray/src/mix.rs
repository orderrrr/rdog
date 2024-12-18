use spirv_std::glam::{Vec2, Vec3, Vec4};

/// Linear interpolation between two values, similar to GLSL's mix function
pub trait Mix<T> {
    fn mix(self, other: T, t: f32) -> T;
}

// Implementation for f32
impl Mix<f32> for f32 {
    fn mix(self, other: f32, t: f32) -> f32 {
        self * (1.0 - t) + other * t
    }
}

// Implementation for Vec2
impl Mix<Vec2> for Vec2 {
    fn mix(self, other: Vec2, t: f32) -> Vec2 {
        self * (1.0 - t) + other * t
    }
}

// Implementation for Vec3
impl Mix<Vec3> for Vec3 {
    fn mix(self, other: Vec3, t: f32) -> Vec3 {
        self * (1.0 - t) + other * t
    }
}

// Implementation for Vec4
impl Mix<Vec4> for Vec4 {
    fn mix(self, other: Vec4, t: f32) -> Vec4 {
        self * (1.0 - t) + other * t
    }
}
