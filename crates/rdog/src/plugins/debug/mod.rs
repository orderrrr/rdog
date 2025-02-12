use bevy::prelude::*;
use bevy::{app::Plugin, render::view::RenderLayers};
use ray::render_debug_ray;

use crate::orbit::{PanOrbitSettings, PanOrbitState};
use crate::GIZMO;

use super::shader::RdogShaderState;
use serde::{Deserialize, Serialize};
use ui::ui_system;

pub mod ui;
pub mod ray;


#[derive(Debug, Clone, Serialize, Deserialize, Default, PartialEq)]
pub enum SelectedTab {
    #[default]
    Render,
    Materials,
    Lights,
    System,
}

#[derive(Clone, Debug, Resource, Serialize, Deserialize, Default)]
pub struct DebugConfig {
    pub selected_tab: SelectedTab,
    pub pointer_in_egui: bool,
}
pub struct RdogDebugPlugin;

impl Plugin for RdogDebugPlugin {
    fn build(&self, app: &mut App) {
        app
            .insert_resource(DebugConfig::default())
            .add_systems(OnEnter(RdogShaderState::Finished), rdog_debug_setup_scene)
            .add_systems(
                Update,
                (
                    update_bevy_cam.run_if(any_with_component::<PanOrbitState>),
                    render_debug_ray,
                    ui_system,
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
            ..Default::default()
        },
    ));
}
