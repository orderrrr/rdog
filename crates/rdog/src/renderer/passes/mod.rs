use log::debug;
use rdog_lib::PassParams;

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
        pp: &PassParams,
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
                pp: &PassParams,
            ) {
                match self {
                    $( PassTypes::$class(pass) => pass.run(engine, camera, encoder, view, pp), )*
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

#[cfg(feature = "combined")]
passes!([
    // atmosphere => AtmospherePass,
    rt_single => RTSingle,
    raster => RasterPass,
]);

#[cfg(not(feature = "combined"))]
passes!([
    atmosphere => AtmospherePass,
    rt => RTPass,
    raster => RasterPass,
]);
