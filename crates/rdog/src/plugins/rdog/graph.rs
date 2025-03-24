use bevy::{
    core_pipeline::upscaling::UpscalingNode,
    prelude::*,
    render::render_graph::{RenderGraphApp, RenderLabel, RenderSubGraph, ViewNodeRunner},
};

use super::rendering::RdogRenderingNode;

#[derive(Debug, Hash, PartialEq, Eq, Clone, RenderSubGraph)]
pub struct Rdog;

#[derive(Debug, Hash, PartialEq, Eq, Clone, RenderLabel)]
pub enum RdogE {
    Rendering,
    ToneMapping,
    FXAA,
    Upscaling,
    RBRenderingNode,
}

pub(crate) fn setup(render_app: &mut SubApp) {
    render_app
        .add_render_sub_graph(Rdog)
        .add_render_graph_node::<ViewNodeRunner<RdogRenderingNode>>(Rdog, RdogE::Rendering)
        .add_render_graph_node::<ViewNodeRunner<UpscalingNode>>(Rdog, RdogE::Upscaling)
        .add_render_graph_edges(Rdog, (RdogE::Rendering, RdogE::Upscaling));
}
