pub use rdog_lib::prelude::*;

fn calculate_weight(p: f32) -> f32 {
    (p * 0.1783783784) + 0.0162162162
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
    let id = global_id.xy();

    // Early exit if outside screen bounds
    if id.x >= camera.screen.x as u32 || id.y >= camera.screen.y as u32 {
        return;
    }

    let tc = id.as_vec2() / camera.screen.xy();
    let blur = 0.002;
    let h_step = 0.5;
    let v_step = 0.01;
    let mut total = 0.0;
    let samples = 30.0;
    let n_samples = samples as i32;

    let mut sum = Vec4::splat(0.0);

    // First pass - negative direction
    for i in 1..=n_samples {
        let float_i = i as f32;
        let counter = samples - float_i + 1.0;

        let p = float_i / samples;
        let weight = calculate_weight(p);
        total += weight;

        let sample_pos = Vec2::new(
            tc.x - counter * blur * h_step,
            tc.y - counter * blur * v_step,
        );

        sum += sample(render_tx, render_sampler, sample_pos) * weight;
    }

    // Center sample
    sum += sample(render_tx, render_sampler, tc) * 0.2270270270;
    total += 0.2270270270;

    // Second pass - positive direction
    for i in (1..=n_samples).rev() {
        let float_i = i as f32;
        let counter = samples - float_i + 1.0;

        let p = float_i / samples;
        let weight = calculate_weight(p);
        total += weight;

        let sample_pos = Vec2::new(
            tc.x + counter * blur * h_step,
            tc.y + counter * blur * v_step,
        );

        sum += sample(render_tx, render_sampler, sample_pos) * weight;
    }

    // Normalize and convert to sRGB
    let final_color = (sum / total).powf(2.2);

    unsafe {
        out.write(id, final_color);
    }
}
