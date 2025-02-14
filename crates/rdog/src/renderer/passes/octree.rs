use glam::UVec3;
use rdog_lib::PassParams;

use crate::{
    bindable::DoubleBufferedBindable,
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct OCTreePass([ComputePass<()>; 1]);

impl OCTreePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let bindings: [&dyn DoubleBufferedBindable; 3] = [
            &buffers.config.bind_readable(),
            &buffers.globals.bind_readable(),
            &buffers.octrees.bind_writable(),
        ];

        // let trace_pass = ComputePass::builder("trace")
        //     .bind(bindings)
        //     .build(device, engine.shaders.get("trace_main").unwrap()); // TODO - proper error handling

        // let octree_pass = ComputePass::builder("octree").bind(bindings).build(
        //     device,
        //     &"main",
        //     &engine.shaders.get("octree").unwrap().module,
        // );

        let octree_pass = ComputePass::builder("octree").bind(bindings).build(
            device,
            &"main",
            &engine.shaders.get("octree").unwrap().module,
        );
        // .build(device, &engine.shaders.get("combined_main").unwrap());

        Self([octree_pass])
    }
}

impl Pass for OCTreePass {
    fn run(
        &self,
        engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        _pp: &PassParams,
    ) {
        if camera.recompute_static {
            self.0[0].run(camera, encoder, UVec3::splat(engine.config.octree_dim), ());
        }
    }
}
