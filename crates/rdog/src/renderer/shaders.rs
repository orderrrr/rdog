use std::borrow::Cow;

use crate::shader::{FType, RdogShaderAsset, ShaderType};
use bevy::{
    log::{error, info, warn},
    utils::{default, HashMap},
};
use naga_oil::compose::{
    get_preprocessor_data, ComposableModuleDescriptor, Composer, NagaModuleDescriptor,
};
use wgpu::{naga, Device};

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: String,
    pub data: String,
    pub imports: Vec<String>,
}

impl RdogShader {
    pub fn new(
        device: &wgpu::Device,
        asset: &RdogShaderAsset,
        composer: &mut Composer,
    ) -> Option<Self> {
        let data = match &asset.data {
            FType::Wgsl(data) => data.clone(),
            FType::Spv(_) => return None,
        };

        let module = composer.make_naga_module(NagaModuleDescriptor {
            source: &data,
            file_path: &asset.name,
            ..default()
        });

        let Ok(module) = module else {
            error!(
                "module compile error: {}",
                &module.err().unwrap().emit_to_string(composer)
            );
            return None;
        };

        let (_, imports, _) = get_preprocessor_data(&data);
        let imports = imports.iter().map(|i| i.import.clone()).collect();

        let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
            source: wgpu::ShaderSource::Naga(Cow::Owned(module)),
            label: None,
        });

        let entry_point = match &asset.data {
            FType::Spv(_) => asset
                .name
                .rsplit_once('_')
                .map_or(asset.name.to_string(), |(f, l)| format!("{}::{}", f, l)),
            FType::Wgsl(_) => "main".to_string(),
        };

        Some(RdogShader {
            module,
            entry_point,
            imports,
            data: data.to_string(),
        })
    }
}

#[derive(Debug, Clone)]
pub struct RdogShaderLib {
    pub data: String,
}

impl RdogShaderLib {
    pub fn new(composer: &mut Composer, asset: &RdogShaderAsset) -> Option<Self> {
        let data = match &asset.data {
            FType::Wgsl(data) => data.clone(),
            FType::Spv(_) => return None,
        };

        if let Err(e) = composer.add_composable_module(ComposableModuleDescriptor {
            source: &data,
            file_path: &asset.name,
            ..default()
        }) {
            error!(
                "Failed to load library module {}, {}",
                asset.name,
                e.emit_to_string(&composer)
            );

            return None;
        };
        Some(RdogShaderLib {
            data: data.to_string(),
        })
    }
}

#[derive(Default, Debug)]
pub struct ShaderCache {
    pub cache: HashMap<String, RdogShader>,
    pub lib_cache: HashMap<String, RdogShaderLib>,
    pub composer: Composer,
}

impl ShaderCache {
    pub fn update_shaders(&mut self, device: &wgpu::Device, shaders: &Vec<RdogShaderAsset>) {
        let updated_lib = self.update_libs(shaders);

        if updated_lib {
            self.composer = Composer::default();
            for feat in vec![naga::valid::Capabilities::PUSH_CONSTANT] {
                self.composer.capabilities.insert(feat);
            }

            self.recompute_libs();
        }

        let updated = self.update(device, shaders);

        if updated {
            self.recompute(device);
        }
    }

    pub(crate) fn recompute_libs(&mut self) -> bool {
        return self.update_libs(
            &self
                .lib_cache
                .clone()
                .iter()
                .map(|(k, v)| {
                    RdogShaderAsset::new(k, FType::Wgsl(v.data.clone().into()), ShaderType::Lib)
                })
                .collect::<Vec<RdogShaderAsset>>(),
        );
    }

    fn update_libs(&mut self, shaders: &Vec<RdogShaderAsset>) -> bool {
        let mut shaders_remaining = shaders.clone();
        info!("shader size?: {}", shaders_remaining.len());
        let mut retry_count = 0;
        const MAX_RETRIES: usize = 5; // Adjust based on your needs

        while !shaders_remaining.is_empty() && retry_count <= MAX_RETRIES {
            let s: Vec<RdogShaderAsset> = shaders_remaining.drain(..).collect();

            for shader in s.into_iter() {
                if shader.stype == ShaderType::Lib {
                    info!("computing: {}", shader.name);

                    if !self.import_lib(&shader) {
                        shaders_remaining.push(shader);
                    }
                }
            }

            retry_count += 1;
        }

        if shaders_remaining.is_empty() {
            info!("All lib shaders have been successfully loaded.");
            return true;
        } else {
            warn!(
                "Some shaders failed to load even after {} retries.",
                MAX_RETRIES
            );
            return false;
        }
    }

    pub(crate) fn import_lib(&mut self, shader: &RdogShaderAsset) -> bool {
        let lib = RdogShaderLib::new(&mut self.composer, shader);
        if lib.is_none() {
            return false;
        }
        self.lib_cache.insert(shader.name.clone(), lib.unwrap());
        return true;
    }

    fn update(&mut self, device: &wgpu::Device, shaders: &Vec<RdogShaderAsset>) -> bool {
        let mut shaders_remaining = shaders.clone();
        let mut retry_count = 0;
        const MAX_RETRIES: usize = 5; // Adjust based on your needs

        while !shaders_remaining.is_empty() && retry_count <= MAX_RETRIES {
            let s: Vec<RdogShaderAsset> = shaders_remaining.drain(..).collect();

            for shader in s.into_iter() {
                if shader.stype == ShaderType::Shader {
                    info!("shader name?: {}", shader.name);
                    if !self.import(device, &shader) {
                        shaders_remaining.push(shader);
                    }
                }
            }

            retry_count += 1;
        }

        if shaders_remaining.is_empty() {
            info!("All shaders have been successfully loaded.");
            return true;
        } else {
            warn!(
                "Some shaders failed to load even after {} retries.",
                MAX_RETRIES
            );
            return false;
        }
    }

    pub(crate) fn import(&mut self, device: &Device, shader: &RdogShaderAsset) -> bool {
        let s = RdogShader::new(device, shader, &mut self.composer);
        if s.is_none() {
            return false;
        }
        self.cache.insert(shader.name.clone(), s.unwrap());
        return true;
    }

    pub(crate) fn recompute(&mut self, device: &Device) -> bool {
        return self.update(
            device,
            &self
                .cache
                .iter()
                .map(|(k, v)| {
                    RdogShaderAsset::new(k, FType::Wgsl(v.data.clone().into()), ShaderType::Shader)
                })
                .collect::<Vec<RdogShaderAsset>>(),
        );
    }

    pub(crate) fn new(features: Vec<naga::valid::Capabilities>) -> Self {
        let mut comp = Composer::default();
        for feat in features {
            comp.capabilities.insert(feat);
        }

        Self {
            composer: comp,
            ..default()
        }
    }

    pub fn get(&self, arg: &str) -> Option<&RdogShader> {
        self.cache.get(arg)
    }
}

