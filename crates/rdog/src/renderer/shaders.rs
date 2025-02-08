use std::{
    future::Future,
    ops::Deref,
    pin::Pin,
    task::{Context, Poll},
};

use bevy::{prelude::DerefMut, utils::hashbrown::HashMap};
use bevy_egui::egui::debug_text::print;
use futures::task::noop_waker;
use log::info;
use wgpu::ShaderModuleDescriptor;

use crate::shader::{FType, RdogShaderAsset};

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: String,
}

impl RdogShader {
    pub fn new(u: u32, device: &wgpu::Device, asset: &RdogShaderAsset) -> Option<Self> {
        let spv = match &asset.data {
            FType::Spv(data) => wgpu::util::make_spirv(&data),
            FType::Wgsl(data) => wgpu::ShaderSource::Wgsl(data.clone()),
        };

        let desc = ShaderModuleDescriptor {
            label: Some(&asset.name),
            source: spv,
        };

        if u > 1 {
            device.push_error_scope(wgpu::ErrorFilter::Validation);
        }
        let module = device.create_shader_module(desc);

        if u > 1 {
            let error = device.pop_error_scope();

            // todo maybe show parser error somewhere
            if let Some(Some(wgpu::Error::Validation { description, .. })) = now_or_never(error) {
                log::error!("parser error: {description:?}");
                println!("desc: {}", description);
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
