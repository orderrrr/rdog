#![cfg_attr(target_arch = "spirv", no_std)]
pub use rdog_lib::prelude::*;
use spirv_std::num_traits::Pow;
#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2, storage_buffer)] material: &[Material],
    #[spirv(descriptor_set = 0, binding = 3, storage_buffer)] light: &[Light],
    // #[spirv(descriptor_set = 0, binding = 3)] _atmos_tx: Tex<'_>,
    // #[spirv(descriptor_set = 0, binding = 4)] _atmos_sampler: &Sampler,
    #[spirv(descriptor_set = 0, binding = 4)] out: TexRgba32,
) {
    let compute_diffuse: bool = ((params.flags >> 0) & 1) == 1;
    let compute_scatter: bool = ((params.flags >> 1) & 1) == 1;
    let compute_specular: bool = ((params.flags >> 2) & 1) == 1;

    let pos = global_id.xy().as_vec2();

    let scene = Scene::new(
        camera,
        globals,
        material,
        light,
        params,
        params.bounce_count,
        // atmos_tx,
        // atmos_sampler,
        compute_diffuse,
        compute_scatter,
        compute_specular,
    );

    let mut col = Vec3::ZERO;

    for i in 0..params.pass_count + 1 {
        let mut r = Ray::ray(
            camera.screen.xy(),
            camera.ndc_to_world,
            pos,
            globals.seed,
            i,
        );
        col += scene.rt(&mut r);
    }

    col /= params.pass_count as f32;

    combine(pos.as_uvec2(), srgb_vec(col), out, params);
    // unsafe {
    //     out.write(pos.as_uvec2(), col.extend(0.0));
    // }
}

fn srgb_vec(col: Vec3) -> Vec3 {
    vec3(srgb(col.x), srgb(col.y), srgb(col.z))
}

fn srgb(channel: f32) -> f32 {
    if channel <= 0.00031308 {
        channel * 12.92
    } else {
        1.055 * channel.pow(1.0 / 2.4) - 0.055
    }
}

pub fn combine(pos: UVec2, col: Vec3, tx: TexRgba32, params: &PassParams) {
    unsafe {
        let multi_frame: bool = ((params.flags >> 3) & 1) == 1;

        if !multi_frame {
            tx.write(pos, col.extend(0.0));
            return;
        }

        let prv = tx.read(pos);

        let a = prv.w + 1.0;

        let col = col.mix(prv.xyz(), 1.0 - (1.0 / a)).extend(a);

        tx.write(pos, col);
    }
}
