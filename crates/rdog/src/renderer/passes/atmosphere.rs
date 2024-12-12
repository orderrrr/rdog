use bevy::utils::HashMap;
use rdog_shaders::atmosphere::{atmosphere::ATMOS_MULT, noise::NOISE_DIM};

use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct AtmospherePass(HashMap<u32, ComputePass<()>>);

impl AtmospherePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let noise_pass = ComputePass::builder("noise")
            .bind([
                &buffers.globals.bind_readable(),
                &buffers.atmos_noise.bind_writable(),
            ])
            .build(device, &engine.shaders.atmosphere_noise);

        let atmosphere_pass = ComputePass::builder("atmosphere")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.atmos_noise.bind_sampled(),
                &buffers.atmosphere.bind_writable(),
            ])
            .build(device, &engine.shaders.atmosphere_atmosphere);

        let mut map = HashMap::new();

        map.insert(0, noise_pass);
        map.insert(1, atmosphere_pass);

        Self(map)
    }
}

impl Pass for AtmospherePass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
    ) {
        if _engine.frame.get() < 5 {
            self.0.get(&0).unwrap().run(camera, encoder, NOISE_DIM, ());
        }
        if _engine.frame.get() < 5 {
            self.0.get(&1).unwrap().run(
                camera,
                encoder,
                camera.camera.viewport.size * (ATMOS_MULT as u32),
                (),
            );
        }
    }
}