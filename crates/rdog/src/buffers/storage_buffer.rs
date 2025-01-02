use std::{
    mem,
    ops::{Deref, DerefMut},
};

use bytemuck::Pod;
use log::debug;
use rdog_lib::Material;

use super::{bindable::Bindable, bufferable::Bufferable};
use crate::utils;

/// Storage buffer that exists only in VRAM.
///
/// This kind of storage buffer should be used for data structures that don't
/// have to be accessed on the host machine.
#[derive(Debug)]
pub struct StorageBuffer<T> {
    buffer: wgpu::Buffer,
    data: Vec<T>,
    dirty: bool,
}

impl<T> StorageBuffer<T>
where
    T: Bufferable + Pod,
{
    // TODO provide `::builder()` pattern
    pub fn new(device: &wgpu::Device, label: impl AsRef<str>, data: Vec<T>) -> Self {
        let label = label.as_ref();
        let size = utils::pad_size(data.len() * size_of::<T>());

        debug!("Allocating storage buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(label),
            usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::STORAGE,
            size: size as _,
            mapped_at_creation: false,
        });

        Self {
            buffer,
            data,
            dirty: true,
        }
    }

    pub fn flush(&mut self, queue: &wgpu::Queue) {
        if !mem::take(&mut self.dirty) {
            return;
        }

        queue.write_buffer(&self.buffer, 0, self.data.data());
    }

    /// Creates an immutable storage-buffer binding:
    ///
    /// ```
    /// #[spirv(descriptor_set = ..., binding = ..., storage_buffer)]
    /// items: &[T],
    /// ```
    pub fn bind_readable(&self) -> impl Bindable + '_ {
        StorageBufferBinder {
            parent: self,
            read_only: true,
        }
    }
}

pub struct StorageBufferBinder<'a, T> {
    parent: &'a StorageBuffer<T>,
    read_only: bool,
}

impl<T> Deref for StorageBuffer<T> {
    type Target = Vec<T>;

    fn deref(&self) -> &Self::Target {
        &self.data
    }
}

impl<T> DerefMut for StorageBuffer<T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.dirty = true;
        &mut self.data
    }
}

impl<T> Bindable for StorageBufferBinder<'_, T> {
    fn bind(&self, binding: u32) -> Vec<(wgpu::BindGroupLayoutEntry, wgpu::BindingResource)> {
        let layout = wgpu::BindGroupLayoutEntry {
            binding,
            visibility: wgpu::ShaderStages::all(),
            ty: wgpu::BindingType::Buffer {
                ty: wgpu::BufferBindingType::Storage {
                    read_only: self.read_only,
                },
                has_dynamic_offset: false,
                min_binding_size: None,
            },
            count: None,
        };

        let resource = self.parent.buffer.as_entire_binding();

        vec![(layout, resource)]
    }
}
