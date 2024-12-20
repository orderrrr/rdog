use rdog_lib::prelude::*;
use spirv_std::num_traits::Pow;

fn srgb(c: f32) -> f32 {
    if c <= 0.00031308 {
        c * 12.92
    } else {
        1.055 * c.pow(1.0 / 2.4) - 0.055
    }
}

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] trace_tx: Tex<'_>,
    #[spirv(descriptor_set = 1, binding = 1)] trace_sm: &Sampler,
    #[spirv(descriptor_set = 1, binding = 2)] prev_tx: TexRgba16<'_>,
    output: &mut Vec4,
) {
    let uv = pos.xy() / camera.screen.xy();

    let col = sample(trace_tx, trace_sm, uv).xyz();

    // let prv = prev_tx.read(pos.xy().as_uvec2());
    // let a = prv.w + 1.0;
    // let col = col.mix(prv.xyz(), 1.0 - (1.0 / a));

    let col = vec3(srgb(col.x), srgb(col.y), srgb(col.z));
    let col = col.saturate().extend(1.0);

    unsafe {
        prev_tx.write(pos.xy().as_uvec2(), col);
    }

    *output = col;
}

#[spirv(vertex)]
pub fn vs(#[spirv(vertex_index)] vert_idx: i32, #[spirv(position)] output: &mut Vec4) {
    fn full_screen_triangle(vert_idx: i32) -> Vec4 {
        let uv = vec2(((vert_idx << 1) & 2) as f32, (vert_idx & 2) as f32);
        let pos = 2.0 * uv - Vec2::ONE;

        pos.extend(0.0).extend(1.0)
    }

    *output = full_screen_triangle(vert_idx);
}
