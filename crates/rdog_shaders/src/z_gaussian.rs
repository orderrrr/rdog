pub use rdog_lib::prelude::*;

fn gaussian_weight(x: f32, y: f32, sigma: f32) -> f32 {
    (-((x * x + y * y) / (2.0 * sigma * sigma))).exp() / (2.0 * PI * sigma * sigma)
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] _params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _globals: &Globals,

    #[spirv(descriptor_set = 0, binding = 2)] render_tx: Tex<'_>,
    #[spirv(descriptor_set = 0, binding = 3)] render_sampler: &Sampler,

    #[spirv(descriptor_set = 0, binding = 4)] out: TexRgba16,
) {
    let id = global_id.xy().as_vec2();

    let radius = 10;
    let sigma = 5.0;
    let mut gauss_sum = Vec4::splat(0.0);

    // Gaussian blur calculation
    for x in -radius..=radius {
        for y in -radius..=radius {
            let offset = Vec2::new(x as f32, y as f32);
            let new_uv = Vec2::new(id.x as f32, id.y as f32) + offset;
            let screen_uv = new_uv / camera.screen.xy();
            // Flip Y for sampling
            let sample_uv = Vec2::new(screen_uv.x, screen_uv.y);

            gauss_sum += sample(render_tx, render_sampler, sample_uv)
                * gaussian_weight(x as f32, y as f32, sigma);
        }
    }

    unsafe {
        out.write(global_id.xy(), gauss_sum);
    }
}
