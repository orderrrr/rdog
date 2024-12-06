use rdog_lib::prelude::*;

#[spirv(compute(threads(1, 1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba8,
) {
    let global_id = global_id.xy();

    let uv = ((2.0 * global_id.as_vec2() - camera.screen.xy()) / camera.screen.y).xy();

    let mut col = 0.5 + (0.5 * (globals.time.x + uv.xyx() + vec3(0., 2., 4.)).cos());
    col = col.powf(2.2);

    unsafe {
        out.write(global_id, col.extend(1.0));
    }
}
