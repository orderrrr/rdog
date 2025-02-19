use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct TracePass(Vec<ComputePass<()>>);

impl TracePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let direct_pass = ComputePass::builder("trace")
            .bind([
                &buffers.curr_camera.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.materials.bind_readable(),
                &buffers.lights.bind_readable(),
                &buffers.config.bind_readable(),
                &buffers.render_tx.bind_writable(),
            ])
            .bind([&buffers.voxels.bind_readable()])
            .build(device, "main", &engine.shaders.get("trace").unwrap().module);

        Self(vec![direct_pass])
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
        self.0[0].run(camera, encoder, camera.camera.viewport.size.extend(1), ());
    }
}
