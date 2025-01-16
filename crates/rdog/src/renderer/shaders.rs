use std::ops::Deref;

use bevy::{prelude::DerefMut, utils::hashbrown::HashMap};
use wgpu::ShaderModuleDescriptor;

use crate::shader::RdogShaderAsset;

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: String,
}

impl RdogShader {
    pub fn new(device: &wgpu::Device, asset: &RdogShaderAsset) -> Self {
        let spv = wgpu::util::make_spirv(&asset.data);
        let desc = ShaderModuleDescriptor {
            label: Some(&asset.name),
            source: spv,
        };
        let module = unsafe { device.create_shader_module_unchecked(desc) };
        let entry_point = asset
            .name
            .rsplit_once('_')
            .map_or(asset.name.to_string(), |(f, l)| format!("{}::{}", f, l));

        RdogShader {
            module,
            entry_point,
        }
    }
}

#[derive(Debug, DerefMut)]
pub struct ShaderCache(HashMap<String, RdogShader>);

impl Deref for ShaderCache {
    type Target = HashMap<String, RdogShader>;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl ShaderCache {
    pub fn new_cache() -> Self {
        Self(HashMap::new())
    }
}
