use std::borrow::Cow;

use bevy::{
    asset::{
        io::Reader, Asset, AssetEvent, AssetLoader, AssetServer, Assets, Handle, LoadContext,
        LoadedFolder,
    },
    prelude::{Commands, Deref, DerefMut, EventReader, NextState, Res, ResMut, Resource, States},
    reflect::TypePath,
};
use thiserror::Error;

#[derive(Debug, Clone, Copy, Default, PartialEq, Eq, Hash, States)]
pub enum RdogShaderState {
    #[default]
    Setup,
    Finished,
}

#[derive(Resource, Clone, Default, Deref, DerefMut)]
pub struct RdogShaderFolder(Handle<LoadedFolder>);

#[derive(Asset, TypePath, Debug, Clone)]
pub struct RdogShaderAsset {
    pub name: String,
    pub data: Cow<'static, [u8]>,
}

impl RdogShaderAsset {
    pub fn new(name: String, data: impl Into<Cow<'static, [u8]>>) -> Self {
        Self {
            name,
            data: data.into(),
        }
    }
}

#[derive(Default)]
pub struct RdogShaderAssetLoader;

/// Possible errors that can be produced by [`CustomAssetLoader`]
#[non_exhaustive]
#[derive(Debug, Error)]
pub enum CustomAssetLoaderError {
    /// An [IO](std::io) Error
    #[error("Could not load asset: {0}")]
    Io(#[from] std::io::Error),
    #[error("Could not load asset: {0}")]
    FromUtf8(#[from] std::string::FromUtf8Error),
}

impl AssetLoader for RdogShaderAssetLoader {
    type Asset = RdogShaderAsset;
    type Settings = ();
    type Error = CustomAssetLoaderError;
    async fn load(
        &self,
        reader: &mut dyn Reader,
        _settings: &(),
        load_context: &mut LoadContext<'_>,
    ) -> Result<Self::Asset, Self::Error> {
        let fname = String::from(load_context.path().file_name().unwrap().to_str().unwrap());

        let mut bytes = Vec::new();
        reader.read_to_end(&mut bytes).await?;

        let name = fname.replace("-", "_").replace(".spv", "");

        Ok(RdogShaderAsset::new(name, bytes))
    }

    fn extensions(&self) -> &[&str] {
        &["spv"]
    }
}

pub fn load_shaders(asset_server: Res<AssetServer>, mut commands: Commands) {
    let handles: Handle<LoadedFolder> = asset_server.load_folder("shaders/rdog_shaders.spvs/");
    commands.insert_resource(RdogShaderFolder(handles));

    // let direct_main: Handle<RdogShaderAsset> = asset_server.load("shaders/rdog_shaders.spvs/direct-main.spv");
    // shaders.insert("direct-main.spv".to_string(), direct_main); // TODO - probably should use int of some kind
}

pub fn check_textures(
    mut next_state: ResMut<NextState<RdogShaderState>>,
    rdog_shader_folder: Res<RdogShaderFolder>,
    mut events: EventReader<AssetEvent<LoadedFolder>>,
) {
    // Advance the `AppState` once all sprite handles have been loaded by the `AssetServer`
    for event in events.read() {
        if event.is_loaded_with_dependencies(&rdog_shader_folder.0) {
            log::error!("updated all?");
            next_state.set(RdogShaderState::Finished);
        }
    }
}

// pub fn create_shader_hashmap(
//     loaded_folders: Res<Assets<LoadedFolder>>,
//     rdog_shader_folder: Res<RdogShaderFolder>,
//     shaders: Res<Assets<RdogShader>>,
// ) {
//     for handle in loaded_folders
//         .get(&rdog_shader_folder.0)
//         .unwrap()
//         .handles
//         .iter()
//     {
//         let id = handle.id().typed_unchecked::<RdogShader>();
//
//         let Some(shader) = shaders.get(id) else {
//             log::warn!(
//                 "{:?} did not resolve to a `Shader` asset.",
//                 handle.path().unwrap()
//             );
//             continue;
//         };
//
//         log::info!("Shader loaded - {}", shader.name);
//     }
// }
