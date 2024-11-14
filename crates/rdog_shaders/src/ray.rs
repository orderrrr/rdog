use rdog_lib::prelude::*;
use spirv_std::glam::{vec4, Vec2, Vec4};

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _time: &Vec2,

    #[spirv(descriptor_set = 1, binding = 0)] atmosphere_tx: Tex,
    #[spirv(descriptor_set = 1, binding = 1)] atmosphere_sampler: &Sampler,
    output: &mut Vec4,
) {
    let uv = (pos / camera.screen).xy();

    // let uv = vec2(
    //     (uv.x * time.x * 200.0).sin() * uv.y,
    //     (uv.y * time.x * 200.0).cos() * uv.x,
    // );

    let out = atmosphere_tx.sample(*atmosphere_sampler, uv);

    *output = vec4(out.x, out.y, out.z, 1.0);
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
