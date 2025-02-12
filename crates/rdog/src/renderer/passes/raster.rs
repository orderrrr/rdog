use log::debug;
use rdog_lib::PassParams;
use wgpu::StoreOp;

use crate::{
    buffers::bind_group::BindGroup,
    renderer::{
        config::Camera,
        engine::Engine,
        render::{Buffers, CameraController},
    },
};

use super::Pass;

#[derive(Debug)]
pub struct RasterPass {
    bg0: BindGroup,
    bg1: BindGroup,
    pipeline: wgpu::RenderPipeline,
}

impl RasterPass {
    pub fn new(engine: &Engine, device: &wgpu::Device, config: &Camera, buffers: &Buffers) -> Self {
        debug!("Initializing pass: raster");

        let bg0 = BindGroup::builder("raster_bg0")
            .add(&buffers.config.bind_readable())
            .add(&buffers.curr_camera.bind_readable())
            .add(&buffers.globals.bind_readable())
            .build(device);

        let bg1 = BindGroup::builder("raster_bg1")
            .add(&buffers.render_tx.bind_readable())
            .build(device);

        let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: Some("rdog_raster_pipeline_layout"),
            bind_group_layouts: &[bg0.layout(), bg1.layout()],
            push_constant_ranges: &[],
        });

        let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
            label: Some("rdog_raster_pipeline"),
            layout: Some(&pipeline_layout),
            vertex: wgpu::VertexState {
                module: &engine.shaders.get("raster").unwrap().module, // TODO actually error handle.
                entry_point: Some("vs"),
                buffers: &[],
                compilation_options: wgpu::PipelineCompilationOptions::default(),
            },
            primitive: wgpu::PrimitiveState::default(),
            depth_stencil: None,
            multisample: wgpu::MultisampleState::default(),
            fragment: Some(wgpu::FragmentState {
                module: &engine.shaders.get("raster").unwrap().module,
                entry_point: Some("fs"),
                compilation_options: wgpu::PipelineCompilationOptions::default(),
                targets: &[Some(wgpu::ColorTargetState {
                    format: config.viewport.format,
                    blend: Some(wgpu::BlendState::REPLACE),
                    write_mask: wgpu::ColorWrites::ALL,
                })],
            }),
            multiview: None,
            cache: None,
        });

        Self { bg0, bg1, pipeline }
    }
}

impl Pass for RasterPass {
    fn run(
        &self,
        _engine: &Engine,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        _pp: &PassParams,
    ) {
        let alternate = camera.is_alternate();

        let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
            label: Some("rdog_raster"),
            color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                view,
                resolve_target: None,
                ops: wgpu::Operations {
                    load: wgpu::LoadOp::Load,
                    store: StoreOp::Store,
                },
            })],
            depth_stencil_attachment: None,
            timestamp_writes: None,
            occlusion_query_set: None,
        });

        pass.set_scissor_rect(
            camera.camera.viewport.position.x,
            camera.camera.viewport.position.y,
            camera.camera.viewport.size.x,
            camera.camera.viewport.size.y,
        );
        pass.set_pipeline(&self.pipeline);
        pass.set_bind_group(0, self.bg0.get(alternate), &[]);
        pass.set_bind_group(1, self.bg1.get(alternate), &[]);
        pass.draw(0..3, 0..1);
    }
}
