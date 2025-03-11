use bevy::{
    prelude::*,
    window::{PresentMode, WindowResolution},
};

use bevy_egui::EguiPlugin;
use pipelines::{
    RasterPassConstructor, ReadbackPassConstructor, TracePassConstructor, VoxelAccelPassConstructor,
};
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState},
    DebugConfig, RdogDebugPlugin, RdogPipelineRegistry, RdogPlugin,
};

pub mod pipelines;

pub const W: u32 = 640;
pub const H: u32 = 480;

fn main() {
    App::new()
        .insert_resource(DebugConfig::default())
        /*
         * Pipeline Registry Plugin for registering plugins from app world.
         * TODO: need a way to specify an order, or better yet a graph for this.
         */
        .insert_resource(RdogPipelineRegistry::new(
            vec![
                Box::new(VoxelAccelPassConstructor),
                Box::new(ReadbackPassConstructor),
                Box::new(TracePassConstructor),
                Box::new(RasterPassConstructor),
            ],
            vec![
                String::from("voxelAccel"),
                String::from("trace"),
                String::from("raster"),
            ],
        ))
        .add_plugins((
            DefaultPlugins
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        name: Some("rdog".to_string()),
                        resolution: WindowResolution::new(W as f32, H as f32),
                        present_mode: PresentMode::AutoNoVsync,
                        ..default()
                    }),
                    ..default()
                })
                .set(AssetPlugin {
                    watch_for_changes_override: Some(true),
                    ..default()
                }),
            RdogPlugin(rand::thread_rng().gen_range(0..4_294_967_295)),
            RdogDebugPlugin,
            EguiPlugin,
        ))
        .add_systems(
            Update,
            pan_orbit_camera.run_if(any_with_component::<PanOrbitState>),
        )
        .run();
}
