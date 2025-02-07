use crate::{
    buffers::mapped_uniform_buffer::MappedUniformBuffer, storage_buffer::StorageBuffer,
    texture::Texture, Globals,
};
use std::ops::DerefMut;

use super::{
    config::Camera,
    engine::Engine,
    passes::{Pass, Passes},
};
use log::{debug, info};
use rdog_lib::{self as lib, Light, Material};
use rdog_shaders::atmosphere::{ATMOS_MULT, NOISE_DIM};

#[derive(Debug)]
pub struct Buffers {
    pub curr_camera: MappedUniformBuffer<lib::camera::Camera>,
    pub prev_camera: MappedUniformBuffer<lib::camera::Camera>,
    pub config: MappedUniformBuffer<lib::PassParams>,

    pub materials: StorageBuffer<Material>,
    pub lights: StorageBuffer<Light>,
    pub globals: MappedUniformBuffer<lib::shader::Globals>,

    pub render_tx: Texture,
    pub render_alt_tx: Texture,
    pub prev_tx: Texture,
    // pub atmosphere_tx: Texture,
    // pub atmos_noise_tx: Texture,
}

impl Buffers {
    pub fn new(engine: &Engine, device: &wgpu::Device, camera: &Camera) -> Self {
        debug!("Initializing camera buffers");

        let curr_camera = MappedUniformBuffer::new(device, "camera", camera.serialize());
        let prev_camera = MappedUniformBuffer::new(device, "prev_camera", camera.serialize());
        let globals =
            MappedUniformBuffer::new(device, "globals", Globals::from_engine(engine).serialize());
        let config = MappedUniformBuffer::new(device, "config", engine.config.to_pass_params());
        let materials = StorageBuffer::new(device, "materials", engine.config.material_pass());
        let lights = StorageBuffer::new(device, "lights", engine.config.light_pass());

        let render_tx = Texture::builder("render")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let render_alt_tx = Texture::builder("renderalt")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let prev_tx = Texture::builder("prev_tx")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        // let atmosphere_tx = Texture::builder("atmosphere")
        //     .with_size((camera.viewport.size.as_vec2() * ATMOS_MULT).as_uvec2()) // should be larger maybe? not sure
        //     .with_format(wgpu::TextureFormat::Rgba16Float)
        //     .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
        //     .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
        //     .with_linear_filtering_sampler()
        //     .build(device);

        // let atmos_noise_tx = Texture::builder("atmos_noise")
        //     .with_size(NOISE_DIM)
        //     .with_format(wgpu::TextureFormat::Rgba16Float)
        //     .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
        //     .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
        //     .with_linear_filtering_sampler()
        //     .build(device);

        Self {
            prev_camera,
            curr_camera,
            // atmos_noise_tx,
            globals,
            render_tx,
            render_alt_tx,
            prev_tx,
            // atmosphere_tx,
            config,
            materials,
            lights,
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
        *self.buffers.config.deref_mut() = engine.config.to_pass_params();

        if engine.config.material_tree.modified {
            *self.buffers.materials.deref_mut() = engine.config.material_pass();
        }

        if engine.config.light_tree.modified {
            *self.buffers.lights.deref_mut() = engine.config.light_pass();
        }

        if engine.config.material_tree.list_changed {
            log::info!("Material tree changed.");
            self.buffers.materials =
                StorageBuffer::new(device, "materials", engine.config.material_pass());
            self.rebuild_passes(engine, device);
        }

        if engine.config.light_tree.list_changed {
            log::info!("Light tree changed.");
            self.buffers.lights = StorageBuffer::new(device, "lights", engine.config.light_pass());
            self.rebuild_passes(engine, device);
        }

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
        let pp = engine.config.to_pass_params();

        for pass in &self.passes.0 {
            pass.run(engine, self, encoder, view, &pp);
        }
    }

    pub fn invalidate(&mut self, engine: &Engine, device: &wgpu::Device) {
        self.recompute_static = true;
        self.rebuild_buffers(engine, device); // TODO - maybe not correct being here. but I want to reset buffers when shaders recompiled.
        self.rebuild_passes(engine, device);
    }

    pub fn flush(&mut self, frame: lib::Frame, queue: &wgpu::Queue) {
        self.frame = frame;
        self.buffers.curr_camera.flush(queue);
        self.buffers.prev_camera.flush(queue);
        self.buffers.globals.flush(queue);
        self.buffers.config.flush(queue);
        self.buffers.materials.flush(queue);
        self.buffers.lights.flush(queue);
    }
}

impl Drop for CameraController {
    fn drop(&mut self) {
        info!("Deleting cameraRenderer `{}`", self.camera);
    }
}
