use core::panic;
use std::collections::HashMap;
use std::ops::DerefMut;
use std::sync::Arc;

use crate::bindable::Bindable;
use crate::bufferable::Bufferable;
use crate::{
    buffers::mapped_uniform_buffer::MappedUniformBuffer, storage_buffer::StorageBuffer,
    texture::Texture,
};

use bevy::prelude::{Deref, DerefMut};
use bytemuck::Pod;
use glam::UVec3;
use wgpu::Buffer;

#[derive(Debug)]
pub enum BT {
    MUB(MappedUniformBuffer),
    SB(StorageBuffer),
    T(Texture),
}

impl BT {
    pub fn bind_readable(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::MUB(mapped_uniform_buffer) => Box::new(mapped_uniform_buffer.bind_readable()),
            BT::SB(storage_buffer) => Box::new(storage_buffer.bind_readable()),
            BT::T(texture) => Box::new(texture.bind_readable()),
        }
    }

    pub fn bind_writable(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::SB(storage_buffer) => Box::new(storage_buffer.bind_writable()),
            BT::T(texture) => Box::new(texture.bind_writable()),
            BT::MUB(_) => panic!("not supported"),
        }
    }

    pub fn bind_sampled(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::T(texture) => Box::new(texture.bind_sampled()),
            BT::SB(_) => panic!("not supported"),
            BT::MUB(_) => panic!("not supported"),
        }
    }

    pub fn flush(&mut self, q: &wgpu::Queue) {
        match self {
            BT::SB(sb) => sb.flush(q),
            BT::MUB(mub) => mub.flush(q),
            BT::T(_) => (),
        }
    }

    pub fn data(&self) -> &[u8] {
        match self {
            BT::SB(sb) => sb.data(),
            BT::MUB(mub) => mub.data(),
            BT::T(_) => panic!("not supported"),
        }
    }

    pub fn update(&mut self, data: Vec<u8>) {
        match self {
            BT::SB(sb) => {
                *sb.deref_mut() = data;
            }
            BT::MUB(mub) => *mub.deref_mut() = data,
            BT::T(_) => panic!("not supported"),
        };
    }

    pub fn size(&self) -> UVec3 {
        match self {
            BT::T(t) => t.get_size(),
            _ => panic!("not supported"),
        }
    }

    pub fn buffer(&self) -> Arc<Buffer> {
        match self {
            BT::SB(sb) => Arc::clone(&sb.buffer),
            BT::MUB(mub) => Arc::clone(&mub.buffer),
            _ => panic!("not supported"),
        }
    }

    pub fn texture(&self) -> &Texture {
        match self {
            BT::T(t) => t,
            _ => panic!("not supported"),
        }
    }

    pub fn label(&self) -> &str {
        match self {
            BT::MUB(mapped_uniform_buffer) => mapped_uniform_buffer.label(),
            BT::SB(storage_buffer) => storage_buffer.label(),
            BT::T(texture) => texture.label(),
        }
    }
}

impl From<MappedUniformBuffer> for BT {
    fn from(value: MappedUniformBuffer) -> Self {
        BT::MUB(value)
    }
}

impl From<StorageBuffer> for BT {
    fn from(value: StorageBuffer) -> Self {
        BT::SB(value)
    }
}

impl From<Texture> for BT {
    fn from(value: Texture) -> Self {
        BT::T(value)
    }
}

#[derive(Debug, Default, Deref, DerefMut)]
pub struct Buffers(HashMap<String, BT>);

impl Buffers {
    pub fn get_old(&self, st: &str) -> &BT {
        match self.0.get(st) {
            Some(s) => s,
            None => panic!("buffer: {} not available", st),
        }
    }

    pub fn get_mut(&mut self, st: &str) -> &mut BT {
        self.0.get_mut(st).unwrap()
    }

    pub fn update<T: Bufferable>(&mut self, st: &str, data: T) {
        self.get_mut(st).update(data.data().into());
    }

    // Update a storage buffer, recreating it if necessary
    pub fn update_storage(
        &mut self,
        st: &str,
        device: &wgpu::Device,
        name: &str,
        data: Vec<impl Bufferable + Pod>,
    ) {
        let current_buf = self.get_old(st);
        let new_data = data.data();

        if new_data.len() > current_buf.data().len() {
            log::debug!(
                "Re-Creating new '{}' buffer due to size change ({} -> {} bytes)",
                st,
                current_buf.data().len(),
                new_data.len()
            );
            *self.get_mut(st) = BT::from(StorageBuffer::new(device, name, data.data().to_vec()));
        } else {
            log::debug!("Reusing existing '{}' buffer", st);
            self.update(st, new_data.to_vec());
        }
    }

    pub fn add<T: Into<BT>>(&mut self, obj: T) {
        let bt = obj.into();
        self.insert(bt.label().to_string(), bt);
    }
}

impl Buffers {
    pub fn new() -> Self {
        Buffers(HashMap::new())
    }
}
