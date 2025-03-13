use std::mem;

use bevy::render::camera::ExtractedCamera as BevyExtractedCamera;
use bevy::render::render_asset::RenderAssets;
use bevy::render::texture::GpuImage;
use bevy::render::view::{ExtractedView, RenderLayers};
use bevy::utils::{Entry, HashSet};
use bevy::{
    prelude::*,
    render::{
        renderer::{RenderDevice, RenderQueue},
        view::ViewTarget,
    },
};
use glam::vec2;
use rdog_lib::Frame;

use crate::event::RdogEvent;
use crate::images::ImageData;
use crate::plugins::rdog::state::{ExtractedImageData, ExtractedImages, SyncedCamera, SyncedState};
use crate::plugins::rdog::EngineResource;
use crate::plugins::rdog_passes::RdogPassResource;
use crate::rdog_buffers::RdogBufferResource;
use crate::state::{ExtractedConfig, RdogExtractedExtras};
use crate::{CameraMode, RdogStateEvent, MAIN};

use super::cache::RdogShaderCache;

pub fn flush(queue: Res<RenderQueue>, mut buffers: ResMut<RdogBufferResource>) {
    for bufferl in buffers.values_mut() {
        for buffer in bufferl.values_mut() {
            buffer.flush(&queue);
        }
    }
}

pub fn parse_shaders(
    device: Res<RenderDevice>,
    mut events: EventWriter<RdogEvent>,
    mut engine: ResMut<EngineResource>,
    cache: ResMut<RdogShaderCache>,
    state: Res<SyncedState>,
) {
    if !cache.is_empty() {
        log::info!("computing shaders");
        state.compute_shaders(&mut engine, &device, &cache);
        events.send(RdogEvent::Recompute);
    }
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
    mut state: ResMut<SyncedState>,
    mut engine: ResMut<EngineResource>,
    buffers: Res<RdogBufferResource>,
    passes: Res<RdogPassResource>,
    config: Res<ExtractedConfig>,
    mut state_event: EventWriter<RdogStateEvent>,
    mut cameras: Query<(
        Entity,
        &ViewTarget,
        &ExtractedView,
        &BevyExtractedCamera,
        &RenderLayers,
    )>,
) {
    let engine = &mut *engine;
    let mut alive_cameras = HashSet::new();

    for (entity, view_target, bevy_ext_view, bevy_ext_camera, layer) in cameras.iter_mut() {
        if *layer != RenderLayers::layer(MAIN) {
            continue;
        }

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

            focus_point: config.camera_config.focus_point,
            focus_dist: config.camera_config.focus_dist,
            aperture: config.camera_config.aperture,
            focal_length: config.camera_config.focal_length.clone(),
        };

        match state.cameras.entry(entity) {
            Entry::Occupied(entry) => {
                let h = entry.get().handle;
                if buffers.contains_key(&h) && passes.contains_key(&h) {
                    engine.update_camera(entry.get().handle, camera);
                }
            }

            Entry::Vacant(entry) => {
                info!("camera created");
                entry.insert(SyncedCamera {
                    handle: engine.create_camera(camera),
                });
                state_event.send(RdogStateEvent::CameraAdded);
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
    extras: Res<RdogExtractedExtras>,
    time: Res<Time>,
) {
    let engine = &mut *engine;
    engine.time = vec2(time.elapsed_secs(), time.delta_secs());
    engine.frame = Frame::new(extras.frame);
    engine.mouse = match extras.mouse {
        Some(x) => x,
        _ => Vec2::ZERO,
    };
}
