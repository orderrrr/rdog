use std::{mem, ops};

use bevy::{
    prelude::*,
    render::{camera::CameraRenderGraph, renderer::RenderDevice, view::RenderLayers, RenderApp},
};
use event::RdogEvent;
use plugin_config::read_config;
use shader::{
    check_textures, load_shader_libs, load_shaders, RdogShaderAsset, RdogShaderAssetLoader,
    RdogShaderState,
};
use stages::cache::RdogShaderCache;
use state::SyncedState;

use crate::{orbit::PanOrbitState, passes::PassConstructor, Config};

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
            );

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app.insert_resource(SyncedState::default());

            stages::setup(render_app);
            graph::setup(render_app);
        }

        app.add_plugins(RdogReadbackPlugin::default());
    }

    fn finish(&self, app: &mut App) {
        let pr = mem::take(
            &mut app
                .world_mut()
                .resource_mut::<RdogPipelineRegistry>()
                .passes,
        );
        let order = mem::take(&mut app.world_mut().resource_mut::<RdogPipelineRegistry>().order);

        let Some(render_app) = app.get_sub_app_mut(RenderApp) else {
            return;
        };

        let render_device = render_app.world().resource::<RenderDevice>();

        let mut engine = crate::Engine::new(render_device.wgpu_device(), self.0);

        for p in pr {
            engine.register_pass(p);
        }

        engine.pass_registry.set_order(order);

        render_app
            .insert_resource(RdogShaderCache::default())
            .insert_resource(EngineResource(engine));
    }
}

#[derive(Resource)]
pub struct RdogPipelineRegistry {
    pub(crate) passes: Vec<Box<dyn PassConstructor>>,
    pub(crate) order: Vec<String>,
}

impl RdogPipelineRegistry {
    pub fn new(passes: Vec<Box<dyn PassConstructor>>, order: Vec<String>) -> RdogPipelineRegistry {
        RdogPipelineRegistry { passes, order }
    }
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

fn rdog_setup_scene(mut commands: Commands) {
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
