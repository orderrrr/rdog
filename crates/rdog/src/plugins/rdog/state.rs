use bevy::{prelude::*, render::renderer::RenderDevice, utils::HashMap};

use crate::{passes::PassRegistry, Config};

use super::shader::RdogShaderAsset;

#[derive(Default, Resource)]
pub struct SyncedState {
    pub cameras: HashMap<Entity, SyncedCamera>,
}

impl SyncedState {
    pub fn is_active(&self) -> bool {
        !self.cameras.is_empty()
    }

    pub fn compute_shaders(
        &self,
        engine: &mut crate::Engine,
        device: &RenderDevice,
        shaders: &Vec<RdogShaderAsset>,
    ) {
        engine.compute_shaders(device.wgpu_device(), shaders);
    }
}

#[derive(Debug)]
pub struct SyncedCamera {
    pub handle: crate::CameraHandle,
}

#[derive(Debug, Component)]
pub struct RdogExtractedCamera {
    pub transform: Mat4,
    pub projection: Mat4,
    pub mode: Option<crate::CameraMode>,
}

#[derive(Resource, Debug, Component)]
pub struct RdogExtractedExtras {
    pub mouse: Option<Vec2>,
    pub frame: u32,
}

#[derive(Debug, Resource)]
pub struct ExtractedImages {
    pub changed: Vec<ExtractedImage>,
    pub removed: Vec<AssetId<Image>>,
}

#[derive(Debug, Resource, Deref)]
pub struct ExtractedConfig(pub Config);

#[derive(Debug, Resource, Deref, DerefMut)]
pub struct ExtractedPipelineRegistry(pub PassRegistry);

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
