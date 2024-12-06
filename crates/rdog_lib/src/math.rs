use glam::{vec2, vec3, vec4};
use spirv_std::glam::{Vec2, Vec3, Vec4};
#[cfg(target_arch = "spirv")]
use spirv_std::num_traits::Float;

/// Linear interpolation between two values, similar to GLSL's mix function
pub trait Math<T> {
    fn cos(&self) -> T;
    fn sin(&self) -> T;
    fn exp2(&self) -> T;
    fn sqrt(&self) -> T;
}

// Implementation for Vec2
impl Math<Vec2> for Vec2 {
    fn cos(&self) -> Vec2 {
        vec2(self.x.cos(), self.y.cos())
    }

    fn sin(&self) -> Vec2 {
        vec2(self.x.sin(), self.y.sin())
    }

    fn exp2(&self) -> Vec2 {
        vec2(self.x.exp2(), self.y.exp2())
    }

    fn sqrt(&self) -> Vec2 {
        vec2(self.x.sqrt(), self.y.sqrt())
    }
}

// Implementation for Vec3
impl Math<Vec3> for Vec3 {
    fn cos(&self) -> Vec3 {
        vec3(self.x.cos(), self.y.cos(), self.z.cos())
    }

    fn sin(&self) -> Vec3 {
        vec3(self.x.sin(), self.y.sin(), self.z.sin())
    }

    fn exp2(&self) -> Vec3 {
        vec3(self.x.exp2(), self.y.exp2(), self.z.exp2())
    }

    fn sqrt(&self) -> Vec3 {
        vec3(self.x.sqrt(), self.y.sqrt(), self.z.sqrt())
    }
}

// Implementation for Vec4
impl Math<Vec4> for Vec4 {
    fn cos(&self) -> Vec4 {
        vec4(self.x.cos(), self.y.cos(), self.z.cos(), self.w.cos())
    }

    fn sin(&self) -> Vec4 {
        vec4(self.x.sin(), self.y.sin(), self.z.sin(), self.w.sin())
    }

    fn exp2(&self) -> Vec4 {
        vec4(self.x.exp2(), self.y.exp2(), self.z.exp2(), self.w.exp2())
    }

    fn sqrt(&self) -> Vec4 {
        vec4(self.x.sqrt(), self.y.sqrt(), self.z.sqrt(), self.w.sqrt())
    }
}

pub trait Wrap<T> {
    fn wrap(&self) -> T;
}

impl Wrap<f32> for f32 {
    fn wrap(&self) -> f32 {
        if *self > 0.0 {
            self % 1.0
        } else {
            1.0 - (-self % 1.0)
        }
    }
}

impl Wrap<Vec2> for Vec2 {
    fn wrap(&self) -> Vec2 {
        vec2(self.x.wrap(), self.y.wrap())
    }
}

impl Wrap<Vec3> for Vec3 {
    fn wrap(&self) -> Vec3 {
        vec3(self.x.wrap(), self.y.wrap(), self.z.wrap())
    }
}

impl Wrap<Vec4> for Vec4 {
    fn wrap(&self) -> Vec4 {
        vec4(self.x.wrap(), self.y.wrap(), self.z.wrap(), self.w.wrap())
    }
}
