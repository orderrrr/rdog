use bevy::{prelude::*, window::WindowResolution};

use bevy_egui::EguiPlugin;
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState},
    DebugConfig, RdogDebugPlugin, RdogPlugin,
};

pub const W: u32 = 640;
pub const H: u32 = 480;

fn main() {
    App::new()
        .insert_resource(DebugConfig::default())
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
            RdogDebugPlugin,
            EguiPlugin,
        ))
        .add_systems(
            Update,
            ((pan_orbit_camera).run_if(any_with_component::<PanOrbitState>),),
        )
        .run();
}
