use rdog_macro::TrackChanges;
use serde::{Deserialize, Serialize};
use std::{
    collections::HashMap,
    fmt::{Display, Formatter},
};

use bevy::{prelude::Resource, utils::default};
use glam::{uvec2, vec4, Mat4, UVec2, Vec2, Vec3};
use rdog_lib::{self as gpu, Light, Material, PassParams};

use crate::ui::{LightList, MaterialList};

use super::Engine;

#[derive(Clone, Debug, Resource, Serialize, Deserialize, PartialEq, TrackChanges)]
pub struct Config {
    pub ready: bool,

    pub res: f32,
    pub direct_pass: bool,
    pub specular_pass: bool,
    pub scatter_pass: bool,
    pub multi_frame_override: bool,
    pub multi_frame: bool,
    pub realtime_atmosphere: bool,
    pub user_orbit: bool,
    pub orbit_reset: bool,

    pub voxel_dim: u32,

    pub reload: bool,

    pub bounce_count: u32,
    pub pass_count: u32,

    pub sun_pos: Vec2,

    pub material_tree: MaterialList,
    pub light_tree: LightList,

    pub ray_debug: bool,

    pub camera_config: CameraConfig,

    pub output_pass_count: u32,
    pub output_bounce_count: u32,
    pub output_res: UVec2,
    pub output_pass_per_frame: UVec2,

    pub map: HashMap<String, f32>,
}

impl Config {
    pub fn to_pass_params(&self) -> PassParams {
        let mut flags: u32 = 0;

        flags |= self.direct_pass as u32;
        flags |= (self.scatter_pass as u32) << 1;
        flags |= (self.specular_pass as u32) << 2;
        flags |= (self.multi_frame as u32) << 3;

        PassParams {
            flags,
            sun_x: self.sun_pos.x,
            sun_y: self.sun_pos.y,
            pass_count: self.pass_count,
            bounce_count: self.bounce_count,
            voxel_dim: self.voxel_dim,
        }
    }

    pub fn to_pass_params_out(&self) -> PassParams {
        let mut flags: u32 = 0;

        flags |= self.direct_pass as u32;
        flags |= (self.scatter_pass as u32) << 1;
        flags |= (self.specular_pass as u32) << 2;
        flags |= (0) << 3; // set to true for cool images

        PassParams {
            flags,
            sun_x: self.sun_pos.x,
            sun_y: self.sun_pos.y,
            pass_count: self.output_pass_count,
            bounce_count: self.output_bounce_count,
            voxel_dim: self.voxel_dim,
        }
    }

    pub fn material_pass(&self) -> Vec<Material> {
        let mut m: Vec<Material> = vec![];
        for mat in self.material_tree.mats.iter() {
            m.push(mat.to_shader());
        }

        m
    }

    pub fn light_pass(&self) -> Vec<Light> {
        let mut l: Vec<Light> = vec![];
        for light in self.light_tree.lights.iter() {
            l.push(light.to_shader());
        }

        l
    }

    pub fn compute_pass_size(&self) -> UVec2 {
        (self.output_res.as_vec2() / self.output_pass_per_frame.as_vec2()).as_uvec2()
    }
}

impl Default for Config {
    fn default() -> Self {
        Self {
            ready: false,
            res: 0.25,
            reload: true,
            direct_pass: true,
            specular_pass: true,
            scatter_pass: true,
            multi_frame_override: true,
            multi_frame: true,
            realtime_atmosphere: false,
            user_orbit: false,
            material_tree: MaterialList::demo(), // TODO not demo, serialize from a file
            orbit_reset: true,
            sun_pos: Vec2::new(0.5, 0.7),
            pass_count: 8,
            bounce_count: 8,
            ray_debug: false,
            voxel_dim: 64,
            light_tree: LightList::default(),
            camera_config: CameraConfig::default(),
            output_res: uvec2(2160, 1440),
            output_pass_count: 8,
            output_bounce_count: 32,
            output_pass_per_frame: uvec2(2160 / 40, 480 / (1440 / 40)),
            map: default(),
        }
    }
}

#[derive(Clone, Debug, Resource, Serialize, Deserialize, PartialEq, TrackChanges)]
pub struct CameraConfig {
    pub focus_dist: f32,
    pub focus_point: Vec3,
    pub focal_length: f32,
    pub aperture: f32,
}

impl Default for CameraConfig {
    fn default() -> Self {
        Self {
            focus_dist: 3.0,
            focus_point: Vec3::ZERO,
            focal_length: 1.4,
            aperture: 0.52,
        }
    }
}

#[derive(Clone, Debug)]
pub struct Camera {
    pub mode: CameraMode,
    pub viewport: CameraViewport,
    pub transform: Mat4,
    pub projection: Mat4,
    pub focus_dist: f32,
    pub focus_point: Vec3,
    pub focal_length: f32,
    pub aperture: f32,
}

impl Camera {
    pub fn scale(&self, cfg: &Config) -> UVec2 {
        (self.viewport.size.as_vec2() * cfg.res).as_uvec2()
    }

    pub fn serialize(&self, cfg: &Config) -> gpu::camera::Camera {
        gpu::camera::Camera {
            projection_view: self.projection * self.transform.inverse(),
            ndc_to_world: self.transform * self.projection.inverse(),
            origin: self
                .transform
                .to_scale_rotation_translation()
                .2
                .extend(default()),
            screen: self.scale(cfg).as_vec2().extend(0.0).extend(0.0),
            fpd: self.focus_point.extend(self.focus_dist),
            af: vec4(self.aperture, self.focal_length, 0.0, 0.0),
        }
    }

    pub fn serialize_out(&self, config: &Config) -> gpu::camera::Camera {
        gpu::camera::Camera {
            projection_view: self.projection * self.transform.inverse(),
            ndc_to_world: self.transform * self.projection.inverse(),
            origin: self
                .transform
                .to_scale_rotation_translation()
                .2
                .extend(default()),
            screen: config.output_res.as_vec2().extend(0.0).extend(0.0),
            fpd: self.focus_point.extend(self.focus_dist),
            af: vec4(self.aperture, self.focal_length, 0.0, 0.0),
        }
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
    pub fn new(id: usize) -> Self {
        Self(id)
    }
}

#[derive(Clone, Debug)]
pub struct Globals {
    time: Vec2,
    seed: UVec2,
    mouse: Vec2,
    true_res: UVec2,
}

impl Globals {
    pub fn from_engine(engine: &Engine, cam: &Camera) -> Self {
        Self {
            time: engine.time,
            seed: uvec2(engine.seed, engine.seed + engine.frame.get()), // seed offset with current frame (for rays)
            mouse: engine.mouse / cam.viewport.size.as_vec2(),
            true_res: cam.viewport.size,
        }
    }

    pub fn serialize(&self) -> gpu::shader::Globals {
        gpu::shader::Globals {
            time: self.time,
            seed: self.seed,
            mouse: self.mouse,
            true_res: self.true_res,
        }
    }
}
