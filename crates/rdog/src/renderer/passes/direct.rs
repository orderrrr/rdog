use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct DirectPass(ComputePass<()>);

impl DirectPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let direct_pass = ComputePass::builder("direct")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.trace_tx.bind_writable(),
            ])
            .build(device, &engine.shaders.direct);

        Self(direct_pass)
    }
}

impl Pass for DirectPass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
    ) {
        self.0.run(camera, encoder, camera.camera.viewport.size, ());
    }
}
