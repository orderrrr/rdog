use std::{
    mem,
    ops::{Deref, DerefMut},
    sync::Arc,
};

use log::debug;

use super::{bindable::Bindable, bufferable::Bufferable};

/// MapWrite buffer that exists only in VRAM.
///
/// This kind of storage buffer should be used for data structures that don't
/// have to be accessed on the host machine.
#[derive(Debug)]
pub struct MapWriteBuffer {
    pub buffer: Arc<wgpu::Buffer>,
    data: Vec<u8>,
    dirty: bool,
}

impl MapWriteBuffer {
    pub fn new(device: &wgpu::Device, label: impl AsRef<str>, data: Vec<u8>) -> Self {
        let label = label.as_ref();
        let size = size_of::<u8>() * data.len();

        debug!("Allocating storage buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(label),
            usage: wgpu::BufferUsages::COPY_DST
                | wgpu::BufferUsages::COPY_SRC
                | wgpu::BufferUsages::STORAGE,
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

    /// Creates an immutable storage-buffer binding:
    ///
    /// ```
    /// #[spirv(descriptor_set = ..., binding = ..., storage_buffer)]
    /// items: &[T],
    /// ```
    pub fn bind_readable(&self) -> impl Bindable + '_ {
        MapWriteBufferBinder {
            parent: self,
            read_only: true,
        }
    }

    pub fn bind_writable(&self) -> impl Bindable + '_ {
        MapWriteBufferBinder {
            parent: self,
            read_only: false,
        }
    }

    pub fn size(&self) -> usize {
        self.data.size()
    }
}

pub struct MapWriteBufferBinder<'a> {
    parent: &'a MapWriteBuffer,
    read_only: bool,
}

impl Deref for MapWriteBuffer {
    type Target = Vec<u8>;
    fn deref(&self) -> &Self::Target {
        &self.data
    }
}

impl DerefMut for MapWriteBuffer {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.dirty = true;
        &mut self.data
    }
}

impl Bindable for MapWriteBufferBinder<'_> {
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
