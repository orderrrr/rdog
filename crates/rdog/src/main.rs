use std::f32::consts::PI;

use bevy::{
    color::palettes::css::{
        BLACK, BLUE, FUCHSIA, GREEN, HOT_PINK, LIME, NAVY, ORANGE, ORANGE_RED, PURPLE, RED, TEAL,
        TURQUOISE, YELLOW,
    },
    gizmos::{self, GizmoPlugin},
    math::VectorSpace,
    prelude::*,
    render::{camera::CameraRenderGraph, view::RenderLayers},
    window::WindowResolution,
};

use bevy_egui::EguiPlugin;
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState},
    orbit::PanOrbitSettings,
    shader::RdogShaderState,
    RdogPlugin,
};
use rdog_lib::{LIGHT_POS, LIGHT_RAD};

pub const W: u32 = 640;
pub const H: u32 = 480;

pub const GIZMO: usize = 1;
pub const MAIN: usize = 0;

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
            ((pan_orbit_camera, update_bevy_cam).run_if(any_with_component::<PanOrbitState>),),
        )
        .add_systems(Update, draw_gizmos)
        .run();
}

fn setup_camera(mut commands: Commands, mut config_store: ResMut<GizmoConfigStore>) {
    log::info!("Camera being setup");

    let mut state = PanOrbitState::default();
    state.center = Vec3::Y;
    state.radius = 4.0;
    state.pitch = 15.0_f32.to_radians();
    state.yaw = 30.0_f32.to_radians();

    commands.spawn((
        RenderLayers::layer(MAIN),
        Camera3d::default(),
        state,
        Transform::from_xyz(0., 1.5, 6.).looking_at(Vec3::ZERO, Vec3::Y),
        Camera {
            hdr: true,
            order: -1,
            ..default()
        },
        CameraRenderGraph::new(rdog::graph::Rdog),
    ));

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

fn draw_gizmos(mut gizmos: Gizmos) {
    gizmos.sphere(LIGHT_POS, LIGHT_RAD, PURPLE);
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
