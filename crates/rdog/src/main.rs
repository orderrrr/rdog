use bevy::{
    color::palettes::css::{BLUE, PURPLE, RED},
    prelude::*,
    render::{
        camera::{CameraProjection, CameraRenderGraph},
        view::RenderLayers,
    },
    window::{PrimaryWindow, WindowResolution},
};

use bevy_egui::EguiPlugin;
use glam::uvec2;
use rand::Rng;
use rdog::{
    interface::orbit::{pan_orbit_camera, PanOrbitState},
    orbit::PanOrbitSettings,
    shader::RdogShaderState,
    Config, RdogPlugin,
};
use rdog_lib::{Camera as C, Globals, Material, PassParams, Ray, Scene, LIGHT_POS, LIGHT_RAD};
use serde::{Deserialize, Serialize};

pub const W: u32 = 640;
pub const H: u32 = 480;

pub const GIZMO: usize = 1;
pub const MAIN: usize = 0;

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
            EguiPlugin,
        ))
        .add_systems(OnEnter(RdogShaderState::Finished), setup_camera)
        .add_systems(
            Update,
            ((pan_orbit_camera, update_bevy_cam).run_if(any_with_component::<PanOrbitState>),),
        )
        .add_systems(Update, (draw_gizmos, render_debug_ray))
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

fn render_debug_ray(
    mut dconf: ResMut<DebugConfig>,
    config: ResMut<Config>,

    mut gizmos: Gizmos,

    q_windows: Query<&Window, With<PrimaryWindow>>,

    mouse: Res<ButtonInput<MouseButton>>,

    cameras: Query<(&Projection, &Transform, &PanOrbitState)>,
) {
    if !config.ray_debug {
        return;
    }

    if mouse.just_pressed(MouseButton::Left) {
        dconf.i += 1;

        for (p, t, _) in cameras.iter() {
            dconf.ndc = t.compute_matrix() * p.get_clip_from_view().inverse();
            dconf.uv = q_windows.get_single().unwrap().cursor_position().unwrap();
        }

        if dconf.i >= 8 {
            dconf.i = 0;
        }
    }

    let c = C::new_blank(uvec2(W, H).as_vec2().extend(0.0).extend(0.0));
    let g = Globals {
        time: Vec2::ZERO,
        seed: UVec2::ZERO,
    };
    let p = PassParams::new(Vec2::ZERO, 8, 8, 0);
    let m: Vec<Material> = config
        .material_tree
        .mats
        .iter()
        .map(|x| x.to_shader())
        .collect();

    let scene = Scene::new(&c, &g, &m, &p, 4, true, true, true);

    let mut ray = Ray::ray(
        uvec2(W, H).as_vec2(),
        dconf.ndc,
        dconf.uv,
        UVec2::splat(0),
        0,
    );
    let mut prev_ray = ray.clone();

    for _ in 0..8 {
        let h = scene.debug_rt(&mut ray);
        // if dconf.i == i {
        gizmos.arrow(prev_ray.o, ray.o, if h.interior() { RED } else { BLUE });
        // }
        prev_ray = ray.clone();
    }
}

#[derive(Clone, Debug, Resource, Serialize, Deserialize, Default)]
pub struct DebugConfig {
    pub i: u32,
    pub ndc: Mat4,
    pub uv: Vec2,
    pub pressed: bool,
}

pub trait DebugRt {
    fn debug_rt(&self, r: &mut Ray) -> Material;
}

impl DebugRt for Scene<'_> {
    fn debug_rt(&self, r: &mut Ray) -> Material {
        let h = self.trace(r);
        r.mv(h.dist());

        {
            if !h.valid() {
                return h;
            }
            if h.emissive() > 0.0 {
                return h;
            }
        }

        // let (eta, n) = if h.interior() {
        //     (1.0 / h.ior(), h.normal())
        //     // (self.ior(), self.normal())
        // } else {
        //     (h.ior() / 1.0, h.normal())
        // };
        // let ud = r.d.normalize();
        // let dir = self.refract(ud, n, eta);

        let l = h.scatter(self, r);

        r.dir(l.dir);

        return h;
    }
}
