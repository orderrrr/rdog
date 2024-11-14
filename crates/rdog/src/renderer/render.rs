use std::ops::DerefMut;

use crate::{buffers::mapped_uniform_buffer::MappedUniformBuffer, texture::Texture};

use super::{
    config::Camera,
    engine::Engine,
    passes::{Pass, Passes},
    Time,
};
use glam::uvec2;
use log::{debug, info};
use rdog_lib as lib;
use rdog_shaders::atmosphere::SIZE;

#[derive(Debug)]
pub struct Buffers {
    pub curr_camera: MappedUniformBuffer<lib::camera::Camera>,
    pub prev_camera: MappedUniformBuffer<lib::camera::Camera>,

    pub time: MappedUniformBuffer<lib::shader::Time>,

    pub sub_ray: Texture,
    pub atmosphere: Texture,
}

impl Buffers {
    pub fn new(device: &wgpu::Device, camera: &Camera, time: &Time) -> Self {
        // // Returns the size of a screen-space buffer with given parameters
        // let viewport_buffer_size = |element_size| {
        //     (camera.viewport.size.x as usize) * (camera.viewport.size.y as usize) * element_size
        // };

        debug!("Initializing camera buffers");

        let curr_camera = MappedUniformBuffer::new(device, "camera", camera.serialize());
        let prev_camera = MappedUniformBuffer::new(device, "prev_camera", camera.serialize());
        let time = MappedUniformBuffer::new(device, "time", time.serialize());

        let sub_ray = Texture::builder("sub_ray")
            .with_size(uvec2(1080, 1080)) // TODO - put this somewhere.
            .with_format(wgpu::TextureFormat::Rgba16Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let atmosphere = Texture::builder("atmosphere")
            .with_size(uvec2(SIZE, SIZE * SIZE)) // TODO - put this somewhere.
            .with_format(wgpu::TextureFormat::Rgba16Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        Self {
            prev_camera,
            curr_camera,
            time,
            sub_ray,
            atmosphere,
        }
    }
}

#[derive(Debug)]
pub struct CameraController {
    pub camera: Camera, // TODO camera impl
    pub buffers: Buffers,
    pub passes: Passes,
    pub frame: lib::Frame,
}

impl CameraController {
    pub(crate) fn new(engine: &Engine, device: &wgpu::Device, camera: Camera) -> Self {
        info!("Creating camera `{}`", camera);

        let buffers = Buffers::new(device, &camera, &engine.time);
        let passes = Passes::new(engine, device, &camera, &buffers);

        Self {
            camera,
            buffers,
            passes,
            frame: Default::default(),
        }
    }

    /// Returns whether the current frame should use the first or the second
    /// resource when given resource is double-buffered.
    pub fn is_alternate(&self) -> bool {
        self.frame.get() % 2 == 1
    }

    pub fn update(&mut self, engine: &Engine, device: &wgpu::Device, camera: Camera) {
        let is_invalidated = self.camera.is_invalidated_by(&camera);

        self.camera = camera;
        *self.buffers.prev_camera.deref_mut() = *self.buffers.curr_camera;
        *self.buffers.curr_camera.deref_mut() = self.camera.serialize();
        *self.buffers.time.deref_mut() = engine.time.serialize();

        if is_invalidated {
            self.rebuild_buffers(engine, device);
            self.rebuild_passes(engine, device);
        }
    }
    fn rebuild_buffers(&mut self, engine: &Engine, device: &wgpu::Device) {
        debug!("Rebuilding buffers for camera `{}`", self.camera);

        self.buffers = Buffers::new(device, &self.camera, &engine.time);
    }

    fn rebuild_passes(&mut self, engine: &Engine, device: &wgpu::Device) {
        debug!("Rebuilding passes for camera `{}`", self.camera);

        self.passes = Passes::new(engine, device, &self.camera, &self.buffers);
    }

    pub fn render(
        &self,
        engine: &Engine,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
    ) {
        for pass in &self.passes.0 {
            pass.run(engine, self, encoder, view);
        }
    }

    pub fn invalidate(&mut self, engine: &Engine, device: &wgpu::Device) {
        self.rebuild_passes(engine, device);
    }

    pub fn flush(&mut self, frame: lib::Frame, queue: &wgpu::Queue) {
        self.frame = frame;
        self.buffers.curr_camera.flush(queue);
        self.buffers.prev_camera.flush(queue);
        self.buffers.time.flush(queue);
    }
}

impl Drop for CameraController {
    fn drop(&mut self) {
        info!("Deleting cameraRenderer `{}`", self.camera);
    }
}
