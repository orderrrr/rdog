use std::ops::DerefMut;

use crate::{buffers::mapped_uniform_buffer::MappedUniformBuffer, texture::Texture, Globals};

use super::{
    config::Camera,
    engine::Engine,
    passes::{Pass, Passes},
};
use log::{debug, info};
use rdog_lib as lib;
use rdog_shaders::atmosphere::{ATMOS_MULT, NOISE_DIM};

#[derive(Debug)]
pub struct Buffers {
    pub curr_camera: MappedUniformBuffer<lib::camera::Camera>,
    pub prev_camera: MappedUniformBuffer<lib::camera::Camera>,

    pub globals: MappedUniformBuffer<lib::shader::Globals>,

    pub sub_ray_tx: Texture,
    pub atmosphere_tx: Texture,
    pub atmos_noise_tx: Texture,
}

impl Buffers {
    pub fn new(engine: &Engine, device: &wgpu::Device, camera: &Camera) -> Self {
        debug!("Initializing camera buffers");

        let curr_camera = MappedUniformBuffer::new(device, "camera", camera.serialize());
        let prev_camera = MappedUniformBuffer::new(device, "prev_camera", camera.serialize());
        let globals =
            MappedUniformBuffer::new(device, "globals", Globals::from_engine(engine).serialize());

        let sub_ray_tx = Texture::builder("sub_ray")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba8Unorm)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let atmosphere_tx = Texture::builder("atmosphere")
            .with_size(camera.viewport.size * (ATMOS_MULT as u32)) // should be larger maybe? not sure
            .with_format(wgpu::TextureFormat::Rgba16Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let atmos_noise_tx = Texture::builder("atmos_noise")
            .with_size(NOISE_DIM)
            .with_format(wgpu::TextureFormat::Rgba8Unorm)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        Self {
            prev_camera,
            curr_camera,
            atmos_noise_tx,
            globals,
            sub_ray_tx,
            atmosphere_tx,
        }
    }
}

#[derive(Debug)]
pub struct CameraController {
    pub camera: Camera, // TODO camera impl
    pub buffers: Buffers,
    pub passes: Passes,
    pub frame: lib::Frame,
    pub recompute_static: bool,
}

impl CameraController {
    pub(crate) fn new(engine: &Engine, device: &wgpu::Device, camera: Camera) -> Self {
        info!("Creating camera `{}`", camera);

        let buffers = Buffers::new(engine, device, &camera);
        let passes = Passes::new(engine, device, &camera, &buffers);

        Self {
            camera,
            buffers,
            passes,
            frame: Default::default(),
            recompute_static: true,
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
        *self.buffers.globals.deref_mut() = Globals::from_engine(engine).serialize();

        self.recompute_static = false;

        if is_invalidated {
            self.rebuild_buffers(engine, device);
            self.rebuild_passes(engine, device);
            self.recompute_static = true;
        }
    }
    fn rebuild_buffers(&mut self, engine: &Engine, device: &wgpu::Device) {
        debug!("Rebuilding buffers for camera `{}`", self.camera);

        self.buffers = Buffers::new(engine, device, &self.camera);
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
        self.buffers.globals.flush(queue);
    }
}

impl Drop for CameraController {
    fn drop(&mut self) {
        info!("Deleting cameraRenderer `{}`", self.camera);
    }
}
