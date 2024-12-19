use rdog_lib::prelude::*;

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] trace_tx: Tex<'_>,
    #[spirv(descriptor_set = 1, binding = 1)] trace_sm: &Sampler,
    output: &mut Vec4,
) {
    let uv = pos.xy() / camera.screen.xy();

    let col = sample(trace_tx, trace_sm, uv).xyz();

    *output = col.extend(1.0);
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
