use std::ops::Deref;

use bevy::{prelude::DerefMut, utils::hashbrown::HashMap};

#[derive(Debug)]
pub struct RdogShader {
    pub module: wgpu::ShaderModule,
    pub entry_point: &'static str,
}

impl RdogShader {
    pub fn new(module: wgpu::ShaderModule, entry_point: &'static str) -> Self {
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

macro_rules! shaders {
    ([ $( $name:ident, )* ]) => {
        impl ShaderCache {
            pub fn new(device: &wgpu::Device) -> Self {

                let mut h = HashMap::new();

                $(
                    info!("Initializing shader: {}", stringify!($name));

                    let module = wgpu::include_spirv!(
                        env!(concat!("rdog_shaders::", stringify!($name), ".path"))
                    );

                    // Safety: fingers crossed™
                    //
                    // We do our best, but our shaders are so array-intensive
                    // that adding the checks decreases performance by 33%, so
                    // it's pretty much a no-go.
                    let module = unsafe {
                        device.create_shader_module_unchecked(module)
                    };

                    let entry_point = env!(concat!("rdog_shaders::", stringify!($name), ".entry_point"));


                    h.insert("$name".to_string(), RdogShader::new(module, entry_point));
                )*

                Self(h)
            }
        }
    };
}

// shaders!([
//     atmosphere_noise,
//     atmosphere_atmosphere,
//     trace,
//     direct,
//     scatter,
//     specular,
//     // ray_vs,
//     // ray_fs,
//     z_trace,
//     z_gaussian,
//     z_motion,
//     raster_vs,
//     raster_fs,
// ]);
