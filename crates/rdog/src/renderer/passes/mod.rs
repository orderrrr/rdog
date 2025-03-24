use super::buffers::Buffers;
use super::render::CameraController;
use super::{Camera, Config};
use crate::renderer::engine::Engine;
use bevy::log::info;
use std::any::Any;
use std::collections::HashMap;

pub trait PassConstruct {
    fn new(
        engine: &Engine,
        device: &wgpu::Device,
        camera: &Camera,
        buffers: &Buffers,
    ) -> Box<dyn Pass>;
}

/// Base trait for all rendering passes
pub trait Pass: std::fmt::Debug + Any + Send + Sync {
    fn run(
        &self,
        engine: &Engine,
        config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_params: Option<&Vec<u8>>,
    );

    /// Returns the name of this pass
    fn name(&self) -> &str;
}

/// Collection of constructed passes for a camera
#[derive(Debug)]
pub struct Passes {
    pub passes: HashMap<String, Box<dyn Pass>>,
    /// The order in which passes should be executed by default
    pub pass_order: Vec<String>,
}

impl Passes {
    /// Create a new empty passes collection
    pub fn new() -> Self {
        Self {
            passes: HashMap::new(),
            pass_order: Vec::new(),
        }
    }

    /// Get a pass by name
    pub fn get_pass(&self, name: &str) -> Option<&dyn Pass> {
        self.passes.get(name).map(|p| p.as_ref())
    }

    /// Run all passes in the default order
    pub fn run_all(
        &self,
        engine: &Engine,
        config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_params: Option<&Vec<u8>>,
    ) {
        for pass_name in &self.pass_order {
            if let Some(pass) = self.passes.get(pass_name) {
                pass.run(engine, config, camera, encoder, view, pass_params);
            }
        }
    }

    /// Run a specific pass by name
    pub fn run_pass(
        &self,
        name: &str,
        engine: &Engine,
        config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        pass_params: Option<&Vec<u8>>,
    ) {
        let Some(pass) = self.passes.get(name) else {
            info!("could not run pass: {name}");
            return;
        };

        info!("run pass: {name}");
        pass.run(engine, config, camera, encoder, view, pass_params);
    }

    pub fn insert_pass(&mut self, buf: Box<dyn Pass>) {
        self.passes.insert(buf.name().to_string(), buf);
    }

    pub fn set_pass_order(&mut self, passes: Vec<&Box<dyn Pass>>) {
        self.pass_order = passes.iter().map(|b| b.name().to_string()).collect();
    }

    pub fn insert_all(&mut self, vec: Vec<Box<dyn Pass>>) {
        for p in vec {
            self.passes.insert(p.name().to_string(), p);
        }
    }
}
