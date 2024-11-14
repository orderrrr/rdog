#![feature(inline_const)] 

use bevy::{prelude::*, render::camera::CameraRenderGraph, window::WindowResolution};
use rdog::RdogPlugin;

pub const W: u32 = 1920;
pub const H: u32 = 1080;

fn main() {
    App::new()
        .add_plugins((
            DefaultPlugins.set(WindowPlugin {
                primary_window: Some(Window {
                    resolution: WindowResolution::new(W as f32, H as f32),
                    ..default()
                }),
                ..default()
            }),
            RdogPlugin,
        ))
        .add_systems(Startup, setup_camera)
        .run();
}

fn setup_camera(mut commands: Commands) {
    commands.spawn(Camera3dBundle {
        camera_render_graph: CameraRenderGraph::new(rdog::graph::Rdog),
        camera: Camera {
            hdr: true,
            ..default()
        },
        ..default()
    });
}
