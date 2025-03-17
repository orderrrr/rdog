use bevy::utils::HashMap;
use exr::prelude::write_rgba_file;

use bytemuck::cast_slice;
use std::sync::{Arc, Mutex};

use bevy::prelude::*;
use bevy::{app::Plugin, render::view::RenderLayers};

use crate::orbit::{PanOrbitSettings, PanOrbitState};
use crate::{Config, GIZMO};

use super::readback::{Readback, ReadbackComplete};
use super::shader::RdogShaderState;
use serde::{Deserialize, Serialize};
use ui::{ui_system, SelectedTab};

use std::process::Command;

pub mod ui;

#[derive(Clone, Debug, Resource, Serialize, Deserialize, Default)]
pub struct DebugConfig {
    pub selected_tab: SelectedTab,
    pub pointer_in_egui: bool,
    pub point_picker: bool,
    pub change: bool,
}

#[derive(Resource, Default, Deref, DerefMut)]
pub struct ReadbackData(HashMap<String, (Entity, Arc<Mutex<Option<Vec<u32>>>>)>);

pub struct RdogDebugPlugin;

impl Plugin for RdogDebugPlugin {
    fn build(&self, app: &mut App) {
        info!("Debug plugin init");

        app.insert_resource(DebugConfig::default())
            .insert_resource(ReadbackData::default())
            .add_systems(OnEnter(RdogShaderState::Finished), rdog_debug_setup_scene)
            .add_systems(
                Update,
                (
                    update_bevy_cam.run_if(any_with_component::<PanOrbitState>),
                    ui_system,
                    readback_setup,
                    readback_test,
                    readback_poll_system.after(readback_setup),
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

pub fn readback_test(
    buttons: Res<ButtonInput<MouseButton>>,
    mut commands: Commands,
    debug_config: Res<DebugConfig>,
    mut readback_data: ResMut<ReadbackData>,
) {
    if buttons.just_pressed(MouseButton::Right) && !debug_config.pointer_in_egui {
        if let Some(r) = readback_data.get("render_readback") {
            if commands.get_entity(r.0).is_some() {
                return;
            }
        }

        info!("texture readback requested");

        let data: Arc<Mutex<Option<Vec<u32>>>> = Arc::new(Mutex::new(None));
        let data_clone = data.clone();

        let entity = commands
            .spawn(Readback::texture(
                "output_trace".to_string(),
                "render_readback".to_string(),
            ))
            .observe(move |e: Trigger<ReadbackComplete>| {
                let d: Vec<u32> = e.to_shader_type();
                *data_clone.lock().unwrap() = Some(d);
            })
            .id();

        *readback_data
            .entry("render_readback".to_string())
            .or_insert((entity, data.clone())) = (entity, data.clone());

        return;
    }
}

pub fn readback_setup(
    buttons: Res<ButtonInput<MouseButton>>,
    mut commands: Commands,
    mut debug_config: ResMut<DebugConfig>,
    mut readback_data: ResMut<ReadbackData>,
) {
    if buttons.just_pressed(MouseButton::Left)
        && debug_config.point_picker
        && !debug_config.pointer_in_egui
    {
        debug_config.point_picker = false;
        debug_config.change = true;

        if let Some(r) = readback_data.get("march_readback") {
            if commands.get_entity(r.0).is_some() {
                debug_config.change = false;
                return;
            }
        }

        info!("system requested");

        let data: Arc<Mutex<Option<Vec<u32>>>> = Arc::new(Mutex::new(None));
        let data_clone = data.clone();

        let entity = commands
            .spawn(Readback::buffer(
                "readback".to_string(),
                "march_readback".to_string(),
            ))
            .observe(move |e: Trigger<ReadbackComplete>| {
                let d: Vec<u32> = e.to_shader_type();
                *data_clone.lock().unwrap() = Some(d);
            })
            .id();

        *readback_data
            .entry("march_readback".to_string())
            .or_insert((entity, data.clone())) = (entity, data.clone());

        return;
    }

    if debug_config.point_picker && !debug_config.pointer_in_egui {
        debug_config.change = true;

        if let Some(r) = readback_data.get("march_readback") {
            if commands.get_entity(r.0).is_some() {
                debug_config.change = false;
                return;
            }
        }

        let data: Arc<Mutex<Option<Vec<u32>>>> = Arc::new(Mutex::new(None));
        let data_clone = data.clone();

        let entity = commands
            .spawn(Readback::buffer(
                "readback".to_string(),
                "march_readback".to_string(),
            ))
            .observe(move |e: Trigger<ReadbackComplete>| {
                let d: Vec<u32> = e.to_shader_type();
                *data_clone.lock().unwrap() = Some(d);
            })
            .id();

        *readback_data
            .entry("march_readback".to_string())
            .or_insert((entity, data.clone())) = (entity, data.clone());

        return;
    }

    debug_config.change = false;
}

pub fn readback_poll_system(
    mut commands: Commands,
    mut config: ResMut<Config>,
    debug_config: Res<DebugConfig>,
    readback_data: Res<ReadbackData>,
) {
    config.reload = config.reload || debug_config.change;

    for (k, v) in readback_data.iter() {
        if let Some(b) = v.1.lock().unwrap().take() {
            match k.as_str() {
                "march_readback" => {
                    let vec4_slice: &[Vec4] = cast_slice(&b);
                    let out: Vec4 = vec4_slice[0];

                    info!("march_readback data: {:?}", out);

                    config.camera_config.focus_point = out.xyz();

                    if let Some(mut e) = commands.get_entity(v.0) {
                        e.despawn();
                    }

                    config.camera_config.focus_dist = out.w;
                }
                "render_readback" => {
                    let vec4_slice: &[Vec4] = cast_slice(&b);
                    let out: Vec<Vec4> = vec4_slice.into();

                    write_rgba_file(
                        "out.exr",
                        config.output_res.x as usize,
                        config.output_res.y as usize,
                        |x, y| {
                            // TODO: continue, get the correct pixel dimensions, and probably should do this in its own thread.
                            let p = out[x + y * config.output_res.x as usize];
                            (p.x, p.y, p.z, 1.0)
                        },
                    )
                    .unwrap();

                    Command::new("open")
                        .arg("/Users/nmcintosh/dev/prs/bevy_radiance/rdog/out.exr")
                        .spawn()
                        .expect("failed to execute child");

                    if let Some(mut e) = commands.get_entity(v.0) {
                        e.despawn();
                    }
                }
                _ => (),
            }
        }
    }
}
