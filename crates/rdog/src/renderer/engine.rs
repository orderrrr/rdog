use crate::shader::RdogShaderAsset;

use super::{
    buffers::{texture::Texture, Buffers},
    camera_controllers::RenderControllers,
    images::Images,
    passes::Passes,
    render::CameraController,
    shaders::ShaderCache,
    Camera, CameraHandle, Config, Image,
};
use bevy::{asset::AssetId, prelude::Image as BevyImage, utils::default};
use glam::Vec2;
use log::info;
use rdog_lib::{self as lib};
use std::{collections::HashMap, sync::Arc};
use wgpu::{naga, Buffer};

#[derive(Debug)]
pub struct Engine {
    pub ready: bool,

    pub shaders: ShaderCache,

    pub frame: lib::Frame,

    pub time: Vec2,
    pub seed: u32,

    pub cameras: RenderControllers,
    images: Images,
    pub dirty: bool,

    pub mouse: Vec2,
}

impl Engine {
    pub fn new(device: &wgpu::Device, seed: u32) -> Self {
        info!("Initializing");

        Self {
            ready: false,
            shaders: ShaderCache::new(vec![naga::valid::Capabilities::PUSH_CONSTANT]),
            frame: lib::Frame::new(1),
            images: Images::new(device),
            time: default(),
            cameras: default(),
            dirty: true,
            seed,
            mouse: Vec2::default(),
        }
    }

    pub fn get_buffer(&self, buffers: &Buffers, buffer_name: &str) -> Arc<Buffer> {
        buffers.get_old(&buffer_name).buffer()
    }

    pub fn get_texture<'a>(&self, buffers: &'a Buffers, buffer_name: &str) -> &'a Texture {
        buffers.get_old(&buffer_name).texture()
    }

    // TODO: redo this.
    pub fn compute_shaders(&mut self, device: &wgpu::Device, shaders: &Vec<RdogShaderAsset>) {
        self.shaders.update_shaders(device, shaders);
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
        config: &Config,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        passes: &HashMap<CameraHandle, Passes>,
        pass_params: Option<&Vec<u8>>,
    ) {
        if passes.contains_key(&handle) {
            self.cameras.get(handle).render(
                self,
                config,
                encoder,
                view,
                passes.get(&handle).unwrap(),
                pass_params,
            );
        }
    }

    pub fn render_camera_pass(
        &self,
        handle: CameraHandle,
        config: &Config,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass: &str,
        passes: &HashMap<CameraHandle, Passes>,
        pass_params: Option<&Vec<u8>>,
    ) {
        info!("render_camera_pass: {}", pass);
        self.cameras.get(handle).render_pass(
            self,
            config,
            encoder,
            view,
            pass,
            passes.get(&handle).unwrap(),
            pass_params,
        );
    }

    /// Updates camera, changing its mode, position, size etc.
    pub fn update_camera(&mut self, handle: CameraHandle, camera: Camera) {
        self.cameras.get_mut(handle).camera = camera;
    }

    /// Creates a new camera that can be used to render the world.
    ///
    /// Note that this is a pretty heavy operation that allocates per-camera
    /// buffers etc., and so it's expected that you only call this function when
    /// necessary (not, say, each frame).
    pub fn create_camera(&mut self, camera: Camera) -> CameraHandle {
        self.cameras.add(CameraController::new(camera))
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
        self.dirty = true;
    }

    /// Removes an image.
    ///
    /// Note that removing an image doesn't automatically remove materials that
    /// refer to this image.
    pub fn remove_image(&mut self, handle: AssetId<BevyImage>) {
        self.images.remove(handle);
        self.dirty = true;
    }
}
