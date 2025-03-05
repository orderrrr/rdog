use crate::shader::{FType, RdogShaderAsset, ShaderType};

use super::{
    camera_controllers::RenderControllers,
    images::Images,
    render::CameraController,
    shaders::{RdogShader, ShaderCache},
    utils, Camera, CameraHandle, Config, Image,
};
use bevy::{asset::AssetId, log::error, prelude::Image as BevyImage, utils::default};
use glam::Vec2;
use naga_oil::compose::{ComposableModuleDescriptor, Composer};
use std::{sync::Arc, time::Instant};
use wgpu::Buffer;

use log::info;
use rdog_lib::{self as lib};

#[derive(Debug)]
pub struct Engine {
    pub config: Config,

    pub shaders: ShaderCache,
    pub frame: lib::Frame,

    pub time: Vec2,
    pub seed: u32,

    pub cameras: RenderControllers,
    images: Images,
    has_dirty_images: bool,

    pub mouse: Vec2,
}

impl Engine {
    pub fn new(device: &wgpu::Device, seed: u32) -> Self {
        info!("Initializing");

        Self {
            shaders: ShaderCache::new_cache(),
            frame: lib::Frame::new(1),
            images: Images::new(device),
            time: default(),
            cameras: default(),
            has_dirty_images: false,
            seed,
            config: Config::default(),
            mouse: Vec2::default(),
        }
    }

    /// Sends all changes to the GPU and prepares it for the upcoming frame.
    ///
    /// This function must be called before invoking [`Self::render_camera()`]
    /// (if you have multiple cameras, calling this function just once is
    /// enough.)
    pub fn tick(&mut self, device: &wgpu::Device, queue: &wgpu::Queue) {
        let tt = Instant::now();

        let any_buffer_reallocated = utils::measure("tick.buffers", || false);

        if any_buffer_reallocated {
            for camera in &mut self.cameras.iter_mut() {
                camera.invalidate(self, device);
            }
        }

        utils::measure("tick.cameras", || {
            for camera in &mut self.cameras.iter_mut() {
                camera.flush(self.frame, queue);
            }
        });

        self.frame = lib::Frame::new(self.frame.get() + 1);

        utils::metric("tick", tt);
    }

    pub fn get_buffer(&self, buffer_name: &str) -> Arc<Buffer> {
        return self.cameras.get_first().buffers.get(&buffer_name).buffer();
    }

    pub fn compute_shaders(&mut self, device: &wgpu::Device, shaders: &Vec<RdogShaderAsset>) {
        let mut composer = Composer::default();

        let mut load_composable = |source: &str, file_path: &str| match composer
            .add_composable_module(ComposableModuleDescriptor {
                source,
                file_path,
                ..Default::default()
            }) {
            Ok(_module) => {
                info!("module loaded: {}", file_path)
            }
            Err(e) => {
                error!("? -> {e:#?}")
            }
        };

        for shader in shaders {
            match shader.stype {
                ShaderType::Shader => continue,
                _ => (),
            }

            let data = match &shader.data {
                FType::Wgsl(s) => s,
                FType::Spv(_) => continue,
            };

            load_composable(&data, &shader.name);
        }

        for shader in shaders {
            match shader.stype {
                ShaderType::Lib => continue,
                _ => (),
            }

            log::info!("Computing shader: {}", shader.name);
            let comp = RdogShader::new(self.frame.get(), device, shader, &mut composer);

            if comp.is_none() {
                continue;
            }

            self.shaders
                .entry(shader.name.to_string())
                .insert(comp.unwrap());
        }

        for camera in &mut self.cameras.iter_mut() {
            camera.invalidate(&self, device);
        }
    }
}

/// Camera stuff.
impl Engine {
    /// Renders camera to texture.
    ///
    /// Note that `view`'s texture format must be the same as the format given
    /// to [`Self::create_camera()`].
    pub fn render_camera(
        &self,
        handle: CameraHandle,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
    ) {
        self.cameras.get(handle).render(self, encoder, view);
    }

    pub fn render_camera_pass(
        &self,
        handle: CameraHandle,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass: &str,
    ) {
        self.cameras
            .get(handle)
            .render_pass(self, encoder, view, pass);
    }

    /// Updates camera, changing its mode, position, size etc.
    pub fn update_camera(&mut self, device: &wgpu::Device, handle: CameraHandle, camera: Camera) {
        self.cameras.get_mut(handle).update(self, device, camera);
    }

    /// Creates a new camera that can be used to render the world.
    ///
    /// Note that this is a pretty heavy operation that allocates per-camera
    /// buffers etc., and so it's expected that you only call this function when
    /// necessary (not, say, each frame).
    pub fn create_camera(&mut self, device: &wgpu::Device, camera: Camera) -> CameraHandle {
        self.cameras
            .add(CameraController::new(self, device, camera))
    }

    /// Deletes a camera.
    ///
    /// After this function is called, updating or rendering this camera will
    /// panic.
    pub fn delete_camera(&mut self, handle: CameraHandle) {
        self.cameras.remove(handle);
    }
}

/// Image stuff.
impl Engine {
    /// Creates or updates an image.
    pub fn insert_image(&mut self, image_handle: AssetId<BevyImage>, image: Image) {
        self.images.insert(image_handle, image);
        self.has_dirty_images = true;
    }

    /// Removes an image.
    ///
    /// Note that removing an image doesn't automatically remove materials that
    /// refer to this image.
    pub fn remove_image(&mut self, handle: AssetId<BevyImage>) {
        self.images.remove(handle);
        self.has_dirty_images = true;
    }
}
