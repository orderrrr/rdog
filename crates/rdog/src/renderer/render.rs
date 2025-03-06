use super::{
    buffers::Buffers,
    config::Camera,
    engine::Engine,
    passes::{Pass, Passes},
};
use crate::{bufferable::Bufferable, Globals};
use bevy::utils::default;
use glam::Vec4;
use log::{debug, info};
use rdog_lib::{self as lib};

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
            frame: default(),
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

        self.camera = camera.clone();
        self.buffers.update(
            "prev_camera",
            (self.buffers.get("curr_camera").data()).into(),
        );
        self.buffers
            .update("curr_camera", self.camera.serialize().data().into());
        self.buffers.update(
            "globals",
            Globals::from_engine(engine).serialize().data().into(),
        );
        self.buffers
            .update("config", engine.config.to_pass_params().data().into());
        self.buffers
            .update("march_readback", Vec4::ZERO.data().into());

        if engine.config.material_tree.modified {
            self.buffers
                .update("materials", engine.config.material_pass().data().into());
        }

        if engine.config.light_tree.modified {
            self.buffers
                .update("lights", engine.config.light_pass().data().into());
        }

        if engine.config.reload {
            log::info!("Reloaded");
            self.rebuild_buffers(engine, device);
            self.rebuild_passes(engine, device);
            return;
        }

        if engine.config.material_tree.list_changed {
            log::info!("Material tree changed.");
            // Use our new smart update method that handles buffer resizing
            self.buffers.update_storage(
                "materials",
                device,
                "materials",
                engine.config.material_pass(),
            );
            self.rebuild_passes(engine, device);
            return;
        }

        if engine.config.light_tree.list_changed {
            log::info!("Light tree changed.");
            // Use our new smart update method that handles buffer resizing
            self.buffers
                .update_storage("lights", device, "lights", engine.config.light_pass());
            self.rebuild_passes(engine, device);
            return;
        }

        self.recompute_static = false;

        if is_invalidated {
            self.recompute_static = true;
            self.rebuild_buffers(engine, device);
            self.rebuild_passes(engine, device);
        }
    }

    pub(crate) fn rebuild_buffers(&mut self, engine: &Engine, device: &wgpu::Device) {
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
        self.passes
            .get("voxel")
            .unwrap()
            .run(engine, self, encoder, view);
        self.passes
            .get("trace")
            .unwrap()
            .run(engine, self, encoder, view);
        self.passes
            .get("raster")
            .unwrap()
            .run(engine, self, encoder, view);
    }

    pub fn render_pass(
        &self,
        engine: &Engine,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_type: &str,
    ) {
        self.passes
            .get(pass_type)
            .unwrap()
            .run(engine, self, encoder, view);
    }

    pub fn invalidate(&mut self, engine: &Engine, device: &wgpu::Device) {
        self.recompute_static = true;
        self.rebuild_passes(engine, device);
    }

    pub fn flush(&mut self, frame: lib::Frame, queue: &wgpu::Queue) {
        self.frame = frame;
        self.buffers.get_mut("curr_camera").flush(queue);
        self.buffers.get_mut("prev_camera").flush(queue);
        self.buffers.get_mut("globals").flush(queue);
        self.buffers.get_mut("config").flush(queue);
        self.buffers.get_mut("march_readback").flush(queue);
        self.buffers.get_mut("materials").flush(queue);
        self.buffers.get_mut("lights").flush(queue);
    }
}

impl Drop for CameraController {
    fn drop(&mut self) {
        info!("Deleting cameraRenderer `{}`", self.camera);
    }
}
