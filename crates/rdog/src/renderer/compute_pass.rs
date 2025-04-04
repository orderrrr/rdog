use std::marker::PhantomData;

use bevy::utils::default;
use bytemuck::Pod;
use glam::UVec3;
use log::debug;
use rdog_lib::PassParams;
use wgpu::{PipelineCompilationOptions, ShaderModule};

use super::{buffers::{bind_group::{BindGroup, BindGroupBuilder}, bindable::DoubleBufferedBindable}, render::CameraController};

#[derive(Debug)]
pub struct ComputePass<P = PassParams> {
    label: String,
    bind_groups: Vec<BindGroup>,
    pipeline: wgpu::ComputePipeline,
    _params: PhantomData<P>,
}

impl<P> ComputePass<P>
where
    P: Pod,
{
    pub fn builder<'a>(label: impl ToString) -> CameraPassBuilder<'a, P> {
        CameraPassBuilder {
            label: label.to_string(),
            bind_groups: default(),
            _params: default(),
        }
    }

    pub fn run(
        &self,
        camera: &CameraController,
        encoder: &mut wgpu::CommandEncoder,
        size: UVec3,
        params: Option<&Vec<u8>>,
    ) {
        let label = format!("rdog_{}_pass", self.label);

        let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
            label: Some(&label),
            timestamp_writes: None,
        });

        pass.set_pipeline(&self.pipeline);

        if params.is_some() {
            pass.set_push_constants(0, params.unwrap());
        }

        for (bind_group_idx, bind_group) in self.bind_groups.iter().enumerate() {
            pass.set_bind_group(
                bind_group_idx as u32,
                bind_group.get(camera.is_alternate()),
                &[],
            );
        }

        pass.dispatch_workgroups(size.x, size.y, size.z);
    }
}

pub struct CameraPassBuilder<'a, P> {
    label: String,
    bind_groups: Vec<BindGroupBuilder<'a>>,
    _params: PhantomData<P>,
}

impl<'a, P> CameraPassBuilder<'a, P>
where
    P: Pod,
{
    pub fn bind<const N: usize>(mut self, items: [&'a dyn DoubleBufferedBindable; N]) -> Self {
        let mut bind_group =
            BindGroup::builder(format!("{}_bg{}", self.label, self.bind_groups.len()));

        for item in items {
            bind_group = bind_group.add(item);
        }

        self.bind_groups.push(bind_group);
        self
    }

    pub fn build(
        self,
        device: &wgpu::Device,
        entry_point: &str,
        module: &ShaderModule,
    ) -> ComputePass<P> {
        debug!("Initializing pass: {}:{}", self.label, entry_point);

        let bind_groups: Vec<_> = self
            .bind_groups
            .into_iter()
            .map(|bg| bg.build(device))
            .collect();

        let bind_group_layouts: Vec<_> = bind_groups.iter().map(|bg| bg.layout()).collect();

        let push_constant_ranges = if size_of::<P>() > 0 {
            vec![wgpu::PushConstantRange {
                stages: wgpu::ShaderStages::COMPUTE,
                range: 0..size_of::<P>() as u32,
            }]
        } else {
            vec![]
        };

        let pipeline_layout_label = format!("rdog_{}_pipeline_layout", self.label);

        let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: Some(&pipeline_layout_label),
            bind_group_layouts: &bind_group_layouts,
            push_constant_ranges: &push_constant_ranges,
        });

        let pipeline_label = format!("rdog_{}_pipeline", self.label);

        let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
            label: Some(&pipeline_label),
            layout: Some(&pipeline_layout),
            module,
            entry_point: Some(&entry_point),
            compilation_options: PipelineCompilationOptions::default(),
            cache: None,
        });

        ComputePass {
            label: self.label,
            bind_groups,
            pipeline,
            _params: PhantomData,
        }
    }
}
