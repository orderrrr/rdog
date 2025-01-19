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
    let inp = out.read(global_id.xy().as_ivec2());
    let pos = global_id.xy().as_vec2();
    let mut r = ray(camera.screen.xy(), camera.ndc_to_world, pos, globals.seed);
    r = r.at(r.pd(inp.w - 0.01));

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

    if !(res.scattering_scale() > 0.0) || !res.valid() {
        return;
    }

    let pos = r.pd(res.dist());

    let scatter_pass: bool = ((scene.params.flags >> 1) & 1) == 1;

    if res.scattering_scale() > 0.0 && scatter_pass {
        col = res.scattering_scale()
            * res.scattering_color()
            * (scene.sample_scattering(r.clone().at(pos), res.normal()));
    }

    col += inp.xyz();

    unsafe {
        out.write(global_id.xy(), col.xyz().extend(inp.w));
    }
}
