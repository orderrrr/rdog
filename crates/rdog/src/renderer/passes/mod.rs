use bevy::utils::hashbrown::HashMap;
use log::debug;
use std::any::Any;

use crate::renderer::buffers::Buffers;
use crate::renderer::config::Camera;
use crate::renderer::engine::Engine;

use super::render::CameraController;
use super::Config;

#[macro_export]
macro_rules! define_pass_constructor {
    ($short_name:ident => $pass_type:ident) => {
        paste::paste! {
            #[derive(Debug, Clone)]
            pub struct [<$pass_type Constructor>];

            impl [<$pass_type Constructor>] {
                pub fn new() -> Self {
                    Self {}
                }
            }

            impl Default for [<$pass_type Constructor>] {
                fn default() -> Self {
                    Self::new()
                }
            }

            impl PassConstructor for [<$pass_type Constructor>] {
                fn name(&self) -> &str {
                    stringify!($short_name)
                }

                fn create(
                    &self,
                    engine: &Engine,
                    device: &wgpu::Device,
                    config: &Camera,
                    buffers: &Buffers,
                ) -> Box<dyn Pass> {
                    Box::new($pass_type::new(engine, device, config, buffers))
                }
            }
        }
    };
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
    );

    /// Returns the name of this pass
    fn name(&self) -> &str;

    /// Allows downcasting to concrete pass types
    fn as_any(&self) -> &dyn Any;
}

/// Registry for all available pass types
#[derive(Debug, Default)]
pub struct PassRegistry {
    constructors: HashMap<String, Box<dyn PassConstructor>>,
    pass_order: Vec<String>,
}

/// A trait for constructing passes
pub trait PassConstructor: std::fmt::Debug + Send + Sync {
    /// Get the name of the pass type this constructor creates
    fn name(&self) -> &str;

    /// Create a new pass instance
    fn create(
        &self,
        engine: &Engine,
        device: &wgpu::Device,
        config: &Camera,
        buffers: &Buffers,
    ) -> Box<dyn Pass>;
}

impl PassRegistry {
    /// Create a new empty pass registry
    pub fn new(constructor: Vec<Box<dyn PassConstructor>>, pass_order: Vec<String>) -> Self {
        let mut pr = PassRegistry::default();

        for p in constructor {
            pr.register(p);
        }

        pr.set_order(pass_order);

        pr
    }

    pub fn set_order(&mut self, order: Vec<String>) -> &mut Self {
        self.pass_order = order;
        self
    }

    /// Register a new pass constructor
    pub fn register(&mut self, constructor: Box<dyn PassConstructor>) -> &mut Self {
        let name = constructor.name().to_string();
        self.constructors.insert(name, constructor);
        self
    }

    /// Create a pass by name
    pub fn create(
        &self,
        name: &str,
        engine: &Engine,
        device: &wgpu::Device,
        config: &Camera,
        buffers: &Buffers,
    ) -> Option<Box<dyn Pass>> {
        self.constructors
            .get(name)
            .map(|constructor| constructor.create(engine, device, config, buffers))
    }
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

    /// Create passes from a registry with default configuration
    pub fn from_registry(
        registry: &PassRegistry,
        engine: &Engine,
        device: &wgpu::Device,
        config: &Camera,
        buffers: &Buffers,
    ) -> Self {
        debug!("Initializing camera passes from registry");
        let mut passes = HashMap::new();

        for c in &registry.constructors {
            if let Some(pass) = registry.create(&c.0, engine, device, config, buffers) {
                passes.insert(c.0.clone(), pass);
            }
        }

        Self {
            passes,
            pass_order: registry.pass_order.clone(),
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
    ) {
        for pass_name in &self.pass_order {
            if let Some(pass) = self.passes.get(pass_name) {
                pass.run(engine, config, camera, encoder, view);
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
    ) -> bool {
        if let Some(pass) = self.passes.get(name) {
            pass.run(engine, config, camera, encoder, view);
            true
        } else {
            false
        }
    }
}
