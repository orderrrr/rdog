#[macro_export]
macro_rules! create_render_plugin {
    ($plugin_name:ident, $($systems:expr),+ $(,)?) => {
        pub struct $plugin_name;

        impl bevy::app::Plugin for $plugin_name {
            fn build(&self, app: &mut bevy::prelude::App) {
                use bevy::prelude::*;

                info!("Initializing render plugin: {}", stringify!($plugin_name));

                if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
                    render_app.add_systems(
                        Render,
                        ($($systems),+)
                            .chain()
                            .in_set(RenderSet::Prepare)
                            .run_if(in_state(RdogShaderState::Finished)),
                    );
                }
            }
        }
    };
}

