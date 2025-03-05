use std::{
    borrow::Cow, future::Future, ops::Deref, pin::Pin, task::{Context, Poll}
};

use bevy::{prelude::DerefMut, utils::hashbrown::HashMap};
use futures::task::noop_waker;
use naga_oil::compose::{Composer, NagaModuleDescriptor};

use crate::shader::{FType, RdogShaderAsset};

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: String,
}

impl RdogShader {
    pub fn new(
        u: u32,
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

        let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
            source: wgpu::ShaderSource::Naga(Cow::Owned(module)),
            label: None,
        });

        if u > 1 {
            let error = device.pop_error_scope();

            // todo maybe show parser error somewhere
            if let Some(Some(wgpu::Error::Validation { description, .. })) = now_or_never(error) {
                log::error!("parser error: {description:?}");
                log::info!("desc: {}", description);
                return None;
            };
        }

        let entry_point = match &asset.data {
            FType::Spv(_) => asset
                .name
                .rsplit_once('_')
                .map_or(asset.name.to_string(), |(f, l)| format!("{}::{}", f, l)),
            // todo - make this dynamic for fragment and vertex.
            FType::Wgsl(_) => "main".to_string(),
        };

        Some(RdogShader {
            module,
            entry_point,
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
}
