use std::{borrow::Cow, path::Path, string::FromUtf8Error};

use bevy::{
    asset::{io::Reader, Asset, AssetLoader, LoadContext},
    reflect::{GetPath, TypePath},
};
use thiserror::Error;

#[derive(Asset, TypePath, Debug, Clone)]
pub struct RdogShaderAsset {
    pub name: String,
    pub data: String,
}

impl RdogShaderAsset {
    pub fn new(name: String, data: String) -> Self {
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

        let mut bytes = Vec::new();
        reader.read_to_end(&mut bytes).await?;
        let data = String::from_utf8(bytes)?;

        Ok(RdogShaderAsset::new(fname, data))
    }

    fn extensions(&self) -> &[&str] {
        &["spv"]
    }
}
