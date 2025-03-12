use log::debug;

use std::{
    mem,
    ops::{Deref, DerefMut},
    sync::Arc,
};

use crate::renderer::utils;

use super::{bindable::Bindable, bufferable::Bufferable};

#[derive(Debug)]
pub struct MappedUniformBuffer {
    pub buffer: Arc<wgpu::Buffer>,
    data: Vec<u8>,
    dirty: bool,
}

impl MappedUniformBuffer {
    pub fn new(device: &wgpu::Device, label: impl AsRef<str>, data: Vec<u8>) -> Self {
        let label = format!("rdog_{}", label.as_ref());
        let size = utils::pad_size(data.len() * size_of::<u8>());

        debug!("Allocating uniform buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(&label),
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::UNIFORM,
            size: size as _,
            mapped_at_creation: false,
        });

        Self {
            buffer: Arc::new(buffer),
            data: data.data().into(),
            dirty: true,
        }
    }

    pub fn flush(&mut self, queue: &wgpu::Queue) {
        if !mem::take(&mut self.dirty) {
            return;
        }

        queue.write_buffer(&self.buffer, 0, self.data.data());
    }

    /// Creates an immutable uniform binding:
    ///
    /// ```
    /// // #[spirv(descriptor_set = ..., binding = ..., uniform)]
    /// // item: &T,
    /// ```
    pub fn bind_readable(&self) -> impl Bindable + '_ {
        MappedUniformBufferBinder { parent: self }
    }
}

impl Deref for MappedUniformBuffer {
    type Target = Vec<u8>;

    fn deref(&self) -> &Self::Target {
        &self.data
    }
}

impl DerefMut for MappedUniformBuffer {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.dirty = true;

        &mut self.data
    }
}

pub struct MappedUniformBufferBinder<'a> {
    parent: &'a MappedUniformBuffer,
}

impl Bindable for MappedUniformBufferBinder<'_> {
    fn bind(&self, binding: u32) -> Vec<(wgpu::BindGroupLayoutEntry, wgpu::BindingResource)> {
        let layout = wgpu::BindGroupLayoutEntry {
            binding,
            visibility: wgpu::ShaderStages::all(),
            ty: wgpu::BindingType::Buffer {
                ty: wgpu::BufferBindingType::Uniform,
                has_dynamic_offset: false,
                min_binding_size: None,
            },
            count: None,
        };

        let resource = self.parent.buffer.as_entire_binding();

        vec![(layout, resource)]
    }
}
