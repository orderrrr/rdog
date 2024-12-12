use glam::{uvec2, uvec3, uvec4, vec2, vec3, vec4, UVec2, UVec3, UVec4, Vec4Swizzles};
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

pub trait Bits<T> {
    fn bits(&self) -> T;
    fn from_bits(input: T) -> Self;
}

impl Bits<u32> for f32 {
    fn bits(&self) -> u32 {
        self.to_bits()
    }

    fn from_bits(input: u32) -> Self {
        f32::from_bits(input)
    }
}

impl Bits<UVec2> for Vec2 {
    fn bits(&self) -> UVec2 {
        uvec2(self.x.bits(), self.y.bits())
    }

    fn from_bits(input: UVec2) -> Self {
        vec2(f32::from_bits(input.x), f32::from_bits(input.y))
    }
}

impl Bits<UVec3> for Vec3 {
    fn bits(&self) -> UVec3 {
        uvec3(self.x.bits(), self.y.bits(), self.z.bits())
    }

    fn from_bits(input: UVec3) -> Self {
        vec3(
            f32::from_bits(input.x),
            f32::from_bits(input.y),
            f32::from_bits(input.z),
        )
    }
}

impl Bits<UVec4> for Vec4 {
    fn bits(&self) -> UVec4 {
        uvec4(self.x.bits(), self.y.bits(), self.z.bits(), self.w.bits())
    }

    fn from_bits(input: UVec4) -> Self {
        vec4(
            f32::from_bits(input.x),
            f32::from_bits(input.y),
            f32::from_bits(input.z),
            f32::from_bits(input.w),
        )
    }
}

// Function to rotate a vector using a rotor
pub fn rotate_vector(q: Vec4, v: Vec3) -> Vec3 {
    let u = q.xyz();
    let s = q.w;
    2.0 * u.dot(v) * u + (s * s - u.dot(u)) * v + 2.0 * s * u.cross(v)
}

// Function to create a rotor (quaternion) for rotation around y-axis
pub fn rotor_y(a: f32) -> Vec4 {
    let ha = a * 0.5;
    vec4(0.0, ha.sin(), 0.0, ha.cos())
}

pub fn axis_angle_rotate(v: Vec3, axis: Vec3, a: f32) -> Vec3 {
    let ha = a * 0.5;
    let sh = ha.sin();

    let s = ha.cos();
    let b = axis * sh;

    let temp = b.cross(v) + s * v;
    v + 2.0 * b.cross(temp)
}

