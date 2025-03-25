use std::{collections::HashMap, mem};

use bevy::render::render_resource::Texture as BevyTexture;
use bevy::{prelude::Image as BevyImage, utils::default};

use bevy::asset::AssetId;
use derivative::Derivative;
use glam::{uvec2, vec4, Vec4};
use guillotiere::{size2, Allocation, AtlasAllocator};
use log::warn;

use super::buffers::bindable::Bindable;
use super::buffers::texture::Texture;

#[derive(Derivative)]
#[derivative(Debug)]
pub struct Images {
    #[derivative(Debug = "ignore")]
    atlas: AtlasAllocator,
    atlas_texture: Texture,
    atlas_changes: Vec<AtlasChange>,
    images: HashMap<AssetId<BevyImage>, Allocation>,
    dynamic_textures: Vec<(BevyTexture, Allocation)>,
}

impl Images {
    const ATLAS_WIDTH: u32 = 8192;
    const ATLAS_HEIGHT: u32 = 8192;

    pub fn new(device: &wgpu::Device) -> Self {
        let atlas = AtlasAllocator::new(size2(Self::ATLAS_WIDTH as i32, Self::ATLAS_HEIGHT as i32));

        let atlas_texture = Texture::builder("atlas")
            .with_size(uvec2(Self::ATLAS_WIDTH, Self::ATLAS_HEIGHT))
            .with_format(wgpu::TextureFormat::Rgba8UnormSrgb)
            .with_usage(wgpu::TextureUsages::TEXTURE_BINDING)
            .with_usage(wgpu::TextureUsages::COPY_DST)
            .build(device);

        Self {
            atlas,
            atlas_texture,
            atlas_changes: default(),
            images: default(),
            dynamic_textures: default(),
        }
    }

    pub fn insert(&mut self, handle: AssetId<BevyImage>, item: Image) {
        let size = size2(
            item.texture_descriptor.size.width as i32,
            item.texture_descriptor.size.height as i32,
        );

        let alloc = if let Some(alloc) = self.images.get(&handle) {
            if size == alloc.rectangle.size() {
                Some(*alloc)
            } else {
                self.atlas.deallocate(alloc.id);
                self.atlas.allocate(size)
            }
        } else {
            self.atlas.allocate(size)
        };

        let Some(alloc) = alloc else {
            // TODO allocate new atlas, up to 16 (Metal's limit)
            warn!(
                "Cannot add image `{:?}` - no more space in the atlas",
                handle
            );

            return;
        };

        self.images.insert(handle, alloc);

        match item.data {
            data @ (ImageData::Raw { .. }
            | ImageData::Texture {
                is_dynamic: false, ..
            }) => {
                self.atlas_changes.push(AtlasChange::Set {
                    x: alloc.rectangle.min.x as u32,
                    y: alloc.rectangle.min.y as u32,
                    w: alloc.rectangle.width() as u32,
                    h: alloc.rectangle.height() as u32,
                    data,
                });
            }

            ImageData::Texture {
                texture,
                is_dynamic: true,
            } => {
                self.dynamic_textures.push((texture, alloc));
            }
        }
    }

    pub fn remove(&mut self, handle: AssetId<BevyImage>) {
        let Some(alloc) = self.images.remove(&handle) else {
            return;
        };

        self.atlas.deallocate(alloc.id);
    }

    pub fn lookup(&self, handle: AssetId<BevyImage>) -> Option<Vec4> {
        self.images.get(&handle).map(|alloc| {
            vec4(
                alloc.rectangle.min.x as f32 / (Self::ATLAS_WIDTH as f32),
                alloc.rectangle.min.y as f32 / (Self::ATLAS_HEIGHT as f32),
                alloc.rectangle.width() as f32 / (Self::ATLAS_WIDTH as f32),
                alloc.rectangle.height() as f32 / (Self::ATLAS_HEIGHT as f32),
            )
        })
    }

