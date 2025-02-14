use rdog_lib::PassParams;

use crate::{
    bindable::DoubleBufferedBindable,
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct TracePass([ComputePass<()>; 1]);

impl TracePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let bindings: [&dyn DoubleBufferedBindable; 6] = [
            &buffers.curr_camera.bind_readable(),
            &buffers.globals.bind_readable(),
            &buffers.materials.bind_readable(),
            &buffers.lights.bind_readable(),
            &buffers.config.bind_readable(),
            // &buffers.atmosphere_tx.bind_sampled(),
            &buffers.render_tx.bind_writable(),
        ];

        // let trace_pass = ComputePass::builder("trace")
        //     .bind(bindings)
        //     .build(device, engine.shaders.get("trace_main").unwrap()); // TODO - proper error handling

        let direct_pass = ComputePass::builder("trace")
            .bind(bindings)
            .bind([&buffers.octrees.bind_readable()])
            .build(device, "main", &engine.shaders.get("trace").unwrap().module);
        // .build(device, &engine.shaders.get("combined_main").unwrap());

        Self([direct_pass])
    }
}

impl Pass for TracePass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        _pp: &PassParams,
    ) {
        self.0[0].run(camera, encoder, camera.camera.viewport.size.extend(1), ());
    }
}
