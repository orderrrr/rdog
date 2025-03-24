use std::sync::Arc;

use bevy::{log::debug, utils::default};

use crate::{bufferable::Bufferable, mapped_uniform_buffer::MappedUniformBuffer, utils};

use super::storage_buffer::StorageBuffer;

#[derive(Clone, Default)]
pub struct BufferBuilder {
    label: String,
    data: Option<Vec<u8>>,
    usage: Option<wgpu::BufferUsages>,
}

impl BufferBuilder {
    pub fn new(label: &str) -> BufferBuilder {
        BufferBuilder {
            label: label.to_string(),
            ..default()
        }
    }

    pub fn with_data<T: Bufferable>(mut self, t: T) -> Self {
        self.data = Some(t.data().into());
        self
    }

    pub fn with_usage(mut self, usage: wgpu::BufferUsages) -> Self {
        *self.usage.get_or_insert(usage) |= usage;
        self
    }

    pub fn build_storage(self, device: &wgpu::Device) -> StorageBuffer {
        let Self { label, data, usage } = self;

        if data.is_none() {
            panic!("Data cannot be empty.");
        }

        let usage = usage.unwrap_or(wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE);

        let label = label.as_ref();
        let size = utils::pad_size(data.as_ref().unwrap().len() * size_of::<u8>());

        debug!("Allocating storage buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(label),
            usage,
            size: size as _,
            mapped_at_creation: false,
        });

        StorageBuffer {
            label: label.to_string(),
            buffer: Arc::new(buffer),
            data: data.unwrap().data().into(),
            dirty: true,
        }
    }

    pub fn build_uniform(self, device: &wgpu::Device) -> MappedUniformBuffer {
        let Self { label, data, usage } = self;

        if data.is_none() {
            panic!("Data cannot be empty.");
        }

        let usage = usage.unwrap_or(wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::UNIFORM);

        let label = label.as_ref();
        let size = utils::pad_size(data.as_ref().unwrap().len() * size_of::<u8>());

        debug!("Allocating storage buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(label),
            usage,
            size: size as _,
            mapped_at_creation: false,
        });

        MappedUniformBuffer {
            label: label.to_string(),
            buffer: Arc::new(buffer),
            data: data.unwrap().data().into(),
            dirty: true,
        }
    }
}
