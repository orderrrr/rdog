use super::{
    buffers::Buffers,
    config::Camera,
    engine::Engine,
    passes::{self, Passes},
    Config,
};
use bevy::utils::default;
use log::info;
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

    pub fn render(
        &self,
        engine: &Engine,
        config: &Config,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        passes: &Passes,
        pass_params: Option<&[u8]>,
    ) {
        passes.run_all(engine, config, self, encoder, view, pass_params);
    }

    pub fn render_pass(
        &self,
        engine: &Engine,
        config: &Config,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_type: &str,
        passes: &Passes,
        pass_params: Option<&[u8]>,
    ) {
        if !passes.run_pass(pass_type, engine, config, self, encoder, view, pass_params) {
            log::warn!("Attempted to run unknown pass: {}", pass_type);
        }
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
