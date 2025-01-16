use bevy::{
    asset::{AssetEvent, Assets},
    prelude::{EventReader, Res, ResMut, Resource},
    render::{renderer::RenderDevice, Extract},
    utils::HashMap,
};

use crate::shader::RdogShaderAsset;

#[derive(Resource)]
pub struct RdogShaderCache {
    pub device: RenderDevice,
    pub shader_cache: HashMap<String, RdogShaderAsset>,
}

#[allow(clippy::type_complexity)]
pub(crate) fn shader(
    mut cache: ResMut<RdogShaderCache>,
    shaders: Extract<Res<Assets<RdogShaderAsset>>>,
    mut events: Extract<EventReader<AssetEvent<RdogShaderAsset>>>,
) {
    cache.shader_cache.drain();

    for event in events.read() {
        match event {
            AssetEvent::Added { id } | AssetEvent::Modified { id } => {
                if let Some(shader) = shaders.get(*id) {
                    log::info!("Shader added: {:?}", shader.name);
                    cache
                        .shader_cache
                        .insert(shader.name.to_string(), shader.clone());
                }
            }
            _ => {}
        }
    }
}
