use bevy::prelude::Component;

/// This is a component that can be attached into Bevy's `Camera`; when not
/// attached, the default configuration is used.
#[derive(Clone, Debug, Default, Component)]
pub struct RdogCamera {
    pub mode: crate::CameraMode,
}
