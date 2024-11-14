use super::{
    camera_controllers::RenderControllers, images::Images, render::CameraController,
    shaders::Shaders, utils, Camera, CameraHandle, Image, Time,
};
use bevy::{asset::AssetId, prelude::Image as BevyImage};
use std::{mem, time::Instant};

use log::info;
use rdog_lib as lib;

#[derive(Debug)]
pub struct Engine {
    pub shaders: Shaders,
    // images: Images<P>,
    pub frame: lib::Frame,
    pub time: Time,
    // world: MappedUniformBuffer<gpu::World>,
    cameras: RenderControllers,
    images: Images,
    has_dirty_images: bool,
}

impl Engine {
    pub fn new(device: &wgpu::Device) -> Self {
        info!("Initializing");

        Self {
            shaders: Shaders::new(device),
            frame: lib::Frame::new(1),
            cameras: Default::default(),
            images: Images::new(device),
            time: Time(Default::default()),
            has_dirty_images: false,
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
    pub fn create_camera(
        &mut self,
        device: &wgpu::Device,
        camera: Camera,
    ) -> CameraHandle {
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
