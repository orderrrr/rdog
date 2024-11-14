use bevy::prelude::*;

#[derive(Debug, Event)]
pub enum RdogEvent {
    MarkImageAsDynamic { id: AssetId<Image> },
}
