use std::{
    borrow::Cow,
    collections::HashMap,
    future::Future,
    ops::Deref,
    pin::Pin,
    task::{Context, Poll},
};

use crate::shader::{FType, RdogShaderAsset};
use bevy::{
    log::error,
    prelude::DerefMut,
    render::{
        render_resource::{Shader, ShaderDefVal, ShaderImport},
        renderer::RenderDevice,
    },
    utils::default,
};
use futures::task::noop_waker;
use naga_oil::compose::{
    get_preprocessor_data, ComposableModuleDescriptor, Composer, NagaModuleDescriptor,
    ShaderDefValue,
};
use wgpu::{naga, DownlevelFlags, Features, ShaderModuleDescriptor, ShaderSource};

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

#[derive(Default, Debug)]
pub struct ShaderCache {
    pub cache: HashMap<String, RdogShader>,
    pub composer: Composer,
}

impl ShaderCache {
    pub fn update_shader(
        &mut self,
        frame: u32,
        device: &wgpu::Device,
        shader: &RdogShaderAsset,
        composer: &mut Composer,
    ) -> bool {
        let comp = RdogShader::new(frame, device, shader, composer);
        if let Some(shader_module) = comp {
            self.cache.insert(shader.name.to_string(), shader_module);
            true
        } else {
            false
        }
    }

