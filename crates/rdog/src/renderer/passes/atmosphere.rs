use glam::uvec2;
use rdog_shaders::atmosphere::SIZE;

use crate::{
    compute_pass::ComputePass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

use super::Pass;

#[derive(Debug)]
pub struct AtmospherePass(ComputePass<()>);

impl AtmospherePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let atmosphere_pass = ComputePass::builder("atmosphere")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.time.bind_readable(),
                &buffers.atmosphere.bind_writable(),
            ])
            // .bind([])
            .build(device, &engine.shaders.atmosphere);

        Self(atmosphere_pass)
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
        self.0.run(
            camera,
            encoder,
            uvec2(SIZE, SIZE * SIZE), // TODO fix this, share it with the actual texture creation
            (),
        );
    }
}
