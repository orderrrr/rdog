use core::panic;
use std::ops::DerefMut;
use std::sync::Arc;

use crate::bindable::Bindable;
use crate::bufferable::Bufferable;
use crate::{
    buffers::mapped_uniform_buffer::MappedUniformBuffer, map_read_buffer::MapReadBuffer,
    map_write_buffer::MapWriteBuffer, storage_buffer::StorageBuffer, texture::Texture,
};

use bevy::prelude::{Deref, DerefMut};
use bevy::utils::hashbrown::HashMap;
use bytemuck::Pod;
use glam::UVec3;
use wgpu::Buffer;

#[derive(Debug)]
pub enum BT {
    MUB(MappedUniformBuffer),
    SB(StorageBuffer),
    T(Texture),
    MWB(MapWriteBuffer),
    MRB(MapReadBuffer),
}

impl BT {
    pub fn bind_readable(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::MUB(mapped_uniform_buffer) => Box::new(mapped_uniform_buffer.bind_readable()),
            BT::SB(storage_buffer) => Box::new(storage_buffer.bind_readable()),
            BT::T(texture) => Box::new(texture.bind_readable()),
            BT::MWB(map_write_buffer) => Box::new(map_write_buffer.bind_readable()),
            BT::MRB(_) => panic!("not supported"),
        }
    }

    pub fn bind_writable(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::SB(storage_buffer) => Box::new(storage_buffer.bind_writable()),
            BT::T(texture) => Box::new(texture.bind_writable()),
            BT::MWB(map_write_buffer) => Box::new(map_write_buffer.bind_writable()),
            BT::MUB(_) => panic!("not supported"),
            BT::MRB(_) => panic!("not supported"),
        }
    }

    pub fn bind_sampled(&self) -> Box<dyn Bindable + '_> {
        match self {
            BT::T(texture) => Box::new(texture.bind_sampled()),
            BT::SB(_) => panic!("not supported"),
            BT::MWB(_) => panic!("not supported"),
            BT::MUB(_) => panic!("not supported"),
            BT::MRB(_) => panic!("not supported"),
        }
    }

    pub fn flush(&mut self, q: &wgpu::Queue) {
        match self {
            BT::SB(sb) => sb.flush(q),
            BT::MWB(mwb) => mwb.flush(q),
            BT::MUB(mub) => mub.flush(q),
            BT::MRB(mrb) => mrb.flush(q),
            BT::T(_) => (),
        }
    }

    pub fn data(&self) -> &[u8] {
        match self {
            BT::SB(sb) => sb.data(),
            BT::MWB(mwb) => mwb.data(),
            BT::MUB(mub) => mub.data(),
            BT::MRB(mrb) => mrb.data(),
            BT::T(_) => panic!("not supported"),
        }
    }

    pub fn update(&mut self, data: Vec<u8>) {
        match self {
            BT::SB(sb) => {
                *sb.deref_mut() = data;
            }
            BT::MWB(mwb) => *mwb.deref_mut() = data,
            BT::MUB(mub) => *mub.deref_mut() = data,
            BT::MRB(mrb) => *mrb.deref_mut() = data,
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
            BT::MWB(mwb) => Arc::clone(&mwb.buffer),
            BT::MUB(mub) => Arc::clone(&mub.buffer),
            BT::MRB(mrb) => Arc::clone(&mrb.buffer),
            _ => panic!("not supported"),
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

impl From<MapWriteBuffer> for BT {
    fn from(value: MapWriteBuffer) -> Self {
        BT::MWB(value)
    }
}

impl From<MapReadBuffer> for BT {
    fn from(value: MapReadBuffer) -> Self {
        BT::MRB(value)
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

    pub fn update(&mut self, st: &str, data: Vec<u8>) {
        self.get_mut(st).update(data);
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
}

impl Buffers {
    pub fn new() -> Self {
        Buffers(HashMap::new())
    }
}
