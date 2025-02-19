use glam::UVec3;

use crate::{
    compute_pass::ComputePass,
    passes::Pass,
    render::{Buffers, CameraController},
    Camera, Engine,
};

#[derive(Debug)]
pub struct OCTreePass(Vec<ComputePass<()>>);

impl OCTreePass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let octree_pass = ComputePass::builder("octree")
            .bind([
                &buffers.config.bind_readable(),
                &buffers.globals.bind_readable(),
                &buffers.voxels.bind_writable(),
            ])
            .build(
                device,
                &"main",
                &engine.shaders.get("octree").unwrap().module,
            );

        Self(vec![octree_pass])
    }
}

impl Pass for OCTreePass {
    fn run(
        &self,
        e: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
    ) {
        self.0[0].run(camera, encoder, UVec3::splat(e.config.voxel_dim), ());
    }
}
