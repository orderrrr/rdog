use bevy::{
    image::{ImageSampler, ImageSamplerDescriptor},
    prelude::*,
    render::{
        camera::{CameraProjection, CameraRenderGraph},
        Extract,
    },
    utils::HashSet,
};

use crate::{
    plugins::rdog::{
        camera::RdogCamera,
        event::RdogEvent,
        state::{ExtractedImage, ExtractedImageData, ExtractedImages, RdogExtractedCamera},
    },
    state::ExtractedConfig,
    Config,
};

pub(crate) fn images(
    mut commands: Commands,
    mut events: Extract<EventReader<RdogEvent>>,
    mut asset_events: Extract<EventReader<AssetEvent<Image>>>,
    images: Extract<Res<Assets<Image>>>,
    mut dynamic_images: Local<HashSet<AssetId<Image>>>,
) {
    for event in events.read() {
        match event {
            RdogEvent::MarkImageAsDynamic { id } => {
                dynamic_images.insert(*id);
            }
        }
    }

    // ---

    let mut changed = HashSet::default();
    let mut removed = Vec::new();

    for event in asset_events.read() {
        match event {
            AssetEvent::Added { id } | AssetEvent::Modified { id } => {
                changed.insert(*id);
            }
            AssetEvent::Removed { id } => {
                changed.remove(id);
                removed.push(*id);
                dynamic_images.remove(id);
            }
            AssetEvent::LoadedWithDependencies { .. } => {
                //
            }
            AssetEvent::Unused { .. } => {
                //
            }
        }
    }

    let changed = changed.into_iter().flat_map(|id| {
        let Some(image) = images.get(id) else {
            removed.push(id);
            return None;
        };

        let texture_descriptor = image.texture_descriptor.clone();

        let sampler_descriptor = match &image.sampler {
            ImageSampler::Default => wgpu::SamplerDescriptor {
                label: None,
                ..ImageSamplerDescriptor::nearest().as_wgpu()
            },

            ImageSampler::Descriptor(descriptor) => wgpu::SamplerDescriptor {
                label: None,
                ..descriptor.as_wgpu()
            },
        };

        let data = if dynamic_images.contains(&id) {
            let is_legal = image
                .texture_descriptor
                .usage
                .contains(wgpu::TextureUsages::COPY_SRC);

            assert!(
                is_legal,
                "image `{:?}` was marked as dynamic but it is missing the \
                 COPY_SRC usage - please add that usage and try again",
                id
            );

            ExtractedImageData::Texture { is_dynamic: true }
        } else {
            ExtractedImageData::Raw {
                data: image.data.clone(),
            }
        };

        Some(ExtractedImage {
            handle: id,
            texture_descriptor,
            sampler_descriptor,
            data,
        })
    });

    commands.insert_resource(ExtractedImages {
        changed: changed.collect(),
        removed,
    });
}

#[allow(clippy::type_complexity)]
pub(crate) fn cameras(
    mut commands: Commands,
    cameras: Extract<
        Query<(
            Entity,
            &Camera,
            &CameraRenderGraph,
            &Projection,
            &Transform,
            Option<&RdogCamera>,
        )>,
    >,
) {
    for (entity, camera, _camera_render_graph, projection, transform, rdog_camera) in cameras.iter()
    {
        if !camera.is_active {
            // TODO figure this out // || **camera_render_graph != crate::plugin::graph::Rdog {
            continue;
        }

        assert!(camera.hdr, "Rdog requires an HDR camera");

        if let Some(mut c) = commands.get_entity(entity) {
            c.insert(RdogExtractedCamera {
                transform: transform.compute_matrix(),
                projection: projection.get_clip_from_view(),
                mode: rdog_camera.map(|camera| camera.mode),
            });
        }
    }
}

#[allow(clippy::type_complexity)]
pub(crate) fn config(mut commands: Commands, config: Extract<Res<Config>>) {
    commands.insert_resource(ExtractedConfig(config.clone()));
}
