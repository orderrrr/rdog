use rdog_lib::prelude::*;
use spirv_std::num_traits::Pow;

fn srgb(channel: f32) -> f32 {
    if channel <= 0.00031308 {
        channel * 12.92
    } else {
        1.055 * channel.pow(1.0 / 2.4) - 0.055
    }
}

#[spirv(fragment)]
pub fn fs(
    #[spirv(frag_coord)] pos: Vec4,

    #[spirv(descriptor_set = 0, binding = 0, uniform)] config: &PassParams,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] _camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 2, uniform)] _globals: &Globals,

    #[spirv(descriptor_set = 1, binding = 0)] trace_tx: TexRgba32,
    #[spirv(descriptor_set = 1, binding = 1)] prev_tx: TexRgba32,
    output: &mut Vec4,
) {
    let col = trace_tx.read(pos.xy().as_uvec2()).xyz();
    // let col = vec3(srgb(col.x), srgb(col.y), srgb(col.z));
    let col = col.saturate();

    let prv = prev_tx.read(pos.xy().as_uvec2());

    let a = prv.w + 1.0;

    let col = col.mix(prv.xyz(), 1.0 - (1.0 / a)).extend(a);

    let multi_frame: bool = ((config.flags >> 3) & 1) == 1;

    unsafe {
        if multi_frame {
            prev_tx.write(pos.xy().as_uvec2(), col);
        } else {
            prev_tx.write(pos.xy().as_uvec2(), Vec4::splat(0.0));
        }
    }

    let col = col.xyz();
    let col = col.saturate();

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