    pub fn find_dependent_shaders(&self, lib_name: &str) -> Vec<String> {
        self.cache
            .iter()
            .filter_map(|(name, shader)| {
                if shader.imports.contains(&lib_name.to_string()) {
                    Some(name.clone())
                } else {
                    None
                }
            })
            .collect()
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

// fn compile_shader(
//     cache: ShaderCache,
//     device: &RenderDevice,
//     shader: &RdogShaderAsset,
// ) -> Result<(), String> {
//     let mut composer = cache.composer;
//
//     // Convert shader defs to the format expected by naga_oil
//     let shader_defs = all_shader_defs
//         .into_iter()
//         .map(|def| match def {
//             ShaderDefVal::Bool(k, v) => (k, ShaderDefValue::Bool(v)),
//             ShaderDefVal::Int(k, v) => (k, ShaderDefValue::Int(v)),
//             ShaderDefVal::UInt(k, v) => (k, ShaderDefValue::UInt(v)),
//         })
//         .collect::<HashMap<_, _>>();
//
//     // Create the naga module
//     let result = composer.make_naga_module(NagaModuleDescriptor {
//         shader_defs,
//         ..shader.into()
//     });
//
//     match result {
//         Ok(naga_module) => {
//             // Create a shader module from the naga module
//             let label = format!("Shader: {}", shader.path);
//             let shader_module_descriptor = ShaderModuleDescriptor {
//                 label: Some(&label),
//                 source: ShaderSource::Naga(std::borrow::Cow::Owned(naga_module)),
//             };
//
//             // Create the shader module
//             device.create_shader_module(shader_module_descriptor);
//             Ok(())
//         }
//         Err(err) => {
//             let error_detail = err.emit_to_string(&composer);
//             Err(format!("Failed to process shader:\n{}", error_detail))
//         }
//     }
// }
//
// // Recursively process shader imports
// fn process_shader_import(composer: &mut Composer, shader: &RdogShaderAsset) -> Result<(), String> {
//     let source = match &shader.data {
//         FType::Wgsl(d) => d,
//         FType::Spv(_) => panic!("spv not currently supported"),
//     };
//
//     // In a real implementation, this would load the imported shader from assets
//     // Here we're simplifying by assuming the shader is already loaded
//     let result = composer.add_composable_module(ComposableModuleDescriptor {
//         source: &source,
//         file_path: &shader.name,
//         language: naga_oil::compose::ShaderLanguage::Wgsl,
//         as_name: None,
//         shader_defs: HashMap::new(),
//         ..default()
//     });
//
//     if let Err(e) = result {
//         let error_string = e.emit_to_string(composer);
//         return Err(error_string);
//     }
//
//     Ok(())
// }
//
// // Copied from Bevy's implementation
// fn get_capabilities(features: Features, _downlevel: DownlevelFlags) -> naga::valid::Capabilities {
//     let mut capabilities = naga::valid::Capabilities::empty();
//     capabilities.set(
//         naga::valid::Capabilities::PUSH_CONSTANT,
//         features.contains(Features::PUSH_CONSTANTS),
//     );
//     capabilities.set(
//         naga::valid::Capabilities::FLOAT64,
//         features.contains(Features::SHADER_F64),
//     );
//     capabilities.set(
//         naga::valid::Capabilities::PRIMITIVE_INDEX,
//         features.contains(Features::SHADER_PRIMITIVE_INDEX),
//     );
//     capabilities.set(
//         naga::valid::Capabilities::SAMPLED_TEXTURE_AND_STORAGE_BUFFER_ARRAY_NON_UNIFORM_INDEXING,
//         features.contains(Features::SAMPLED_TEXTURE_AND_STORAGE_BUFFER_ARRAY_NON_UNIFORM_INDEXING),
//     );
//     capabilities.set(
//         naga::valid::Capabilities::UNIFORM_BUFFER_AND_STORAGE_TEXTURE_ARRAY_NON_UNIFORM_INDEXING,
//         features.contains(Features::UNIFORM_BUFFER_AND_STORAGE_TEXTURE_ARRAY_NON_UNIFORM_INDEXING),
//     );
//     capabilities.set(
//         naga::valid::Capabilities::SAMPLER_NON_UNIFORM_INDEXING,
//         features.contains(Features::SAMPLED_TEXTURE_AND_STORAGE_BUFFER_ARRAY_NON_UNIFORM_INDEXING),
//     );
//     // Add other capabilities as needed...
//     capabilities
// }
//
// #[cfg(test)]
// mod tests {
//     use crate::shader::ShaderType;
//
//     use super::*;
//     use bevy::{asset::Assets, render::render_resource::Source};
//     use std::borrow::Cow;
//
//     #[test]
//     fn test_compile_simple_shader() {
//         // Create a minimal Render Device for testing
//         let instance = wgpu::Instance::new(wgpu::InstanceDescriptor {
//             backends: wgpu::Backends::all(),
//             dx12_shader_compiler: Default::default(),
//             flags: wgpu::InstanceFlags::default(),
//             gles_minor_version: wgpu::Gles3MinorVersion::default(),
//         });
//
//         let adapter = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
//             power_preference: wgpu::PowerPreference::default(),
//             compatible_surface: None,
//             force_fallback_adapter: false,
//         }))
//         .expect("Failed to find an appropriate adapter");
//
//         let (device, _queue) = pollster::block_on(adapter.request_device(
//             &wgpu::DeviceDescriptor {
//                 required_features: wgpu::Features::empty(),
//                 required_limits: wgpu::Limits::default(),
//                 memory_hints: wgpu::MemoryHints::Performance,
//                 label: None,
//             },
//             None,
//         ))
//         .expect("Failed to create device");
//
//         let render_device = RenderDevice::from(device);
//
//         // Create a simple shader
//         let shader_source = r#"
//             @vertex
//             fn vertex_main(@location(0) position: vec3<f32>) -> @builtin(position) vec4<f32> {
//                 return vec4<f32>(position, 1.0);
//             }
//
//             @fragment
//             fn fragment_main() -> @location(0) vec4<f32> {
//                 return vec4<f32>(1.0, 0.0, 0.0, 1.0);
//             }
//         "#;
//
//         let shader = Shader::from_wgsl(shader_source.to_string(), "test_shader.wgsl");
//
//         // Compile the shader
//         let result = compile_shader(&render_device, &shader, &[]);
//         assert!(
//             result.is_ok(),
//             "Failed to compile shader: {:?}",
//             result.err()
//         );
//     }
//
//     #[test]
//     fn test_compile_shader_with_imports() {
//         // Create a minimal Render Device for testing
//         let instance = wgpu::Instance::new(wgpu::InstanceDescriptor {
//             backends: wgpu::Backends::all(),
//             dx12_shader_compiler: Default::default(),
//             flags: wgpu::InstanceFlags::default(),
//             gles_minor_version: wgpu::Gles3MinorVersion::default(),
//         });
//
//         let adapter = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
//             power_preference: wgpu::PowerPreference::default(),
//             compatible_surface: None,
//             force_fallback_adapter: false,
//         }))
//         .expect("Failed to find an appropriate adapter");
//
//         let (device, _queue) = pollster::block_on(adapter.request_device(
//             &wgpu::DeviceDescriptor {
//                 required_features: wgpu::Features::empty(),
//                 required_limits: wgpu::Limits::default(),
//                 label: None,
//                 memory_hints: wgpu::MemoryHints::Performance,
//             },
//             None,
//         ))
//         .expect("Failed to create device");
//
//         let render_device = RenderDevice::from(device);
//
//         // Create a shader with imports
//         let shader_with_imports = r#"
//             #import "common.wgsl"
//
//             @vertex
//             fn vertex_main(@location(0) position: vec3<f32>) -> @builtin(position) vec4<f32> {
//                 return vec4<f32>(position * SCALE, 1.0);
//             }
//
//             @fragment
//             fn fragment_main() -> @location(0) vec4<f32> {
//                 return RED_COLOR;
//             }
//         "#;
//
//         // Create a simple mock asset system
//         let mut shader_assets = Assets::<Shader>::default();
//
//         // Create the common shader
//         let common_shader = r#"
//             const SCALE: f32 = 2.0;
//             const RED_COLOR: vec4<f32> = vec4<f32>(1.0, 0.0, 0.0, 1.0);
//         "#;
//
//         let common_shader = Shader::from_wgsl(common_shader.to_string(), "common.wgsl");
//
//         // Create the main shader
//         let mut main_shader = Shader::from_wgsl(shader_with_imports.to_string(), "main.wgsl");
//
//         // In a real test, you would connect the imports properly
//         // Here we're just testing the compilation mechanism
//
//         // Compile the shader
//         let result = compile_shader(&render_device, &main_shader, &[]);
//         // This will fail in our test because we're not properly connecting the imports
//         // In a real test with proper asset loading, this would work
//         assert!(
//             result.is_err(),
//             "Expected compilation to fail due to missing imports"
//         );
//     }
//
//     #[test]
//     fn test_compile_shader_with_imports() {
//         // Create a minimal Render Device for testing
//         let instance = wgpu::Instance::new(wgpu::InstanceDescriptor {
//             backends: wgpu::Backends::all(),
//             dx12_shader_compiler: Default::default(),
//             flags: wgpu::InstanceFlags::default(),
//             gles_minor_version: wgpu::Gles3MinorVersion::default(),
//         });
//
//         let adapter = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
//             power_preference: wgpu::PowerPreference::default(),
//             compatible_surface: None,
//             force_fallback_adapter: false,
//         }))
//         .expect("Failed to find an appropriate adapter");
//
//         let (device, _queue) = pollster::block_on(adapter.request_device(
//             &wgpu::DeviceDescriptor {
//                 required_features: wgpu::Features::empty(),
//                 required_limits: wgpu::Limits::default(),
//                 label: None,
//                 memory_hints: wgpu::MemoryHints::Performance,
//             },
//             None,
//         ))
//         .expect("Failed to create device");
//
//         let render_device = RenderDevice::from(device);
//
//         let lib = RdogShaderAsset::new(
//             "common",
//             FType::Wgsl(Cow::Owned(
//                 r#"
//                 #define_import_path lib
//
//                 fn test() {
//                 }
//             "#
//                 .to_string(),
//             )),
//             ShaderType::Lib,
//         );
//
//         let common = RdogShaderAsset::new(
//             "common",
//             FType::Wgsl(Cow::Owned(
//                 r#"
//                 #define_import_path common
//                 #import lib::test
//
//                 fn tt() {
//                     let c = camera;
//                     test();
//                 }
//             "#
//                 .to_string(),
//             )),
//             ShaderType::Lib,
//         );
//
//         let shader = RdogShaderAsset::new(
//             "common",
//             FType::Wgsl(Cow::Owned(
//                 r#"
//                 @group(0) @binding(0) var<uniform> camera: vec4f;
//
//                 #import common::tt
//
//                 fn main() {
//                     tt();
//                 }
//             "#
//                 .to_string(),
//             )),
//             ShaderType::Lib,
//         );
//     }
// }
