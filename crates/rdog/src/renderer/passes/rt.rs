use rdog_lib::PassParams;

use crate::{
    bindable::DoubleBufferedBindable,
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct RTPass([ComputePass<PassParams>; 3]);

impl RTPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let bindings: [&dyn DoubleBufferedBindable; 5] = [
            &buffers.curr_camera.bind_readable(),
            &buffers.globals.bind_readable(),
            &buffers.materials.bind_readable(),
            &buffers.atmosphere_tx.bind_sampled(),
            &buffers.render_tx.bind_writable(),
        ];

        // let trace_pass = ComputePass::builder("trace")
        //     .bind(bindings)
        //     .build(device, engine.shaders.get("trace_main").unwrap()); // TODO - proper error handling

        let direct_pass = ComputePass::builder("direct")
            .bind(bindings)
            .build(device, &engine.shaders.get("direct_main").unwrap());

        let scatter_pass = ComputePass::builder("scatter")
            .bind(bindings)
            .build(device, &engine.shaders.get("scatter_main").unwrap());

        let specular_pass = ComputePass::builder("specular")
            .bind(bindings)
            .build(device, &engine.shaders.get("specular_main").unwrap());

        Self([
            direct_pass,
            scatter_pass,
            specular_pass,
        ])
    }
}

impl Pass for RTPass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        pp: &PassParams,
    ) {
        // if engine.config.direct_pass {
        self.0[0].run(camera, encoder, camera.camera.viewport.size, *pp);
        // }
        // if engine.config.scatter_pass {
        self.0[1].run(camera, encoder, camera.camera.viewport.size, *pp);
        // }
        // if engine.config.specular_pass {
        self.0[2].run(camera, encoder, camera.camera.viewport.size, *pp);
        // }
    }
}
