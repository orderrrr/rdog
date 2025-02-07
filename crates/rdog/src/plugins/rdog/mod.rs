use std::{fs, ops};

use bevy::{
    prelude::*,
    render::{camera::CameraRenderGraph, renderer::RenderDevice, view::RenderLayers, RenderApp},
};
use event::RdogEvent;
use shader::{
    check_textures, load_shaders, RdogShaderAsset, RdogShaderAssetLoader, RdogShaderState,
};
use stages::cache::RdogShaderCache;
use state::SyncedState;
use thiserror::Error;
use ui::ui_system;

use crate::{orbit::PanOrbitState, Config};

pub const GIZMO: usize = 1;
pub const MAIN: usize = 0;

pub mod camera;
pub mod event;
pub mod graph;
pub mod rendering;
pub mod shader;
pub mod stages;
pub mod state;
pub mod ui;

pub struct RdogPlugin(pub u32);

impl Plugin for RdogPlugin {
    fn build(&self, app: &mut App) {
        app.add_event::<RdogEvent>()
            .init_state::<RdogShaderState>()
            .init_asset::<RdogShaderAsset>()
            .init_asset_loader::<RdogShaderAssetLoader>()
            .insert_resource(read_config().unwrap_or(Config::default()))
            .add_systems(OnEnter(RdogShaderState::Setup), load_shaders)
            .add_systems(OnEnter(RdogShaderState::Finished), rdog_setup_scene)
            .add_systems(
                Update,
                check_textures.run_if(in_state(RdogShaderState::Setup)),
            )
            .add_systems(Update, ui_system);

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app.insert_resource(SyncedState::default());

            stages::setup(render_app);
            graph::setup(render_app);
        }
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

#[non_exhaustive]
#[derive(Debug, Error)]
pub enum ConfigError {
    /// An [IO](std::io) Error
    #[error("Could not load asset: {0}")]
    Io(#[from] std::io::Error),
    #[error("Could not load asset: {0}")]
    SerdeError(#[from] serde_json::Error),
}

pub fn read_config() -> Result<Config, ConfigError> {
    let f = fs::read("crates/rdog/assets/config.json")?;
    Ok(serde_json::from_slice(&f)?)
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

fn rdog_setup_scene(mut commands: Commands) {
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
        CameraRenderGraph::new(self::graph::Rdog),
    ));
}
