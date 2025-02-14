pub use rdog_lib::prelude::*;

fn hit_simple(r: Ray, el: f32, seed: UVec2) -> f32 {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let h = map(p, el, seed);

        if h.x < 0.001 {
            return t;
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    TMAX
}

// TODO - currently trace is a bit of a useless step since we don't keep the texture after direct is called.
// either make a new texture to write to or drop this function eventually
#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(push_constant)] _params: &PassParams,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2, storage_buffer)] _material: &[Material],
    #[spirv(descriptor_set = 0, binding = 3)] out: TexRgba16,
) {
    let r = ray(
        camera.screen.xy(),
        camera.ndc_to_world,
        global_id.xy().as_vec2(),
        globals.seed,
    );
    let hit = hit_simple(r, globals.time.x, globals.seed);

    unsafe {
        out.write(global_id.xy(), Vec3::ZERO.extend(hit));
    }
}
