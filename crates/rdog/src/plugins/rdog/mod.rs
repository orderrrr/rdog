use std::ops;

use bevy::{
    prelude::*,
    render::{
        camera::CameraRenderGraph, renderer::RenderDevice, view::RenderLayers, Render, RenderApp,
    },
    window::WindowResized,
};
use event::RdogEvent;
use plugin_config::read_config;
use shader::{
    check_textures, load_shader_libs, load_shaders, RdogShaderAsset, RdogShaderAssetLoader,
    RdogShaderState,
};
use stages::cache::RdogShaderCache;
use state::SyncedState;

use crate::{orbit::PanOrbitState, rdog_buffers::BufferPlugin, rdog_passes::PassesPlugin, Config};

use super::readback::RdogReadbackPlugin;

pub const GIZMO: usize = 1;
pub const MAIN: usize = 0;

pub mod camera;
pub mod event;
pub mod graph;
pub mod plugin_config;
pub mod rendering;
pub mod shader;
pub mod stages;
pub mod state;

pub struct RdogPlugin(pub u32);

impl Plugin for RdogPlugin {
    fn build(&self, app: &mut App) {
        info!("Rdog plugin init");

        app.add_event::<RdogEvent>()
            .init_state::<RdogShaderState>()
            .init_asset::<RdogShaderAsset>()
            .init_asset_loader::<RdogShaderAssetLoader>()
            .insert_resource(read_config().unwrap_or(Config::default()))
            .add_systems(
                OnEnter(RdogShaderState::Setup),
                (load_shaders, load_shader_libs),
            )
            .add_systems(OnEnter(RdogShaderState::Finished), rdog_setup_scene)
            .add_systems(
                Update,
                (check_textures).run_if(in_state(RdogShaderState::Setup)),
            )
            .add_systems(Update, send_events)
            .add_plugins((BufferPlugin, PassesPlugin));

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app
                .insert_resource(SyncedState::default())
                .add_event::<RdogEvent>()
                .init_resource::<State<RdogShaderState>>()
                .add_event::<RdogStateEvent>()
                .add_systems(Render, events);

            stages::setup(render_app);
            graph::setup(render_app);
        }

        app.add_plugins(RdogReadbackPlugin::default());
    }

    fn finish(&self, app: &mut App) {
        let Some(render_app) = app.get_sub_app_mut(RenderApp) else {
            return;
        };

        let render_device = render_app.world().resource::<RenderDevice>();
        let engine = crate::Engine::new(render_device.wgpu_device(), self.0);

        render_app
            .insert_resource(RdogShaderCache::default())
            .insert_resource(EngineResource(engine));
    }
}

#[derive(Event)]
pub enum RdogStateEvent {
    CameraAdded,
}

#[derive(Resource)]
pub struct EngineResource(crate::Engine);

impl ops::Deref for EngineResource {
    type Target = crate::Engine;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

impl ops::DerefMut for EngineResource {
    fn deref_mut(&mut self) -> &mut Self::Target {
        &mut self.0
    }
}

#[derive(Component)]
pub struct RdogRender;

fn rdog_setup_scene(mut commands: Commands, mut rdog_e: EventWriter<RdogEvent>) {
    log::info!("Camera being setup");

    let state = PanOrbitState::default();

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
        CameraRenderGraph::new(self::graph::Rdog),
        RdogRender,
    ));
}

fn send_events(
    mut buf: EventWriter<RdogEvent>,
    mut resize_reader: EventReader<WindowResized>,
    config: Res<Config>,
) {
    for _ in resize_reader.read() {
        info!("window Changed");
        buf.send(RdogEvent::Recompute);
    }

    if config.reload {
        buf.send(RdogEvent::Recompute);
    }
}
pub fn events(mut events: EventReader<RdogEvent>, mut engine: ResMut<EngineResource>) {
    for e in events.read() {
        if let RdogEvent::Recompute | RdogEvent::RecomputePasses = e {
            engine.dirty = true;
        }
    }
}
