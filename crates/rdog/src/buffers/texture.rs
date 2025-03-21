use std::sync::Arc;

use super::bindable::Bindable;
use bevy::utils::default;
use glam::{uvec3, UVec2, UVec3};
use log::debug;

#[derive(Debug)]
pub struct Texture {
    pub tex: Arc<wgpu::Texture>,
    pub format: wgpu::TextureFormat,
    view: wgpu::TextureView,
    dimension: wgpu::TextureViewDimension,
    sampler: wgpu::Sampler,
    filterable: bool,
    size: UVec3,
}

impl Texture {
    pub fn builder(label: impl AsRef<str>) -> TextureBuilder {
        TextureBuilder {
            label: label.as_ref().to_owned(),
            ..default()
        }
    }

    pub fn tex(&self) -> &wgpu::Texture {
        &self.tex
    }

    pub fn view(&self) -> &wgpu::TextureView {
        &self.view
    }

    /// Creates an image + sampler bindings:
    ///
    /// ```
    /// //#[spirv(descriptor_set = ..., binding = ...)]
    /// //tex: &Image!(2D, type=f32, sampled),
    ///
    /// //#[spirv(descriptor_set = ..., binding = ...)]
    /// //sampler: &Sampler,
    /// ```
    ///
    /// Sampler's binding follows the texture so e.g. if the texture has
    /// `binding = 3`, sampler will be `binding = 4`.
    pub fn bind_sampled(&self) -> impl Bindable + '_ {
        SampledTextureBinder { parent: self }
    }

    /// Creates an immutable storage texture binding:
    ///
    /// ```
    /// // #[spirv(descriptor_set = ..., binding = ...)]
    /// // tex: &Image!(2D, format = ..., sampled = false),
    /// ```
    ///
    /// TODO naga and/or rust-gpu don't support read-only storage textures yet,
    ///      so currently this is equivalent to a writable binding
    pub fn bind_readable(&self) -> impl Bindable + '_ {
        StorageTextureBinder { parent: self }
    }

    /// Creates a mutable storage texture binding:
    ///
    /// ```
    /// // #[spirv(descriptor_set = ..., binding = ...)]
    /// // tex: &Image!(2D, format = ..., sampled = false),
    /// ```
    pub fn bind_writable(&self) -> impl Bindable + '_ {
        StorageTextureBinder { parent: self }
    }

    pub fn get_size(&self) -> UVec3 {
        self.size
    }
}

#[derive(Clone, Default)]
pub struct TextureBuilder {
    label: String,
    size: Option<UVec3>,
    format: Option<wgpu::TextureFormat>,
    usage: Option<wgpu::TextureUsages>,
    sampler: wgpu::SamplerDescriptor<'static>,
}

impl TextureBuilder {
    pub fn label(&self) -> &str {
        &self.label
    }

    pub fn with_label(mut self, label: impl AsRef<str>) -> Self {
        self.label = label.as_ref().to_owned();
        self
    }

    pub fn with_size(mut self, size: UVec2) -> Self {
        self.size = Some(uvec3(size.x, size.y, 1));
        self
    }

    pub fn with_size_3d(mut self, size: UVec3) -> Self {
        self.size = Some(size);
        self
    }

    pub fn with_format(mut self, format: wgpu::TextureFormat) -> Self {
        self.format = Some(format);
        self
    }

    pub fn with_usage(mut self, usage: wgpu::TextureUsages) -> Self {
        *self.usage.get_or_insert(usage) |= usage;
        self
    }

    pub fn with_linear_filtering_sampler(mut self) -> Self {
        self.sampler.mag_filter = wgpu::FilterMode::Linear;
        self.sampler.min_filter = wgpu::FilterMode::Linear;
        self
    }

    pub fn with_nearest_filtering_sampler(mut self) -> Self {
        self.sampler.mag_filter = wgpu::FilterMode::Nearest;
        self.sampler.min_filter = wgpu::FilterMode::Nearest;
        self
    }

    pub fn build(self, device: &wgpu::Device) -> Texture {
        let Self {
            label,
            size,
            format,
            usage,
            sampler,
        } = self;

        let label = format!("rdog_{}", label);
        let size = size.expect("Missing property: size");
        let format = format.expect("Missing property: format");
        let usage = usage.expect("Missing property: usage");

        debug!("Allocating texture `{label}`; size={size:?}, format={format:?}");

        assert!(size.x > 0);
        assert!(size.y > 0);

        let (dimension, view_dimension) = match size.z {
            1 => (wgpu::TextureDimension::D2, wgpu::TextureViewDimension::D2),
            _ => (wgpu::TextureDimension::D3, wgpu::TextureViewDimension::D3),
        };

        let tex = Arc::new(device.create_texture(&wgpu::TextureDescriptor {
            label: Some(&format!("{label}_texture")),
            size: wgpu::Extent3d {
                width: size.x,
                height: size.y,
                depth_or_array_layers: size.z,
            },
            mip_level_count: 1,
            sample_count: 1,
            dimension,
            format,
            usage,
            view_formats: &[],
        }));

        let filterable = sampler.mag_filter != wgpu::FilterMode::Nearest
            || sampler.min_filter != wgpu::FilterMode::Nearest;

        let view = tex.create_view(&default());
        let sampler_label = format!("{label}_sampler");

        let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
            label: Some(&sampler_label),
            ..sampler
        });

        Texture {
            tex,
            format,
            view,
            sampler,
            filterable,
            dimension: view_dimension,
            size,
        }
    }
}

pub struct SampledTextureBinder<'a> {
    parent: &'a Texture,
}

impl Bindable for SampledTextureBinder<'_> {
    fn bind(&self, binding: u32) -> Vec<(wgpu::BindGroupLayoutEntry, wgpu::BindingResource)> {
        let image_layout = wgpu::BindGroupLayoutEntry {
            binding,
            visibility: wgpu::ShaderStages::all(),
            ty: wgpu::BindingType::Texture {
                multisampled: false,
                view_dimension: self.parent.dimension,
                sample_type: wgpu::TextureSampleType::Float {
                    filterable: self.parent.filterable,
                },
            },
            count: None,
        };

        let sampler_layout = wgpu::BindGroupLayoutEntry {
            binding: binding + 1,
            visibility: wgpu::ShaderStages::all(),
            ty: wgpu::BindingType::Sampler(if self.parent.filterable {
                wgpu::SamplerBindingType::Filtering
            } else {
                wgpu::SamplerBindingType::NonFiltering
            }),
            count: None,
        };

        let image_resource = wgpu::BindingResource::TextureView(&self.parent.view);
        let sampler_resource = wgpu::BindingResource::Sampler(&self.parent.sampler);

        vec![
            (image_layout, image_resource),
            (sampler_layout, sampler_resource),
        ]
    }
}

pub struct StorageTextureBinder<'a> {
    parent: &'a Texture,
}

impl Bindable for StorageTextureBinder<'_> {
    fn bind(&self, binding: u32) -> Vec<(wgpu::BindGroupLayoutEntry, wgpu::BindingResource)> {
        let image_layout = wgpu::BindGroupLayoutEntry {
            binding,
            visibility: wgpu::ShaderStages::all(),
            ty: wgpu::BindingType::StorageTexture {
                access: wgpu::StorageTextureAccess::ReadWrite,
                format: self.parent.format,
                view_dimension: self.parent.dimension,
            },
            count: None,
        };

        let image_resource = wgpu::BindingResource::TextureView(&self.parent.view);

        vec![(image_layout, image_resource)]
    }
}
