use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct TracePass(ComputePass<()>);

impl TracePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let trace_pass = ComputePass::builder("trace")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.trace_tx.bind_writable(),
            ])
            .build(device, &engine.shaders.trace);

        Self(trace_pass)
    }
}

impl Pass for TracePass {
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
