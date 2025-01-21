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
    let compute_diffuse: bool = ((params.flags >> 0) & 1) == 1;
    let compute_scatter: bool = ((params.flags >> 1) & 1) == 1;
    let compute_specular: bool = ((params.flags >> 2) & 1) == 1;

    let pos = global_id.xy().as_vec2();
    let r = Ray::ray(camera.screen.xy(), camera.ndc_to_world, pos, globals.seed);
    let scene = Scene::new(
        camera,
        globals,
        material,
        params,
        8,
        8,
        atmos_tx,
        atmos_sampler,
        compute_diffuse,
        compute_scatter,
        compute_specular,
    );

    let col = scene.rt(r);

    unsafe {
        out.write(global_id.xy(), col.xyz().extend(1.0));
    }
}
