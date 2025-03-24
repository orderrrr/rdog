use bevy::prelude::*;

#[derive(Debug, Event, Clone)]
pub enum RdogEvent {
    MarkImageAsDynamic { id: AssetId<Image> },

    RecomputeBuffers,
    RecomputePasses,
    Recompute,
    UpdateBuffers,
}
