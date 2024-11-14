use bevy::{
    prelude::*,
    render::{
        render_graph::{NodeRunError, RenderGraphContext, ViewNode},
        renderer::RenderContext,
        view::ViewTarget,
    },
};

use crate::plugin::{state::SyncedState, EngineResource};

#[derive(Default)]
pub struct RdogRenderingNode;

impl ViewNode for RdogRenderingNode {
    type ViewQuery = &'static ViewTarget;

    fn run(
        &self,
        graph: &mut RenderGraphContext,
        render_context: &mut RenderContext,
        target: &ViewTarget,
        world: &World,
    ) -> Result<(), NodeRunError> {
        let entity = graph.view_entity();
        let engine = world.resource::<EngineResource>();
        let state = world.resource::<SyncedState>();

        let Some(camera) = state.cameras.get(&entity) else {
            return Ok(());
        };

        engine.render_camera(
            camera.handle,
            render_context.command_encoder(),
            target.main_texture_view(),
        );

        Ok(())
    }
}
