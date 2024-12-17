use bevy::{
    prelude::*,
    render::renderer::{RenderDevice, RenderQueue},
    utils::HashMap,
};

#[derive(Default, Resource)]
pub struct SyncedState {
    pub cameras: HashMap<Entity, SyncedCamera>,
}

impl SyncedState {
    pub fn is_active(&self) -> bool {
        !self.cameras.is_empty()
    }

    pub fn tick(&mut self, engine: &mut crate::Engine, device: &RenderDevice, queue: &RenderQueue) {
        if self.is_active() {
            engine.tick(device.wgpu_device(), queue);
        }
    }
}

#[derive(Debug)]
pub struct SyncedCamera {
    pub handle: crate::CameraHandle,
}

#[derive(Debug, Component)]
pub(crate) struct RdogExtractedCamera {
    pub transform: Mat4,
    pub projection: Mat4,
    pub mode: Option<crate::CameraMode>,
}


#[derive(Debug, Resource)]
pub struct ExtractedImages {
    pub changed: Vec<ExtractedImage>,
    pub removed: Vec<AssetId<Image>>,
}

#[derive(Debug)]
pub struct ExtractedImage {
    pub handle: AssetId<Image>,
    pub texture_descriptor: wgpu::TextureDescriptor<'static>,
    pub sampler_descriptor: wgpu::SamplerDescriptor<'static>,
    pub data: ExtractedImageData,
}

#[derive(Debug)]
pub enum ExtractedImageData {
    Raw { data: Vec<u8> },
    Texture { is_dynamic: bool },
}
