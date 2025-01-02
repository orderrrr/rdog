use rdog_lib::PassParams;

use crate::{
    bindable::DoubleBufferedBindable,
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct TestingPass([ComputePass<()>; 3]);

impl TestingPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let bindings: [&dyn DoubleBufferedBindable; 3] = [
            &buffers.curr_camera.bind_readable(),
            &buffers.globals.bind_readable(),
            &buffers.render_tx.bind_writable(),
        ];

        let trace_pass = ComputePass::builder("trace")
            .bind(bindings)
            .build(device, &engine.shaders.z_trace);

        let gaussian_pass = ComputePass::builder("gaussian")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.render_tx.bind_sampled(),
                &buffers.render_alt_tx.bind_writable(),
            ])
            .build(device, &engine.shaders.z_gaussian);

        let motion_pass = ComputePass::builder("motion")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.render_alt_tx.bind_sampled(),
                &buffers.render_tx.bind_writable(),
            ])
            .build(device, &engine.shaders.z_motion);

        Self([trace_pass, gaussian_pass, motion_pass])
    }
}

impl Pass for TestingPass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        _pp: &PassParams,
    ) {
        self.0[0].run(camera, encoder, camera.camera.viewport.size, ());
        self.0[1].run(camera, encoder, camera.camera.viewport.size, ());
        self.0[2].run(camera, encoder, camera.camera.viewport.size, ());
    }
}
