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
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16<'_>,
) {
    let r = get_camera_ray(global_id.xy().as_vec2(), camera, globals.time.x);
    let hit = hit_simple(r, globals.time.x, globals.seed);

    unsafe {
        out.write(global_id.xy(), Vec3::ZERO.extend(hit));
    }
}
