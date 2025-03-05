use core::panic;
use std::ops::DerefMut;
use std::sync::Arc;

use crate::bindable::Bindable;
use crate::bufferable::Bufferable;
use crate::{
    buffers::mapped_uniform_buffer::MappedUniformBuffer, map_read_buffer::MapReadBuffer,
    map_write_buffer::MapWriteBuffer, storage_buffer::StorageBuffer, texture::Texture, Globals,
};

use super::{config::Camera, engine::Engine};
use bevy::utils::hashbrown::HashMap;
use bytemuck::Pod;
use glam::{uvec3, Vec4};
use log::debug;
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
            BT::T(_) => panic!("not supported"),
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

#[derive(Debug)]
pub struct Buffers(HashMap<String, BT>);

impl Buffers {
    pub fn get(&self, st: &str) -> &BT {
        self.0.get(st).unwrap()
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
        let current_buf = self.get(st);
        let new_data = data.data();

        if new_data.len() > current_buf.data().len() {
            // Need larger buffer - create new one
            log::debug!(
                "Creating new '{}' buffer due to size change ({} -> {} bytes)",
                st,
                current_buf.data().len(),
                new_data.len()
            );
            *self.get_mut(st) = BT::from(StorageBuffer::new(device, name, data));
        } else {
            // Update existing buffer
            log::debug!("Reusing existing '{}' buffer", st);
            self.update(st, new_data.to_vec());
        }
    }
}

impl Buffers {
    pub fn new(engine: &Engine, device: &wgpu::Device, camera: &Camera) -> Self {
        debug!("Initializing camera buffers");

        let curr_camera = MappedUniformBuffer::new(device, "camera", camera.serialize());
        let prev_camera = MappedUniformBuffer::new(device, "prev_camera", camera.serialize());
        let globals =
            MappedUniformBuffer::new(device, "globals", Globals::from_engine(engine).serialize());
        let config = MappedUniformBuffer::new(device, "config", engine.config.to_pass_params());
        let materials = StorageBuffer::new(device, "materials", engine.config.material_pass());
        let lights = StorageBuffer::new(device, "lights", engine.config.light_pass());
        let march_readback = MapWriteBuffer::new(device, "march_readback", Vec4::ZERO);

        let render_tx = Texture::builder("render")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let render_alt_tx = Texture::builder("renderalt")
            .with_size(camera.viewport.size)
            .with_format(wgpu::TextureFormat::Rgba32Float)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        let voxels = Texture::builder("voxels")
            .with_size_3d(uvec3(
                engine.config.voxel_dim,
                engine.config.voxel_dim,
                engine.config.voxel_dim,
            ))
            .with_format(wgpu::TextureFormat::Rgba16Float) // TODO - pack 8 here instead of a single voxel
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
            .with_linear_filtering_sampler()
            .build(device);

        // let prev_tx = Texture::builder("prev_tx")
        //     .with_size(camera.viewport.size)
        //     .with_format(wgpu::TextureFormat::Rgba32Float)
        //     .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
        //     .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
        //     .with_linear_filtering_sampler()
        //     .build(device);

        // let atmosphere_tx = Texture::builder("atmosphere")
        //     .with_size((camera.viewport.size.as_vec2() * ATMOS_MULT).as_uvec2()) // should be larger maybe? not sure
        //     .with_format(wgpu::TextureFormat::Rgba16Float)
        //     .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
        //     .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
        //     .with_linear_filtering_sampler()
        //     .build(device);

        // let atmos_noise_tx = Texture::builder("atmos_noise")
        //     .with_size(NOISE_DIM)
        //     .with_format(wgpu::TextureFormat::Rgba16Float)
        //     .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
        //     .with_usage(wgpu::TextureUsages::STORAGE_BINDING)
        //     .with_linear_filtering_sampler()
        //     .build(device);

        let mut hm: HashMap<String, BT> = HashMap::new();

        hm.insert("prev_camera".to_string(), BT::from(prev_camera));
        hm.insert("curr_camera".to_string(), BT::from(curr_camera));
        hm.insert("globals".to_string(), BT::from(globals));
        hm.insert("render_tx".to_string(), BT::from(render_tx));
        hm.insert("render_alt_tx".to_string(), BT::from(render_alt_tx));
        hm.insert("config".to_string(), BT::from(config));
        hm.insert("materials".to_string(), BT::from(materials));
        hm.insert("lights".to_string(), BT::from(lights));
        hm.insert("voxels".to_string(), BT::from(voxels));
        hm.insert("march_readback".to_string(), BT::from(march_readback));

        Buffers(hm)
    }
}
