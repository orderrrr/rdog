use std::mem;

use bevy::render::camera::ExtractedCamera as BevyExtractedCamera;
use bevy::render::render_asset::RenderAssets;
use bevy::render::texture::GpuImage;
use bevy::render::view::ExtractedView;
use bevy::utils::{Entry, HashSet};
use bevy::{
    prelude::*,
    render::{
        renderer::{RenderDevice, RenderQueue},
        view::ViewTarget,
    },
};
use glam::vec2;

use crate::images::ImageData;
use crate::plugins::rdog::state::{ExtractedImageData, ExtractedImages, SyncedCamera, SyncedState};
use crate::plugins::rdog::EngineResource;
use crate::state::ExtractedConfig;
use crate::CameraMode;

use super::cache::RdogShaderCache;

pub fn flush(
    device: Res<RenderDevice>,
    queue: Res<RenderQueue>,
    mut engine: ResMut<EngineResource>,
    cache: ResMut<RdogShaderCache>,
    mut state: ResMut<SyncedState>,
) {
    if !cache.is_empty() {
        log::info!("computing shaders");
        state.compute_shaders(&mut engine, &device, &cache);
    }

    state.tick(&mut engine, &device, &queue);
}

pub fn images(
    mut engine: ResMut<EngineResource>,
    textures: Res<RenderAssets<GpuImage>>,
    mut images: ResMut<ExtractedImages>,
) {
    for handle in &images.removed {
        engine.remove_image(*handle);
    }

    for entry in mem::take(&mut images.changed) {
        if entry.texture_descriptor.dimension != wgpu::TextureDimension::D2 {
            continue;
        }

        let data = match entry.data {
            ExtractedImageData::Raw { data } => ImageData::Raw { data },

            ExtractedImageData::Texture { is_dynamic } => ImageData::Texture {
                texture: textures.get(entry.handle).unwrap().texture.clone(),
                is_dynamic,
            },
        };

        // TODO we should add only those images which are used by at least one
        //      material, since otherwise we'll .add_image() textures that are
        //      related solely to UI, for instance
        //
        //      (conversely, we should remove those images which are not in use
        //      by any material)
        //
        //      that's not so easy though because it can happen that an image is
        //      loaded first *and then* (e.g. in next frame) it's used by some
        //      material, in which case a simple condition right here will not
        //      be sufficient
        engine.insert_image(
            entry.handle,
            crate::Image::new(data, entry.texture_descriptor, entry.sampler_descriptor),
        );
    }
}

pub(crate) fn cameras(
    device: Res<RenderDevice>,
    mut state: ResMut<SyncedState>,
    mut engine: ResMut<EngineResource>,
    mut cameras: Query<(Entity, &ViewTarget, &ExtractedView, &BevyExtractedCamera)>,
) {
    let device = device.wgpu_device();
    let state = &mut *state;
    let engine = &mut *engine;
    let mut alive_cameras = HashSet::new();

    for (entity, view_target, bevy_ext_view, bevy_ext_camera) in cameras.iter_mut() {
        let camera = crate::Camera {
            mode: CameraMode::Image,
            viewport: {
                let format = view_target.main_texture_format();

                let Some(size) = bevy_ext_camera.physical_viewport_size else {
                    continue;
                };

                let position = bevy_ext_camera
                    .viewport
                    .as_ref()
                    .map(|v| v.physical_position)
                    .unwrap_or_default();

                crate::CameraViewport {
                    format,
                    size,
                    position,
                }
            },

            transform: bevy_ext_view.world_from_view.compute_matrix(),
            projection: bevy_ext_view.clip_from_view,
        };

        match state.cameras.entry(entity) {
            Entry::Occupied(entry) => {
                engine.update_camera(device, entry.into_mut().handle, camera);
            }

            Entry::Vacant(entry) => {
                entry.insert(SyncedCamera {
                    handle: engine.create_camera(device, camera),
                });
            }
        }

        alive_cameras.insert(entity);
    }

    // -----

    if alive_cameras.len() != state.cameras.len() {
        state.cameras.retain(|entity2, camera2| {
            let is_alive = alive_cameras.contains(entity2);

            if !is_alive {
                engine.delete_camera(camera2.handle);
            }

            is_alive
        });
    }
}

pub(crate) fn extras(
    mut engine: ResMut<EngineResource>,
    config: ResMut<ExtractedConfig>,
    time: Res<Time>,
) {
    let engine = &mut *engine;
    engine.time = vec2(time.elapsed_secs(), time.delta_secs());
    engine.config = config.clone();
}
