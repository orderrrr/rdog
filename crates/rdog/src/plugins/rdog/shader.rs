use std::{borrow::Cow, ops::Deref};

use bevy::{
    asset::{
        io::Reader, Asset, AssetEvent, AssetLoader, AssetServer, AsyncReadExt, Handle, LoadContext,
        LoadedFolder,
    },
    log::info,
    prelude::{Commands, Deref, DerefMut, EventReader, NextState, Res, ResMut, Resource, States},
    reflect::TypePath,
};
use thiserror::Error;

#[derive(Debug, Clone, Copy, Default, PartialEq, Eq, Hash, States)]
pub enum RdogShaderState {
    #[default]
    Setup,
    PartiallyComplete,
    Finished,
}

#[derive(Resource, Clone, Default, Deref, DerefMut)]
pub struct RdogShaderFolder(Handle<LoadedFolder>);

#[derive(Resource, Clone, Default, Deref, DerefMut)]
pub struct RdogShaderLibFolder(Handle<LoadedFolder>);

#[derive(Asset, TypePath, Debug, Clone)]
pub struct RdogShaderAsset {
    pub name: String,
    pub data: FType,
    pub stype: ShaderType,
}

#[derive(Debug, Clone)]
pub enum ShaderType {
    Lib,
    Shader,
}

impl RdogShaderAsset {
    pub fn new(name: String, data: FType, stype: ShaderType) -> Self {
        Self { name, data, stype }
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

        let mut data = match load_context.path().extension().unwrap().to_str().unwrap() {
            "spv" => RdogShaderAsset::read_spv(reader).await?,
            "wgsl" => RdogShaderAsset::read_wgsl(reader).await?,
            _ => panic!("how did I get here?"),
        };

        let stype = match &mut data {
            FType::Wgsl(s) => {
                if s.contains("#define_import_path") {
                    *s = s.replace("//* ", "").into(); // TODO - remove when https://github.com/wgsl-analyzer/wgsl-analyzer/pull/74 or similar merged
                    ShaderType::Lib
                } else {
                    *s = s.replace("//* ", "").into(); // TODO - remove when https://github.com/wgsl-analyzer/wgsl-analyzer/pull/74 or similar merged
                    ShaderType::Shader
                }
            }
            _ => ShaderType::Shader,
        };

        Ok(RdogShaderAsset::new(name, data, stype))
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

pub fn load_shader_libs(asset_server: Res<AssetServer>, mut commands: Commands) {
    let handles: Handle<LoadedFolder> = asset_server.load_folder("imports/");
    commands.insert_resource(RdogShaderLibFolder(handles));
}

pub fn check_textures(
    mut next_state: ResMut<NextState<RdogShaderState>>,
    rdog_shader_folder: Res<RdogShaderFolder>,
    rdog_shader_lib_folder: Res<RdogShaderLibFolder>,
    mut events: EventReader<AssetEvent<LoadedFolder>>,
) {
    for event in events.read() {
        if event.is_loaded_with_dependencies(&rdog_shader_folder.0)
            || event.is_loaded_with_dependencies(&rdog_shader_lib_folder.0)
        {
            info!("event");
            match next_state.deref() {
                NextState::Pending(RdogShaderState::PartiallyComplete) => {
                    next_state.set(RdogShaderState::Finished)
                }
                _ => next_state.set(RdogShaderState::PartiallyComplete),
            }
        }
    }
}

#[derive(Clone, Debug)]
pub enum FType {
    Wgsl(Cow<'static, str>),
    Spv(Cow<'static, [u8]>),
}
