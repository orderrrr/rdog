struct PassParams {
    sun_x: f32,
    sun_y: f32,
    pass_count: u32,
    bounce_count: u32,
    flags: u32,
    octree_dim: u32,
}

struct Globals {
    time: vec2f,
    seed: vec2u,
}

@group(0) @binding(0) var<uniform> pass_params: PassParams;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<storage, read_write> octrees: array<OCTree>;
// @group(0) @binding(3) var<uniform, read_write> valid_octrees: atomic_u32; // atmoic to count valid octrees

struct OCTree {
    upper_mask: u32,
    lower_mask: u32,
}

// octree mask contains 64 Voxel Masks

struct Voxel {
    id: u64,
}

// voxel id contains 8 sdf ids.
// 00000000
// 00000000
// 00000000
// 00000000

fn map(pos: vec3f) -> bool {
    return length(pos - vec3f(5.0)) - 10.0 < 0.0 || length(pos - vec3f(25.0, (sin(globals.time.x) + 1.0) * 20.0, 12.0)) - 15.0 < 0.0;
}

@compute @workgroup_size(1,1,1)
fn main(
    @builtin(global_invocation_id) id: vec3u,
    @builtin(local_invocation_id) local_id: vec3u,
    @builtin(workgroup_id) workgroup_id: vec3u,
) {

    let idx = id.x + id.y * pass_params.octree_dim + id.z * pass_params.octree_dim * pass_params.octree_dim;

    octrees[idx].upper_mask = 0u;
    octrees[idx].lower_mask = 0u;

    for (var i: u32 = 0u; i < 4; i++) {
        for (var j: u32 = 0u; j < 4; j++) {
            for (var k: u32 = 0u; k < 4; k++) {
                let local_idx = vec3u(i, j, k);
                let local_idxx = i + j * 4 + k * 4 * 4;

                let pos = 4 * vec3f(id) + vec3f(local_idx);

                // if (id.x == 0) {
                //         octrees[idx].lower_mask = 0xffffffffu;
                //         octrees[idx].upper_mask = 0xffffffffu;
                // }

                if map(pos) {
                    if local_idxx < 32 {
                        octrees[idx].lower_mask = octrees[idx].lower_mask | (1u << local_idxx);
                    } else {
                        octrees[idx].upper_mask = octrees[idx].upper_mask | (1u << (local_idxx - 32));
                    }
                }
            }
        }
    }
}
