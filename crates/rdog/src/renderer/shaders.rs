use std::{
    borrow::Cow, future::Future, ops::Deref, pin::Pin, task::{Context, Poll}
};

use bevy::{prelude::DerefMut, utils::hashbrown::HashMap};
use futures::task::noop_waker;
use naga_oil::compose::{Composer, NagaModuleDescriptor, get_preprocessor_data};

use crate::shader::{FType, RdogShaderAsset};

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: String,
    pub data: String,
    pub imports: Vec<String>,
}

impl RdogShader {
    pub fn new(
        _u: u32,
        device: &wgpu::Device,
        asset: &RdogShaderAsset,
        composer: &mut Composer,
    ) -> Option<Self> {
        let data = match &asset.data {
            FType::Wgsl(data) => data.clone(),
            FType::Spv(_) => return None,
        };

        let module = composer
            .make_naga_module(NagaModuleDescriptor {
                source: &data,
                file_path: &asset.name,
                ..Default::default()
            })
            .unwrap();

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
            data: data.to_string()
        })
    }
}

pub fn now_or_never<F: Future>(mut future: F) -> Option<F::Output> {
    let noop_waker = noop_waker();
    let mut cx = Context::from_waker(&noop_waker);

    // SAFETY: `future` is not moved and the original value is shadowed
    let future = unsafe { Pin::new_unchecked(&mut future) };

    match future.poll(&mut cx) {
        Poll::Ready(x) => Some(x),
        _ => None,
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
    
    pub fn update_shader(&mut self, 
        frame: u32,
        device: &wgpu::Device, 
        shader: &RdogShaderAsset, 
        composer: &mut Composer
    ) -> bool {
        let comp = RdogShader::new(frame, device, shader, composer);
        if let Some(shader_module) = comp {
            self.0.insert(shader.name.to_string(), shader_module);
            true
        } else {
            false
        }
    }
    
    pub fn find_dependent_shaders(&self, lib_name: &str) -> Vec<String> {
        self.0.iter()
            .filter_map(|(name, shader)| {
                if shader.imports.contains(&lib_name.to_string()) {
                    Some(name.clone())
                } else {
                    None
                }
            })
            .collect()
    }
}
