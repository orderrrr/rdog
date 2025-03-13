use std::sync::Arc;

use async_channel::{Receiver, Sender};
use bevy::{
    prelude::*,
    render::{
        extract_component::{ExtractComponent, ExtractComponentPlugin},
        render_graph::{
            NodeRunError, RenderGraphApp, RenderGraphContext, ViewNode, ViewNodeRunner,
        },
        render_resource::{
            encase::private::{ReadFrom, Reader},
            Buffer, ShaderType,
        },
        renderer::{render_system, RenderContext, RenderDevice},
        sync_world::MainEntity,
        view::ViewTarget,
        MainWorld, Render, RenderApp, RenderSet,
    },
    utils::HashMap,
};
use wgpu::BufferUsages;

use crate::{state::SyncedState, CameraHandle};

use super::{
    graph::{Rdog, RdogE}, rdog_buffers::RdogBufferResource, rdog_passes::RdogPassResource, state::ExtractedConfig, EngineResource
};

pub struct RdogReadbackPlugin {
    max_unused_frames: usize,
}

impl Default for RdogReadbackPlugin {
    fn default() -> Self {
        Self {
            max_unused_frames: 1,
        }
    }
}

impl Plugin for RdogReadbackPlugin {
    fn build(&self, app: &mut App) {
        info!("Readback plugin init");

        app.add_plugins(ExtractComponentPlugin::<Readback>::default());

        if let Some(render_app) = app.get_sub_app_mut(RenderApp) {
            render_app
                .init_resource::<GpuReadbackBufferPool>()
                .init_resource::<GpuReadbacks>()
                .insert_resource(GpuReadbackMaxUnusedFrames(self.max_unused_frames))
                .add_systems(ExtractSchedule, sync_readbacks.ambiguous_with_all())
                .add_systems(
                    Render,
                    (
                        prepare_buffers.in_set(RenderSet::PrepareResources),
                        (map_buffers).after(render_system).in_set(RenderSet::Render),
                    ),
                );

            render_app.add_render_graph_node::<ViewNodeRunner<RBRenderingNode>>(
                Rdog,
                RdogE::RBRenderingNode,
            );
            render_app.add_render_graph_edges(Rdog, (RdogE::Upscaling, RdogE::RBRenderingNode));
        }
    }
}

fn sync_readbacks(
    mut main_world: ResMut<MainWorld>,
    mut buffer_pool: ResMut<GpuReadbackBufferPool>,
    mut readbacks: ResMut<GpuReadbacks>,
    max_unused_frames: Res<GpuReadbackMaxUnusedFrames>,
) {
    readbacks.mapped.retain(|readback| {
        if let Ok((entity, buffer, result)) = readback.rx.try_recv() {
            main_world.trigger_targets(ReadbackComplete(result), entity);
            buffer_pool.return_buffer(&buffer);
            false
        } else {
            true
        }
    });

    buffer_pool.update(max_unused_frames.0);
}

#[derive(Resource)]
struct GpuReadbackMaxUnusedFrames(usize);

#[derive(Component, ExtractComponent, Clone, Debug)]
pub enum Readback {
    Buffer(BufferReadback),
}

#[derive(Clone, Debug)]
pub struct BufferReadback {
    pass: String,
    buffer: String,
}

impl Readback {
    pub fn buffer(pass: String, buffer: String) -> Self {
        Self::Buffer(BufferReadback { pass, buffer })
    }
}

#[derive(Event, Deref, DerefMut, Reflect, Debug)]
#[reflect(Debug)]
pub struct ReadbackComplete(pub Vec<u8>);

impl ReadbackComplete {
    pub fn to_shader_type<T: ShaderType + ReadFrom + Default>(&self) -> T {
        let mut val = T::default();
        let mut reader = Reader::new::<T>(&self.0, 0).expect("Failed to create Reader");
        T::read_from(&mut val, &mut reader);
        val
    }
}

#[derive(Resource, Default)]
struct GpuReadbackBufferPool {
    buffers: HashMap<u64, Vec<GpuReadbackBuffer>>,
}

impl GpuReadbackBufferPool {
    fn get(&mut self, render_device: &RenderDevice, size: u64) -> Buffer {
        let buffers = self.buffers.entry(size).or_default();

        // find an untaken buffer for this size
        if let Some(buf) = buffers.iter_mut().find(|x| !x.taken) {
            buf.taken = true;
            buf.frames_unused = 0;
            return buf.buffer.clone();
        }

        let buffer = render_device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("Readback Buffer"),
            size,
            usage: BufferUsages::COPY_DST | BufferUsages::MAP_READ,
            mapped_at_creation: false,
        });
        buffers.push(GpuReadbackBuffer {
            buffer: buffer.clone(),
            taken: true,
            frames_unused: 0,
        });

        buffer
    }

    fn return_buffer(&mut self, buffer: &Buffer) {
        let size = buffer.size();
        let buffers = self
            .buffers
            .get_mut(&size)
            .expect("Returned buffer of untracked size");
        if let Some(buf) = buffers.iter_mut().find(|x| x.buffer.id() == buffer.id()) {
            buf.taken = false;
        } else {
            warn!("Returned buffer that was not allocated");
        }
    }

    fn update(&mut self, max_unused_frames: usize) {
        for (_, buffers) in &mut self.buffers {
            for buf in &mut *buffers {
                if !buf.taken {
                    buf.frames_unused += 1;
                }
            }
            buffers.retain(|x| x.frames_unused < max_unused_frames);
        }
        self.buffers.retain(|_, buffers| !buffers.is_empty());
    }
}

