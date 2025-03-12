use super::{
    buffers::Buffers,
    config::Camera,
    engine::Engine,
    passes::{PassRegistry, Passes},
};
use crate::{bufferable::Bufferable, Globals};
use bevy::utils::default;
use glam::Vec4;
use log::{debug, info};
use rdog_lib::{self as lib};

#[derive(Debug)]
pub struct CameraController {
    pub camera: Camera, // TODO camera impl
    // pub passes: Passes,
    pub frame: lib::Frame,
    pub recompute_static: bool,
}

impl CameraController {
    pub(crate) fn new(camera: Camera) -> Self {
        info!("creating camera `{}`", camera);
        Self {
            camera,
            frame: default(),
            recompute_static: true,
        }
    }

    /// Returns whether the current frame should use the first or the second
    /// resource when given resource is double-buffered.
    pub fn is_alternate(&self) -> bool {
        self.frame.get() % 2 == 1
    }

    pub fn update(
        &mut self,
        engine: &Engine,
        device: &wgpu::Device,
        camera: Camera,
        buffers: &mut Buffers,
        passes: &mut Passes,
        registry: &PassRegistry,
    ) {
        self.camera = camera.clone();
        buffers.update(
            "curr_camera",
            self.camera.serialize(&engine.config).data().into(),
        );
        buffers.update(
            "globals",
            Globals::from_engine(engine, &camera)
                .serialize()
                .data()
                .into(),
        );
        buffers.update("config", engine.config.to_pass_params().data().into());
        buffers.update("march_readback", Vec4::ZERO.data().into());

        if engine.config.material_tree.modified {
            buffers.update("materials", engine.config.material_pass().data().into());
        }

        if engine.config.light_tree.modified {
            buffers.update("lights", engine.config.light_pass().data().into());
        }

        if engine.config.material_tree.list_changed {
            log::info!("Material tree changed.");
            // Use our new smart update method that handles buffer resizing
            buffers.update_storage(
                "materials",
                device,
                "materials",
                engine.config.material_pass(),
            );
            self.rebuild_passes(engine, device, buffers, passes, registry);
            return;
        }

        if engine.config.light_tree.list_changed {
            log::info!("Light tree changed.");
            // Use our new smart update method that handles buffer resizing
            buffers.update_storage("lights", device, "lights", engine.config.light_pass());
            self.rebuild_passes(engine, device, buffers, passes, registry);
            return;
        }
    }

    fn rebuild_passes(
        &mut self,
        engine: &Engine,
        device: &wgpu::Device,
        buffers: &Buffers,
        passes: &mut Passes,
        registry: &PassRegistry,
    ) {
        debug!("Rebuilding passes for camera `{}`", self.camera);
        *passes = Passes::from_registry(&registry, engine, device, &self.camera, &buffers);
    }

    pub fn render(
        &self,
        engine: &Engine,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        passes: &Passes,
    ) {
        passes.run_all(engine, self, encoder, view);
    }

    pub fn render_pass(
        &self,
        engine: &Engine,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_type: &str,
        passes: &Passes,
    ) {
        if !passes.run_pass(pass_type, engine, self, encoder, view) {
            log::warn!("Attempted to run unknown pass: {}", pass_type);
        }
    }

    pub fn invalidate(
        &mut self,
        engine: &Engine,
        device: &wgpu::Device,
        buffers: &Buffers,
        passes: &mut Passes,
        registry: &PassRegistry,
    ) {
        self.recompute_static = true;
        self.rebuild_passes(engine, device, buffers, passes, registry);
    }

    pub fn flush(&mut self, frame: lib::Frame, queue: &wgpu::Queue, buffers: &mut Buffers) {
        self.frame = frame;
        for buffer in buffers.values_mut() {
            buffer.flush(queue);
        }
    }
}

impl Drop for CameraController {
    fn drop(&mut self) {
        info!("Deleting cameraRenderer `{}`", self.camera);
    }
}
