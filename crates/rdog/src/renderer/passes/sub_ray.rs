use glam::uvec2;

use crate::{
    compute_pass::ComputePass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

use super::Pass;

#[derive(Debug)]
pub struct SubRayPass(ComputePass<()>);

impl SubRayPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let sub_ray_pass = ComputePass::builder("sub_ray")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.time.bind_readable(),
                &buffers.sub_ray.bind_writable(),
            ])
            // .bind([])
            .build(device, &engine.shaders.sub_ray);

        Self(sub_ray_pass)
    }
}

impl Pass for SubRayPass {
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
            uvec2(1080, 1080), // TODO fix this, share it with the actual texture creation
            (),
        );
    }
}
