use crate::shader::RdogShaderAsset;

use super::{
    camera_controllers::RenderControllers,
    images::Images,
    render::CameraController,
    shaders::{RdogShader, ShaderCache},
    utils, Camera, CameraHandle, Config, Image,
};
use bevy::{asset::AssetId, log::info_once, prelude::Image as BevyImage, utils::HashMap};
use glam::Vec2;
use std::{mem, time::Instant};

use log::info;
use rdog_lib as lib;

#[derive(Debug)]
pub struct Engine {
    pub shaders: ShaderCache,
    pub frame: lib::Frame,
    pub time: Vec2,
    pub seed: u32,
    pub config: Config,
    // world: MappedUniformBuffer<gpu::World>,
    cameras: RenderControllers,
    images: Images,
    has_dirty_images: bool,
}

impl Engine {
    pub fn new(device: &wgpu::Device, seed: u32) -> Self {
        info!("Initializing");

        Self {
            shaders: ShaderCache::new_cache(),
            frame: lib::Frame::new(1),
            cameras: Default::default(),
            images: Images::new(device),
            time: Default::default(),
            has_dirty_images: false,
            seed,
            config: Config::default(),
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
            let mut cameras = mem::take(&mut self.cameras);

            for camera in cameras.iter_mut() {
                camera.invalidate(self, device);
            }

            self.cameras = cameras;
        }

        utils::measure("tick.cameras", || {
            for camera in self.cameras.iter_mut() {
                camera.flush(self.frame, queue);
            }
        });

        self.frame = lib::Frame::new(self.frame.get() + 1);

        utils::metric("tick", tt);
    }

    pub fn compute_shaders(
        &mut self,
        device: &wgpu::Device,
        shaders: &HashMap<String, RdogShaderAsset>, // TODO - this does not need to be a hash map.
    ) {
        for shader in shaders {
            log::info!("Computing shader: {}", shader.1.name);
            let comp = RdogShader::new(device, shader.1);
            self.shaders.entry(shader.1.name.to_string()).insert(comp);
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

    /// Updates camera, changing its mode, position, size etc.
    pub fn update_camera(&mut self, device: &wgpu::Device, handle: CameraHandle, camera: Camera) {
        let mut cameras = mem::take(&mut self.cameras);

        cameras.get_mut(handle).update(self, device, camera);

        self.cameras = cameras;
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
