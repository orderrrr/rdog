use bevy::log;
use rdog_lib::PassParams;
use rdog_shaders::atmosphere::{ATMOS_MULT, NOISE_DIM};

use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct AtmospherePass([ComputePass<PassParams>; 2]);

impl AtmospherePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let noise_pass = ComputePass::builder("noise")
            .bind([
                &buffers.globals.bind_readable(),
                &buffers.atmos_noise_tx.bind_writable(),
            ])
            .build(device, &engine.shaders.get("atmosphere_noise").unwrap());

        let atmosphere_pass = ComputePass::builder("atmosphere")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.atmos_noise_tx.bind_sampled(),
                &buffers.atmosphere_tx.bind_writable(),
            ])
            .build(
                device,
                &engine.shaders.get("atmosphere_atmosphere").unwrap(),
            );

        Self([noise_pass, atmosphere_pass])
    }
}

impl Pass for AtmospherePass {
    fn run(
        &self,
        engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        pp: &PassParams,
    ) {
        if camera.recompute_static {
            log::info!("Rocomputing atmosphere");
        }

        if camera.recompute_static || engine.config.realtime_atmosphere {
            self.0[0].run(camera, encoder, NOISE_DIM, *pp);

            self.0[1].run(
                camera,
                encoder,
                camera.camera.viewport.size * (ATMOS_MULT as u32),
                *pp,
            );
        }
    }
}
