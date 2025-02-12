use std::fs;

use thiserror::Error;

use crate::Config;

#[non_exhaustive]
#[derive(Debug, Error)]
pub enum ConfigError {
    /// An [IO](std::io) Error
    #[error("Could not load asset: {0}")]
    Io(#[from] std::io::Error),
    #[error("Could not load asset: {0}")]
    SerdeError(#[from] serde_json::Error),
}

pub fn read_config() -> Result<Config, ConfigError> {
    let f = fs::read("crates/rdog/assets/config.json")?;
    Ok(serde_json::from_slice(&f)?)
}
