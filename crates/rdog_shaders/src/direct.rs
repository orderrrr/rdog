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
    #[spirv(descriptor_set = 0, binding = 5)] out: TexRgba16,
) {
    let pos = global_id.xy().as_vec2();
    let r = ray(camera.screen.xy(), camera.ndc_to_world, pos, globals.seed);
    let scene = Scene::new(camera, globals, material, params, 8, atmos_tx, atmos_sampler);
    let col = scene.get_color(r);

    // let uv = global_id.xy().as_vec2() / camera.screen.xy();
    // let col = sample(atmos_tx, atmos_sampler, uv);

    unsafe {
        out.write(global_id.xy(), col.xyz().extend(1.0));
    }
}