struct GpuReadbackBuffer {
    buffer: Buffer,
    taken: bool,
    frames_unused: usize,
}

#[derive(Resource, Default)]
struct GpuReadbacks {
    requested: Vec<GpuReadback>,
    mapped: Vec<GpuReadback>,
}

struct GpuReadback {
    pub entity: Entity,
    pub pass: String,
    pub src: ReadbackSource,
    pub buffer: Buffer,
    pub rx: Receiver<(Entity, Buffer, Vec<u8>)>,
    pub tx: Sender<(Entity, Buffer, Vec<u8>)>,
}

enum ReadbackSource {
    Buffer {
        src_start: u64,
        dst_start: u64,
        buffer: Arc<wgpu::Buffer>,
    },
}

fn prepare_buffers(
    render_device: Res<RenderDevice>,
    mut readbacks: ResMut<GpuReadbacks>,
    mut buffer_pool: ResMut<GpuReadbackBufferPool>,
    engine: Res<EngineResource>,
    handles: Query<(&MainEntity, &Readback)>,
    buffers: Res<RdogBufferResource>,
) {
    for (entity, readback) in handles.iter() {
        match readback {
            Readback::Buffer(buffer) => {
                let read_buffer =
                    engine.get_buffer(&buffers.get(&CameraHandle::new(0)).unwrap(), &buffer.buffer);

                let write_buffer = buffer_pool.get(&render_device, read_buffer.size());
                let (tx, rx) = async_channel::bounded(1);

                readbacks.requested.push(GpuReadback {
                    entity: entity.id(),
                    pass: buffer.pass.clone(),
                    src: ReadbackSource::Buffer {
                        src_start: 0,
                        dst_start: 0,
                        buffer: read_buffer.clone(),
                    },
                    buffer: write_buffer,
                    rx,
                    tx,
                });
            }
        }
    }
}

fn map_buffers(mut readbacks: ResMut<GpuReadbacks>) {
    let requested = readbacks.requested.drain(..).collect::<Vec<GpuReadback>>();
    for readback in requested {
        let slice = readback.buffer.slice(..);
        let entity = readback.entity;
        let buffer = readback.buffer.clone();
        let tx = readback.tx.clone();
        slice.map_async(wgpu::MapMode::Read, move |res| {
            res.expect("Failed to map buffer");
            let buffer_slice = buffer.slice(..);
            let data = buffer_slice.get_mapped_range();
            let result = Vec::from(&*data);
            drop(data);
            buffer.unmap();
            if let Err(e) = tx.try_send((entity, buffer, result)) {
                warn!("Failed to send readback result: {:?}", e);
            }
        });
        readbacks.mapped.push(readback);
    }
}

#[derive(Default)]
struct RBRenderingNode;

// NOTE: Unlike the bevy readback plugin, we need to be part of a rendering node to get the command_encoder.
impl ViewNode for RBRenderingNode {
    type ViewQuery = &'static ViewTarget;

    fn run(
        &self,
        graph: &mut RenderGraphContext,
        render_context: &mut RenderContext,
        target: &ViewTarget,
        world: &World,
    ) -> Result<(), NodeRunError> {
        let readbacks = world.resource::<GpuReadbacks>();
        for readback in &readbacks.requested {
            match &readback.src {
                ReadbackSource::Buffer {
                    src_start,
                    dst_start,
                    buffer,
                } => {
                    let entity = graph.view_entity();
                    let engine = world.resource::<EngineResource>();
                    let passes = world.resource::<RdogPassResource>();
                    let state = world.resource::<SyncedState>();
                    let config = world.resource::<ExtractedConfig>();

                    let Some(camera) = state.cameras.get(&entity) else {
                        return Ok(());
                    };

                    engine.render_camera_pass(
                        camera.handle,
                        config,
                        render_context.command_encoder(),
                        target.main_texture_view(),
                        &readback.pass,
                        passes,
                    );

                    render_context.command_encoder().copy_buffer_to_buffer(
                        buffer,
                        *src_start,
                        &readback.buffer,
                        *dst_start,
                        buffer.size(),
                    );
                }
            }
        }

        Ok(())
    }
}
