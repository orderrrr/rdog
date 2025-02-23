use std::{
    mem,
    ops::{Deref, DerefMut}, sync::Arc,
};

use bytemuck::Pod;
use log::debug;

use super::bufferable::Bufferable;
use crate::utils;

/// MapRead buffer that exists only in VRAM.
///
/// This kind of storage buffer should be used for data structures that don't
/// have to be accessed on the host machine.
#[derive(Debug)]
pub struct MapReadBuffer {
    pub buffer: Arc<wgpu::Buffer>,
    data: Vec<u8>,
    dirty: bool,
}

impl MapReadBuffer {
    pub fn new<T: Bufferable + Pod>(
        device: &wgpu::Device,
        label: impl AsRef<str>,
        data: T,
    ) -> Self {
        let label = label.as_ref();
        let size = utils::pad_size(size_of::<T>());

        debug!("Allocating storage buffer `{label}`; size={size}");

        let buffer = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some(label),
            usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
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
}

impl Deref for MapReadBuffer {
    type Target = Vec<u8>;

    fn deref(&self) -> &Self::Target {
        &self.data
    }
}

impl DerefMut for MapReadBuffer {
    fn deref_mut(&mut self) -> &mut Self::Target {
        self.dirty = true;
        &mut self.data
    }
}
