use bevy::utils::default;

use super::bindable::DoubleBufferedBindable;

#[derive(Debug)]
pub struct BindGroup {
    bind_group_a: wgpu::BindGroup,
    bind_group_layout: wgpu::BindGroupLayout,
}

impl BindGroup {
    pub fn builder<'ctx>(label: impl ToString) -> BindGroupBuilder<'ctx> {
        BindGroupBuilder {
            label: label.to_string(),
            layouts: default(),
            resources: default(),
        }
    }

    pub fn get(&self, _alternate: bool) -> &wgpu::BindGroup {
        &self.bind_group_a
    }

    pub fn layout(&self) -> &wgpu::BindGroupLayout {
        &self.bind_group_layout
    }
}

pub struct BindGroupBuilder<'a> {
    label: String,
    layouts: Vec<wgpu::BindGroupLayoutEntry>,
    resources: Vec<[wgpu::BindingResource<'a>; 2]>,
}

impl<'a> BindGroupBuilder<'a> {
    pub fn add(mut self, item: &'a dyn DoubleBufferedBindable) -> Self {
        for (layout, resources) in item.bind(self.resources.len() as u32) {
            self.layouts.push(layout);
            self.resources.push(resources);
        }

        self
    }

    pub fn build(self, device: &wgpu::Device) -> BindGroup {
        let label = format!("rdog_{}", self.label);

        let bind_group_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
            label: Some(&format!("{label}_layout")),
            entries: &self.layouts,
        });

        let (resources_a, _resources_b): (Vec<_>, Vec<_>) = self
            .resources
            .into_iter()
            .enumerate()
            .map(|(binding, resources)| {
                let [resource_a, resource_b] = resources.map(|resource| wgpu::BindGroupEntry {
                    binding: binding as _,
                    resource,
                });

                #[allow(
                    clippy::tuple_array_conversions,
                    reason = "https://github.com/rust-lang/rust-clippy/issues/11144"
                )]
                (resource_a, resource_b)
            })
            .unzip();

        let bind_group_a = device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: Some(&label),
            layout: &bind_group_layout,
            entries: &resources_a,
        });

        BindGroup {
            bind_group_a,
            bind_group_layout,
        }
    }
}
