use crate::{
    shader::{FType, RdogShaderAsset, ShaderType},
    texture::Texture,
};

use super::{
    buffers::Buffers,
    camera_controllers::RenderControllers,
    images::Images,
    passes::Passes,
    render::CameraController,
    shaders::{RdogShader, ShaderCache},
    Camera, CameraHandle, Config, Image,
};
use bevy::{
    asset::AssetId,
    log::{error, warn},
    prelude::Image as BevyImage,
    utils::{default, HashMap},
};
use glam::Vec2;
use naga_oil::compose::{ComposableModuleDescriptor, Composer};
use std::sync::Arc;
use wgpu::Buffer;

use log::info;
use rdog_lib::{self as lib};

#[derive(Debug)]
pub struct Engine {
    pub shaders: ShaderCache,
    pub shader_compose: Composer,

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
            mouse: Vec2::default(),
            shader_compose: Composer::default(),
        }
    }

    pub fn get_buffer(&self, buffers: &Buffers, buffer_name: &str) -> Arc<Buffer> {
        return buffers.get_old(&buffer_name).buffer();
    }

    pub fn get_texture<'a>(&self, buffers: &'a Buffers, buffer_name: &str) -> &'a Texture {
        return buffers.get_old(&buffer_name).texture();
    }

    // TODO: redo this.
    pub fn compute_shaders(&mut self, device: &wgpu::Device, shaders: &Vec<RdogShaderAsset>) {
        let mut lib_names = Vec::new();

        let mut shaders_remaining = shaders.clone();
        let mut retry_count = 0;
        const MAX_RETRIES: usize = 5; // Adjust based on your needs

        while !shaders_remaining.is_empty() && retry_count < MAX_RETRIES {
            let mut failed_shaders = Vec::new();

            for i in 0..shaders_remaining.len() {
                let shader = &mut shaders_remaining[i];
                match shader.stype {
                    ShaderType::Lib => {
                        if let FType::Wgsl(source) = &shader.data {
                            match self.shader_compose.add_composable_module(
                                ComposableModuleDescriptor {
                                    source,
                                    file_path: &shader.name,
                                    ..Default::default()
                                },
                            ) {
                                Ok(_) => {
                                    info!("Library module loaded: {}", shader.name);
                                    lib_names.push(shader.name.clone());
                                }
                                Err(e) => {
                                    error!(
                                        "Failed to load library module {}: {e:#?}. Retrying...",
                                        shader.name
                                    );
                                    failed_shaders.push(shader.clone());
                                }
                            }
                        }
                    }
                    _ => (),
                }
            }

            // Remove successfully processed shaders
            shaders_remaining.retain(|s| !lib_names.contains(&s.name));

            retry_count += 1;
        }

        if shaders_remaining.is_empty() {
            info!("All shaders have been successfully loaded.");
        } else {
            warn!(
                "Some shaders failed to load even after {} retries.",
                MAX_RETRIES
            );
            // Handle the remaining failed shaders here if needed
        }

        if !lib_names.is_empty() {
            for (shader_name, shader) in &mut self.shaders.iter_mut() {
                if shader
                    .imports
                    .iter()
                    .any(|import| lib_names.contains(import))
                {
                    let asset = RdogShaderAsset {
                        name: shader_name.clone(),
                        data: FType::Wgsl(shader.data.clone().into()),
                        stype: ShaderType::Shader,
                    };

                    let comp =
                        RdogShader::new(self.frame.get(), device, &asset, &mut self.shader_compose);

                    if let Some(s) = comp {
                        *shader = s;
                        info!("Updated dependent shader: {}", shader_name);
                    }
                }
            }
        }

        for shader in shaders {
            match shader.stype {
                ShaderType::Shader => {
                    log::info!("Computing shader: {}", shader.name);
                    if let Some(comp) =
                        RdogShader::new(self.frame.get(), device, shader, &mut self.shader_compose)
                    {
                        self.shaders.insert(shader.name.to_string(), comp);
                    }
                }
                _ => (),
            }
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
        config: &Config,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        passes: &HashMap<CameraHandle, Passes>,
        pass_params: Option<&[u8]>,
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
        pass_params: Option<&[u8]>,
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
