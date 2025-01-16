use bevy::{prelude::*, render::camera::CameraRenderGraph, window::WindowResolution};

use bevy_egui::EguiPlugin;
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState}, shader::RdogShaderState, RdogPlugin
};

pub const W: u32 = 480;
pub const H: u32 = 480;

fn main() {
    App::new()
        .add_plugins((
            DefaultPlugins
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        resolution: WindowResolution::new(W as f32, H as f32),
                        ..default()
                    }),
                    ..default()
                })
                .set(AssetPlugin {
                    watch_for_changes_override: Some(true),
                    ..Default::default()
                }),
            RdogPlugin(rand::thread_rng().gen_range(0..4_294_967_295)),
            EguiPlugin,
        ))
        .add_systems(OnEnter(RdogShaderState::Finished), setup_camera)
        .add_systems(
            Update,
            (pan_orbit_camera.run_if(any_with_component::<PanOrbitState>),),
        )
        .run();
}

fn setup_camera(mut commands: Commands) {
    log::info!("Camera being setup");

    let mut state = PanOrbitState::default();
    state.center = Vec3::Y;
    state.radius = 4.0;
    state.pitch = 15.0_f32.to_radians();
    state.yaw = 30.0_f32.to_radians();

    commands.spawn((
        Camera3d::default(),
        state,
        Transform::from_xyz(0., 1.5, 6.).looking_at(Vec3::ZERO, Vec3::Y),
        Camera {
            hdr: true,

            ..default()
        },
        CameraRenderGraph::new(rdog::graph::Rdog),
    ));
}
