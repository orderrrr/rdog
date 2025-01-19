#![cfg_attr(target_arch = "spirv", no_std)]

pub use rdog_lib::prelude::*;

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2, storage_buffer)] material: &[Material],
    #[spirv(descriptor_set = 0, binding = 3)] atmos_tx: Tex<'_>,
    #[spirv(descriptor_set = 0, binding = 4)] atmos_sampler: &Sampler,
    #[spirv(descriptor_set = 0, binding = 5)] out: TexRgba32,
) {
    let pos = global_id.xy().as_vec2();
    let r = ray(camera.screen.xy(), camera.ndc_to_world, pos, globals.seed);
    let scene = Scene::new(
        camera,
        globals,
        material,
        params,
        20,
        atmos_tx,
        atmos_sampler,
    );

    let mut col = Vec3::ZERO;

    let res = scene.trace(r);

    if !res.valid() {
        col = scene.sample_atmos(r);
        unsafe {
            out.write(global_id.xy(), col.xyz().extend(res.dist()));
        }
        return;
    }

    let pos = r.pd(res.dist());

    let diffuse_pass: bool = ((scene.params.flags >> 0) & 1) == 1;

    if res.diffuse() > 0.0 && diffuse_pass {
        col = res.diffuse()
            * res.albedo()
            * (scene.sample_indirect_diff(r.clone().at(pos), res.normal()));
    }

    unsafe {
        out.write(global_id.xy(), col.xyz().extend(res.dist()));
    }
}
