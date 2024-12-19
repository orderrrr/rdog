pub use rdog_lib::prelude::*;

fn hit(r: Ray, g: &Globals) -> Vec4 {
    // TODO - change to a Material struct
    let mut t = 0.0;

    for _ in 0..RMAX {
        let p = r.o + t * r.d;

        let h = map(p, g);

        if h.x < 0.001 {
            return calc_normal(p, g).extend(t);
        }

        if t > TMAX {
            break;
        }

        t += h.x
    }

    Vec3::ZERO.extend(TMAX)
}

#[spirv(compute(threads(1)))]
pub fn main(
    #[spirv(global_invocation_id)] global_id: UVec3,
    #[spirv(descriptor_set = 0, binding = 0, uniform)] camera: &Camera,
    #[spirv(descriptor_set = 0, binding = 1, uniform)] globals: &Globals,
    #[spirv(descriptor_set = 0, binding = 2)] out: TexRgba16<'_>,
) {
    let pos = global_id.as_vec3();
    let p = vec2(pos.x, camera.screen.y - pos.y);

    let uv = (2.0 * p - camera.screen.xy()) / camera.screen.y;

    let time = globals.time.x * 0.5;

    let rotation_angle = time;
    let rotor = rotor_y(rotation_angle);

    // Calculate ro, rotating around y-axis
    let ro = rotate_vector(rotor, vec3(0.0, 1.0, -5.0));

    let f = 1.5;

    // Calculate rd, rotating the view direction
    let rd = (rotate_vector(rotor, vec3(uv.x, uv.y, f))).normalize();

    let r = Ray::new(ro, rd);

    let col = hit(r, globals);

    unsafe {
        out.write(global_id.xy(), col);
    }
}
