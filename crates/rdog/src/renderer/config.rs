use serde::{Serialize, Deserialize};
use std::fmt::{Display, Formatter};

use bevy::prelude::Resource;
use glam::{uvec2, Mat4, UVec2, Vec2};
use log::info;
use rdog_lib::{self as gpu, Material, PassParams};

use crate::ui::MaterialList;

use super::Engine;

#[derive(Clone, Debug, Resource, Serialize, Deserialize)]
pub struct Config {
    pub direct_pass: bool,
    pub specular_pass: bool,
    pub scatter_pass: bool,
    pub multi_frame_override: bool,
    pub multi_frame: bool,
    pub realtime_atmosphere: bool,
    pub material_tree: MaterialList,
    pub user_orbit: bool,
}

impl Config {
    pub(crate) fn to_pass_params(&self) -> PassParams {
        let mut flags: u32 = 0;

        flags |= self.direct_pass as u32;
        flags |= (self.scatter_pass as u32) << 1;
        flags |= (self.specular_pass as u32) << 2;
        flags |= (self.multi_frame as u32) << 3;

        PassParams { flags }
    }

    pub(crate) fn material_pass(&self) -> Vec<Material> {
        let mut m: Vec<rdog_lib::Material> = vec![];
        for mat in self.material_tree.mats.iter() {
            m.push(mat.to_shader());
        }

        m
    }
}

impl Default for Config {
    fn default() -> Self {
        Self {
            direct_pass: true,
            specular_pass: true,
            scatter_pass: true,
            multi_frame_override: true,
            multi_frame: true,
            realtime_atmosphere: false,
            user_orbit: false,
            material_tree: MaterialList::demo(), // TODO not demo, serialize from a file
        }
    }
}

#[derive(Clone, Debug)]
pub struct Camera {
    pub mode: CameraMode,
    pub viewport: CameraViewport,
    pub transform: Mat4,
    pub projection: Mat4,
}

impl Camera {
    pub(crate) fn serialize(&self) -> gpu::camera::Camera {
        gpu::camera::Camera {
            projection_view: self.projection * self.transform.inverse(),
            ndc_to_world: self.transform * self.projection.inverse(),
            origin: self
                .transform
                .to_scale_rotation_translation()
                .2
                .extend(Default::default()),
            screen: self
                .viewport
                .size
                .as_vec2()
                .extend(Default::default())
                .extend(Default::default()),
        }
    }

    pub(crate) fn is_invalidated_by(&self, older: &Self) -> bool {
        if self.mode != older.mode {
            info!(
                "Camera `{}` invalidated: mode has been changed ({:?} -> {:?})",
                older, older.mode, self.mode,
            );

            return true;
        }

        if self.viewport.format != older.viewport.format {
            info!(
                "Camera `{}` invalidated: viewport.format has been changed \
                 ({:?} -> {:?})",
                older, older.viewport.format, self.viewport.format,
            );

            return true;
        }

        if self.viewport.size != older.viewport.size {
            info!(
                "Camera `{}` invalidated: viewport.size has been changed \
                 ({} -> {})",
                older, older.viewport.size, self.viewport.size,
            );

            return true;
        }

        false
    }
}

impl Display for Camera {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "pos={}x{}, size={}x{}, format={:?}",
            self.viewport.position.x,
            self.viewport.position.y,
            self.viewport.size.x,
            self.viewport.size.y,
            self.viewport.format,
        )
    }
}

#[derive(Clone, Debug)]
pub struct CameraViewport {
    pub format: wgpu::TextureFormat,
    pub size: UVec2,
    pub position: UVec2,
}

impl Default for CameraViewport {
    fn default() -> Self {
        Self {
            format: wgpu::TextureFormat::Rgba8UnormSrgb,
            size: uvec2(512, 512),
            position: uvec2(0, 0),
        }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum CameraMode {
    /// Shows the final composed image, default
    Image,
}

impl Default for CameraMode {
    fn default() -> Self {
        Self::Image
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, Hash)]
pub struct CameraHandle(usize);

impl CameraHandle {
    pub(crate) fn new(id: usize) -> Self {
        Self(id)
    }
}

#[derive(Clone, Debug)]
pub struct Globals {
    time: Vec2,
    seed: UVec2,
}

impl Globals {
    pub fn from_engine(engine: &Engine) -> Self {
        Self {
            time: engine.time,
            seed: uvec2(engine.seed, engine.seed + engine.frame.get()), // seed offset with current frame (for rays)
        }
    }

    pub(crate) fn serialize(&self) -> gpu::shader::Globals {
        gpu::shader::Globals {
            time: self.time,
            seed: self.seed,
        }
    }
}
