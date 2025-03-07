//! Ported to Rust from <https://github.com/Tw1ddle/Sky-Shader/blob/master/src/shaders/glsl/sky.fragment>

#![allow(unexpected_cfgs)]
#![cfg_attr(target_arch = "spirv", no_std)]
#![allow(clippy::len_without_is_empty)]
#![allow(clippy::manual_range_contains)]
#![allow(clippy::too_many_arguments)]

pub mod camera;
pub mod frame;
pub mod pass;
pub mod shader;
pub mod util;

pub use self::camera::*;
pub use self::frame::*;
pub use self::pass::*;
pub use self::shader::*;
pub use self::util::*;

pub mod prelude {
    #![allow(unexpected_cfgs)]

    pub use core::f32::consts::PI;

    pub use spirv_std::arch::IndexUnchecked;
    pub use spirv_std::glam::*;
    #[allow(dead_code)]
    #[cfg(target_arch = "spirv")]
    pub use spirv_std::num_traits::Float;
    pub use spirv_std::{spirv, Image, Sampler};

    pub use crate::*;
}
