pub mod cache;
pub mod extract;
pub mod prepare;

use bevy::prelude::*;
use bevy::render::{Render, RenderSet};

use super::shader::RdogShaderState;

pub(crate) fn setup(render_app: &mut SubApp) {
    render_app.add_systems(
        ExtractSchedule,
        extract::images.in_set(RenderSet::ExtractCommands),
    );
    render_app.add_systems(
        ExtractSchedule,
        extract::events.in_set(RenderSet::ExtractCommands),
    );
    render_app.add_systems(
        ExtractSchedule,
        extract::cameras.in_set(RenderSet::ExtractCommands),
    );
    render_app.add_systems(
        ExtractSchedule,
        extract::config.in_set(RenderSet::ExtractCommands),
    );
    render_app.add_systems(
        ExtractSchedule,
        extract::extras.in_set(RenderSet::ExtractCommands),
    );
    render_app.add_systems(
        ExtractSchedule,
        cache::shader.in_set(RenderSet::ExtractCommands),
    );

    render_app.add_systems(Render, prepare::images.in_set(RenderSet::Prepare));
    render_app.add_systems(Render, prepare::cameras.in_set(RenderSet::Prepare));
    render_app.add_systems(Render, prepare::extras.in_set(RenderSet::Prepare));
    render_app.add_systems(
        Render,
        prepare::parse_shaders
            .run_if(in_state(RdogShaderState::Finished))
            .in_set(RenderSet::PrepareResourcesFlush),
    );
    render_app.add_systems(
        Render,
        prepare::flush.in_set(RenderSet::PrepareResourcesFlush),
    );
}