    pub fn flush(&mut self, device: &wgpu::Device, queue: &wgpu::Queue) {
        let mut encoder = None;

        for change in mem::take(&mut self.atlas_changes) {
            match change {
                AtlasChange::Set { x, y, w, h, data } => {
                    let size = wgpu::Extent3d {
                        width: w,
                        height: h,
                        depth_or_array_layers: 1,
                    };

                    match data {
                        ImageData::Raw { data } => {
                            queue.write_texture(
                                wgpu::ImageCopyTexture {
                                    texture: self.atlas_texture.tex(),
                                    mip_level: 0,
                                    origin: wgpu::Origin3d { x, y, z: 0 },
                                    aspect: wgpu::TextureAspect::All,
                                },
                                &data,
                                wgpu::ImageDataLayout {
                                    offset: 0,
                                    bytes_per_row: Some(w * 4),
                                    rows_per_image: None,
                                },
                                wgpu::Extent3d {
                                    width: w,
                                    height: h,
                                    depth_or_array_layers: 1,
                                },
                            );
                        }

                        ImageData::Texture { texture, .. } => {
                            let encoder = encoder.get_or_insert_with(|| {
                                device.create_command_encoder(&wgpu::CommandEncoderDescriptor {
                                    label: Some("rdog_atlas"),
                                })
                            });

                            encoder.copy_texture_to_texture(
                                texture.as_image_copy(),
                                wgpu::ImageCopyTexture {
                                    texture: self.atlas_texture.tex(),
                                    mip_level: 0,
                                    origin: wgpu::Origin3d { x, y, z: 0 },
                                    aspect: wgpu::TextureAspect::All,
                                },
                                size,
                            );
                        }
                    }
                }
            }
        }

        for (tex, alloc) in &self.dynamic_textures {
            let encoder = encoder.get_or_insert_with(|| {
                device.create_command_encoder(&wgpu::CommandEncoderDescriptor {
                    label: Some("rdog_atlas"),
                })
            });

            encoder.copy_texture_to_texture(
                tex.as_image_copy(),
                wgpu::ImageCopyTexture {
                    texture: self.atlas_texture.tex(),
                    mip_level: 0,
                    origin: wgpu::Origin3d {
                        x: alloc.rectangle.min.x as u32,
                        y: alloc.rectangle.min.y as u32,
                        z: 0,
                    },
                    aspect: wgpu::TextureAspect::All,
                },
                wgpu::Extent3d {
                    width: alloc.rectangle.size().width as u32,
                    height: alloc.rectangle.size().height as u32,
                    depth_or_array_layers: 1,
                },
            )
        }

        if let Some(encoder) = encoder {
            queue.submit([encoder.finish()]);
        }
    }

    pub fn bind_atlas(&self) -> impl Bindable + '_ {
        self.atlas_texture.bind_sampled()
    }
}

#[derive(Debug)]
pub struct Image {
    pub(crate) data: ImageData,
    pub(crate) texture_descriptor: wgpu::TextureDescriptor<'static>,

    // TODO propagate sampler's addressing modes to the shader so that we know
    //      whether the texture should be repeated, etc.
    pub(crate) _sampler_descriptor: wgpu::SamplerDescriptor<'static>,
}

impl Image {
    pub fn new(
        data: ImageData,
        texture_descriptor: wgpu::TextureDescriptor<'static>,
        sampler_descriptor: wgpu::SamplerDescriptor<'static>,
    ) -> Self {
        assert_eq!(texture_descriptor.dimension, wgpu::TextureDimension::D2);

        Self {
            data,
            texture_descriptor,
            _sampler_descriptor: sampler_descriptor,
        }
    }
}

#[derive(Debug)]
pub enum ImageData {
    Raw {
        data: Vec<u8>,
    },
    Texture {
        texture: BevyTexture,
        is_dynamic: bool,
    },
}

#[derive(Derivative)]
#[derivative(Debug)]
enum AtlasChange {
    Set {
        x: u32,
        y: u32,
        w: u32,
        h: u32,

        #[derivative(Debug = "ignore")]
        data: ImageData,
    },
}
