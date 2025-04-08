use bevy::log::{debug, info};
use glam::UVec3;
use rdog::{
    passes::PassConstruct,
    renderer::{
        buffers::{bind_group::BindGroup, Buffers},
        compute_pass::ComputePass,
        config::Camera,
        passes::Pass,
        render::CameraController,
    },
    Config, Engine,
};
use rdog_lib::OutputParams;
use wgpu::StoreOp;

#[derive(Debug)]
pub struct RasterPass {
    name: String,
    bg0: BindGroup,
    bg1: BindGroup,
    pipeline: wgpu::RenderPipeline,
}

impl PassConstruct for RasterPass {
    fn new(
        engine: &Engine,
        device: &wgpu::Device,
        config: &Camera,
        buffers: &Buffers,
    ) -> Box<dyn Pass> {
        debug!("Initializing pass: raster");

        let bg0 = BindGroup::builder("raster_bg0")
            .add(&buffers.get_old("config").bind_readable())
            .add(&buffers.get_old("curr_camera").bind_readable())
            .add(&buffers.get_old("globals").bind_readable())
            .build(device);

        let bg1 = BindGroup::builder("raster_bg1")
            .add(&buffers.get_old("render_tx").bind_sampled())
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

        Box::new(Self {
            name: "raster".to_string(),
            bg0,
            bg1,
            pipeline,
        })
    }
}

impl Pass for RasterPass {
    fn run(
        &self,
        _engine: &Engine,
        _config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        view: &wgpu::TextureView,
        _pass_params: Option<&Vec<u8>>,
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

    fn name(&self) -> &str {
        &self.name
    }
}

#[derive(Debug)]
pub struct ReadbackPass {
    name: String,
    compute_passes: Vec<ComputePass>,
}

impl PassConstruct for ReadbackPass {
    fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Box<dyn Pass> {
        let readback_mouse = ComputePass::builder("readback")
            .bind([
                &buffers.get_old("curr_camera").bind_readable(),
                &buffers.get_old("globals").bind_readable(),
                &buffers.get_old("config").bind_readable(),
                &buffers.get_old("march_readback").bind_writable(),
            ])
            .bind([
                &buffers.get_old("materials").bind_readable(),
                &buffers.get_old("lights").bind_readable(),
            ])
            .build(
                device,
                &"read_mouse",
                &engine.shaders.get("readback").unwrap().module,
            );

        Box::new(Self {
            name: "readback".to_string(),
            compute_passes: vec![readback_mouse],
        })
    }
}

impl Pass for ReadbackPass {
    fn run(
        &self,
        _e: &Engine,
        _config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        pass_params: Option<&Vec<u8>>,
    ) {
        self.compute_passes[0].run(camera, encoder, UVec3::ONE, pass_params);
    }

    fn name(&self) -> &str {
        &self.name
    }
}

#[derive(Debug)]
pub struct TracePass {
    name: String,
    compute_passes: Vec<ComputePass>,
}

impl PassConstruct for TracePass {
    fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Box<dyn Pass> {
        let direct_pass = ComputePass::builder("trace")
            .bind([
                &buffers.get_old("curr_camera").bind_readable(),
                &buffers.get_old("globals").bind_readable(),
                &buffers.get_old("config").bind_readable(),
                &buffers.get_old("march_readback").bind_readable(),
                &buffers.get_old("render_tx").bind_writable(),
            ])
            .bind([
                &buffers.get_old("materials").bind_readable(),
                &buffers.get_old("lights").bind_readable(),
            ])
            .bind([])
            .build(
                device,
                "main",
                &engine.shaders.get("sphere_trace").unwrap().module,
            );

        Box::new(Self {
            name: "trace".to_string(),
            compute_passes: vec![direct_pass],
        })
    }
}

impl Pass for TracePass {
    fn run(
        &self,
        _engine: &Engine,
        config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        _pass_params: Option<&Vec<u8>>,
    ) {
        self.compute_passes[0].run(
            camera,
            encoder,
            (camera.camera.viewport.size.as_vec2() * config.res)
                .as_uvec2()
                .extend(1),
            None,
        );
    }

    fn name(&self) -> &str {
        &self.name
    }
}

#[derive(Debug)]
pub struct OutputTracePass {
    name: String,
    compute_passes: Vec<ComputePass<OutputParams>>,
}

impl PassConstruct for OutputTracePass {
    fn new(engine: &Engine, device: &wgpu::Device, _: &Camera, buffers: &Buffers) -> Box<dyn Pass> {
        let direct_pass = ComputePass::builder("output_trace")
            .bind([
                &buffers.get_old("out_camera").bind_readable(),
                &buffers.get_old("globals").bind_readable(),
                &buffers.get_old("out_config").bind_readable(),
                &buffers.get_old("march_readback").bind_readable(),
                &buffers.get_old("render_readback").bind_writable(),
            ])
            .bind([
                &buffers.get_old("materials").bind_readable(),
                &buffers.get_old("lights").bind_readable(),
            ])
            .bind([
                &buffers.get_old("voxel_depth").bind_readable(),
                &buffers.get_old("voxel_data").bind_readable(),
            ])
            .build(
                device,
                "main",
                &engine.shaders.get("readback_trace").unwrap().module,
            );

        Box::new(Self {
            name: "output_trace".to_string(),
            compute_passes: vec![direct_pass],
        })
    }
}

impl Pass for OutputTracePass {
    fn run(
        &self,
        _engine: &Engine,
        config: &Config,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        _view: &wgpu::TextureView,
        pass_params: Option<&Vec<u8>>,
    ) {
        info!("running trace output");

        self.compute_passes[0].run(
            camera,
            encoder,
            config.compute_pass_size().extend(1),
            pass_params,
        );
    }

    fn name(&self) -> &str {
        &self.name
    }
}
