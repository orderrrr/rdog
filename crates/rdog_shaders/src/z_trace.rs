pub use rdog_lib::prelude::*;

type V3 = Vec3;

pub fn mmap(p: V3, _el: f32, _seed: UVec2) -> f32 {
    (p - V3::Y).length() - 0.5
}

fn hit_simple(r: Ray, el: f32, seed: UVec2) -> f32 {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let h = mmap(p, el, seed);

        if h < 0.001 {
            return 0.0;
        }

        if t > TMAX {
            break;
        }

        t += h
    }

    return 1.0;
}

// TODO - currently trace is a bit of a useless step since we don't keep the texture after direct is called.
// either make a new texture to write to or drop this function eventually
#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] _params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16,
) {
    let r = ray(camera.screen.xy(), camera.ndc_to_world, global_id.xy());
    let hit = hit_simple(r, globals.time.x, globals.seed);

    unsafe {
        out.write(global_id.xy(), Vec4::splat(hit));
    }
}
