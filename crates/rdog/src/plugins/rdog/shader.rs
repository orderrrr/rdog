use std::borrow::Cow;

use bevy::{
    asset::{
        io::Reader, Asset, AssetEvent, AssetLoader, AssetServer, AsyncReadExt, Handle, LoadContext,
        LoadedFolder,
    },
    ecs::observer::Trigger,
    log::info,
    prelude::{Commands, Deref, DerefMut, EventReader, NextState, Res, ResMut, Resource, States},
    reflect::TypePath,
};
use thiserror::Error;

use crate::readback::{Readback, ReadbackComplete};

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
    pub data: FType,
}

impl RdogShaderAsset {
    pub fn new(name: String, data: FType) -> Self {
        Self { name, data }
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

        let name = fname
            .replace("-", "_")
            .replace(".spv", "")
            .replace(".wgsl", "");

        let data = match load_context.path().extension().unwrap().to_str().unwrap() {
            "spv" => RdogShaderAsset::read_spv(reader).await?,
            "wgsl" => RdogShaderAsset::read_wgsl(reader).await?,
            _ => panic!("how did I get here?"),
        };

        Ok(RdogShaderAsset::new(name, data))
    }

    fn extensions(&self) -> &[&str] {
        &["spv", "wgsl"]
    }
}

impl RdogShaderAsset {
    async fn read_spv(reader: &mut dyn Reader) -> Result<FType, CustomAssetLoaderError> {
        let mut bytes = Vec::new();
        reader.read_to_end(&mut bytes).await?;
        Ok(FType::Spv(bytes.into()))
    }

    async fn read_wgsl(reader: &mut dyn Reader) -> Result<FType, CustomAssetLoaderError> {
        let mut bytes = String::new();
        reader.read_to_string(&mut bytes).await?;
        Ok(FType::Wgsl(bytes.into()))
    }
}

pub fn load_shaders(asset_server: Res<AssetServer>, mut commands: Commands) {
    let handles: Handle<LoadedFolder> = asset_server.load_folder("shaders/");
    commands.insert_resource(RdogShaderFolder(handles));
}

pub fn check_textures(
    mut next_state: ResMut<NextState<RdogShaderState>>,
    rdog_shader_folder: Res<RdogShaderFolder>,
    mut events: EventReader<AssetEvent<LoadedFolder>>,
) {
    // Advance the `AppState` once all sprite handles have been loaded by the `AssetServer`
    for event in events.read() {
        if event.is_loaded_with_dependencies(&rdog_shader_folder.0) {
            next_state.set(RdogShaderState::Finished);
        }
    }
}

#[derive(Clone, Debug)]
pub enum FType {
    Wgsl(Cow<'static, str>),
    Spv(Cow<'static, [u8]>),
}
