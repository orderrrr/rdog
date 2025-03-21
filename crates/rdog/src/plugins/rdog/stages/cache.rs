use bevy::{
    asset::{AssetEvent, Assets},
    prelude::{Deref, DerefMut, EventReader, Res, ResMut, Resource},
    render::Extract,
};

use crate::shader::RdogShaderAsset;

#[derive(Resource, Deref, DerefMut, Default)]
pub struct RdogShaderCache(pub Vec<RdogShaderAsset>);

#[allow(clippy::type_complexity)]
pub(crate) fn shader(
    mut cache: ResMut<RdogShaderCache>,
    shaders: Extract<Res<Assets<RdogShaderAsset>>>,
    mut events: Extract<EventReader<AssetEvent<RdogShaderAsset>>>,
) {
    for event in events.read() {
        match event {
            AssetEvent::Added { id } | AssetEvent::Modified { id } => {
                if let Some(shader) = shaders.get(*id) {
                    log::info!("Shader added: {:?}", shader.name);
                    cache.push(shader.clone());
                }
            }
            _ => {}
        }
    }
}
