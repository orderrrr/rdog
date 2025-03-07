use glam::UVec3;

use crate::{
    compute_pass::ComputePass, passes::Pass, render::CameraController, renderer::buffers::Buffers,
    Camera, Engine,
};

#[derive(Debug)]
pub struct ReadbackPass(Vec<ComputePass<()>>);

impl ReadbackPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let readback_mouse = ComputePass::builder("readback")
            .bind([
                &buffers.get("curr_camera").bind_readable(),
                &buffers.get("globals").bind_readable(),
                &buffers.get("config").bind_readable(),
                &buffers.get("march_readback").bind_writable(),
            ])
            .bind([
                &buffers.get("materials").bind_readable(),
                &buffers.get("lights").bind_readable(),
            ])
            .build(
                device,
                &"read_mouse",
                &engine.shaders.get("readback").unwrap().module,
            );

        Self(vec![readback_mouse])
    }
}

impl Pass for ReadbackPass {
    fn run(
        &self,
        _e: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
    ) {
        self.0[0].run(camera, encoder, UVec3::ONE, ());
    }
}
