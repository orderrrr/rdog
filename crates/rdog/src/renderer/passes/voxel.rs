use glam::UVec3;

use crate::{
    compute_pass::ComputePass, passes::Pass, render::CameraController, renderer::buffers::Buffers,
    Camera, Engine,
};

#[derive(Debug)]
pub struct VoxelAccelPass(Vec<ComputePass<()>>);

impl VoxelAccelPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Self {
        let octree_pass = ComputePass::builder("voxel")
            .bind([
                &buffers.get("curr_camera").bind_readable(),
                &buffers.get("globals").bind_readable(),
                &buffers.get("config").bind_readable(),
            ])
            .bind([
                &buffers.get("materials").bind_readable(),
                &buffers.get("lights").bind_readable(),
            ])
            .bind([&buffers.get("voxels").bind_writable()])
            .build(
                device,
                &"main",
                &engine.shaders.get("voxel").unwrap().module,
            );

        Self(vec![octree_pass])
    }
}

impl Pass for VoxelAccelPass {
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
