use bevy::prelude::*;
use bevy::{app::Plugin, render::view::RenderLayers};
use ray::render_debug_ray;

use crate::orbit::{PanOrbitSettings, PanOrbitState};
use crate::GIZMO;

use super::readback::{Readback, ReadbackComplete};
use super::shader::RdogShaderState;
use serde::{Deserialize, Serialize};
use ui::{ui_system, SelectedTab};

pub mod ray;
pub mod ui;

#[derive(Clone, Debug, Resource, Serialize, Deserialize, Default)]
pub struct DebugConfig {
    pub selected_tab: SelectedTab,
    pub pointer_in_egui: bool,
}

pub struct RdogDebugPlugin;

impl Plugin for RdogDebugPlugin {
    fn build(&self, app: &mut App) {
        app.insert_resource(DebugConfig::default())
            .add_systems(OnEnter(RdogShaderState::Finished), rdog_debug_setup_scene)
            .add_systems(
                Update,
                (
                    update_bevy_cam.run_if(any_with_component::<PanOrbitState>),
                    render_debug_ray,
                    ui_system,
                    readback_test,
                ),
            );
    }

    fn finish(&self, _: &mut App) {}
}

fn update_bevy_cam(
    q_camera: Query<&Transform, (With<Camera3d>, With<PanOrbitSettings>, With<PanOrbitState>)>,
    mut cam: Query<
        &mut Transform,
        (
            With<Camera3d>,
            Without<PanOrbitState>,
            Without<PanOrbitSettings>,
        ),
    >,
) {
    let t_form = q_camera.get_single().unwrap();
    *cam.get_single_mut().unwrap() = t_form.clone();
}

fn rdog_debug_setup_scene(mut commands: Commands, mut config_store: ResMut<GizmoConfigStore>) {
    log::info!("Debug Camera being setup");

    let (gizmo_config, _) = config_store.config_mut::<DefaultGizmoConfigGroup>();
    gizmo_config.render_layers = RenderLayers::layer(GIZMO);

    commands.spawn((
        RenderLayers::layer(GIZMO),
        Camera3d::default(),
        Transform::from_xyz(0., 1.5, 6.).looking_at(Vec3::ZERO, Vec3::Y),
        Camera {
            hdr: true,
            ..default()
        },
    ));
}

pub fn readback_test(buttons: Res<ButtonInput<MouseButton>>, mut commands: Commands) {
    // if buttons.just_pressed(MouseButton::Left) {
    //     commands
    //         .spawn(Readback::buffer("march_readback".to_string()))
    //         .observe(|trigger: Trigger<ReadbackComplete>| {
    //             let data: Vec<u32> = trigger.event().to_shader_type();
    //             info!("Buffer {:?}", data);
    //         });
    // } else {
    //
    // }
}
