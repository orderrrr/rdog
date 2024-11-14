use std::hash::Hash;
use std::fmt::Debug;
use std::ops::Deref;

pub mod config;
pub mod shaders;
pub mod passes;
pub mod render;
pub mod engine;
pub mod camera_controllers;
pub mod images;
pub mod utils;
pub mod compute_pass;

pub use self::config::*;
pub use self::engine::*;
pub use self::images::*;

/// This exists to faciliate integrations with existing systems, such as Bevy,
/// that already have their own newtypes for images, instances and so on.
pub trait Params {
    type ImageHandle: Clone + Copy + Debug + Eq + Hash;
    type ImageTexture: Debug + Deref<Target = wgpu::Texture>;
    type InstanceHandle: Clone + Copy + Debug + Eq + Hash;
    type LightHandle: Clone + Copy + Debug + Eq + Hash;
    type MaterialHandle: Clone + Copy + Debug + Eq + Hash;
    type MeshHandle: Clone + Copy + Debug + Eq + Hash;
}
