use log::debug;
use ray::RayPass;

use crate::renderer::config::Camera;
use crate::renderer::engine::Engine;
use crate::renderer::render::Buffers;

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

        #[derive(Debug)]
        pub struct Passes(pub Vec<PassTypes>);

        impl Passes {
            pub fn new(
                engine: &Engine,
                device: &wgpu::Device,
                config: &Camera,
                buffers: &Buffers,
            ) -> Self {
                debug!("Initializing camera passes");
                let mut passes = Vec::new();
                $(
                    passes.push(
                        PassTypes::$class($class::new(engine, device, config, buffers))
                    );
                )*
                Passes(passes)
            }
        }
    };
}

passes!([
    atmosphere => AtmospherePass,
    // sub_ray => SubRayPass,
    ray => RayPass,
]);
