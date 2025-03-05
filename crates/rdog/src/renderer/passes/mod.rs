use log::debug;

use crate::renderer::buffers::Buffers;
use crate::renderer::config::Camera;
use crate::renderer::engine::Engine;

use super::render::CameraController;

pub trait Pass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
    );
}

macro_rules! passes {
    ([ $( $name:ident => $class:ident, )* ]) => {
        use bevy::utils::HashMap;
        use bevy::prelude::{Deref, DerefMut};

        $( mod $name; )*
        $(  #[allow(unused_imports)]
            pub use self::$name::*; )*

        #[derive(Debug)]
        pub enum PassTypes {
            $( $class($class), )*
        }

        impl Pass for PassTypes {
            fn run(
                &self,
                engine: &Engine,
                camera: &CameraController,
                encoder: &mut wgpu::CommandEncoder,
                view: &wgpu::TextureView,
            ) {
                match self {
                    $( PassTypes::$class(pass) => pass.run(engine, camera, encoder, view), )*
                }
            }
        }

        #[derive(Debug, Deref, DerefMut)]
        pub struct Passes(pub HashMap<String, PassTypes>);

        impl Passes {
            pub fn new(
                engine: &Engine,
                device: &wgpu::Device,
                config: &Camera,
                buffers: &Buffers,
            ) -> Self {
                debug!("Initializing camera passes");
                let mut passes: HashMap<String, PassTypes> = HashMap::new();

                $(
                    passes.insert(
                        stringify!($name).to_string(),
                        PassTypes::$class($class::new(engine, device, config, buffers))
                    );
                )*
                Passes(passes)
            }
        }
    };
}

passes!([
    // atmosphere => AtmospherePass,
    octree => OCTreePass,
    readback => ReadbackPass,
    trace => TracePass,
    raster => RasterPass,
]);
