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
    r = r.at(r.pd(inp.w));

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

    if !(res.specular() > 0.0) || !res.valid() {
        return;
    }

    let pos = r.pd(res.dist());

    let mut fresnel = 0.0;

    let specular_pass: bool = ((scene.params.flags >> 2) & 1) == 1;

    if res.specular() > 0.0 && specular_pass {
        let v = -r.d;
        col = res.specular()
            * scene.spec_brdf(
                r.at(pos).offset_uv(vec2(1.0, -1.0)),
                v,
                res.normal(),
                res.roughness(),
                res.f0(),
                &mut fresnel,
            );
    }

    col += (1.0 - fresnel) * inp.xyz();

    unsafe {
        out.write(global_id.xy(), col.xyz().extend(inp.w));
    }
}
