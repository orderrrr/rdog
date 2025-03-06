use crate::{
    compute_pass::ComputePass, passes::Pass, render::CameraController, renderer::buffers::Buffers,
    Camera, Engine,
};

#[derive(Debug)]
pub struct TracePass(Vec<ComputePass<()>>);

impl TracePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let direct_pass = ComputePass::builder("trace")
            .bind([
                &buffers.get("curr_camera").bind_readable(),
                &buffers.get("globals").bind_readable(),
                &buffers.get("config").bind_readable(),
                &buffers.get("march_readback").bind_readable(),
                &buffers.get("render_tx").bind_writable(),
            ])
            .bind([
                &buffers.get("materials").bind_readable(),
                &buffers.get("lights").bind_readable(),
            ])
            .bind([&buffers.get("voxels").bind_readable()])
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
