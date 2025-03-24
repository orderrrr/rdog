use crate::{passes::Passes, CameraHandle};
use bevy::prelude::*;
use std::collections::HashMap;

#[derive(Resource, TypePath, Default, Debug, DerefMut, Deref)]
pub struct RdogPassResource(pub HashMap<CameraHandle, Passes>);
