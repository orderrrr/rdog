use rdog_lib::prelude::*;

// pub const NOISE_DIM: UVec2 = UVec2::new(256, 256);
// pub const NOISE_DIM: UVec2 = UVec2::new(128, 128);
pub const NOISE_DIM: UVec2 = UVec2::new(128, 128);

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 1)] out: TexRgba8,
) {
    let rng = rng01(global_id.xy().as_vec2(), globals.seed.x, NOISE_DIM.x) * 1.3;

    unsafe {
        out.write(global_id.xy(), Vec3::splat(rng).extend(1.0));
    }
}
