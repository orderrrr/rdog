//* #import rng::{
//*     rng_state, rand_f
//* }
//* #import scene::{
//*     sample_atmos, map, light_map, MIN_DIST, TMAX, mat_2, rbi, DEFAULT_MAT, DANGER
//* }
//* #import types::{
//*     Ray, Material, MaterialIn, Light, LightIn, PassParams, Globals, Camera, Hit, ScatterRes, OCTree, OutputParams
//* }
//* #import ray::{
//*     pd, dir, mv
//* }
//* #import cam::{
//*     project_point3
//* }
//* #import util::{
//*     EPSILON, ONE, ZERO, PI
//* }

const TSTART: f32 = 0.01;
const RMAX: u32 = 600;

var<private> num_levels: u32;

@group(0) @binding(0) var<uniform> camera: Camera;
@group(0) @binding(1) var<uniform> globals: Globals;
@group(0) @binding(2) var<uniform> pass_params: PassParams;

@group(1) @binding(0) var<storage, read> material: array<MaterialIn>;
@group(1) @binding(1) var<storage, read> light_in: array<LightIn>;

@group(2) @binding(0) var voxel: texture_3d<f32>;
@group(2) @binding(1) var voxel_sample: sampler;

@fragment
fn fs(@builtin(position) vertex: vec4f) -> @location(0) vec4f {
    var pos = vertex.xy;

    rng_state = u32(u32(pos.x) + (u32(pos.y) * u32(camera.screen.y))) * globals.seed.y;
    num_levels = u32(log2(f32(pass_params.voxel_dim))) + 1;

    let ss = vec2f(camera.screen.xy);

    var col = vec3f(0.0);

    for (var i: u32 = 0; i < pass_params.pass_count; i++) {
        var uv = ((pos + vec2f(0.5)) * 2.0) / ss - vec2f(1.0);
        uv.y *= -1.0;

        let focal_dist = camera.fpd.w;
        let world_pos = camera.fpd.xyz;
        let coc = calculate_coc(world_pos, focal_dist);

        let dof_jitter = depth_aware_jitter(abs(coc));
        uv += dof_jitter * (rand_f() * 2.0 - 1.0);

        let fp = project_point3(camera.ndc_to_world, vec3f(uv, EPSILON));
        let np = project_point3(camera.ndc_to_world, vec3f(uv, 1.0));

        let focal_point = np + normalize(fp - np) * focal_dist;
        let jittered_origin = np + vec3f(rand_f(), rand_f(), rand_f()) * camera.af.x;
        let r = Ray(jittered_origin, normalize(focal_point - jittered_origin));

        col += ray_trace(r);
    }

    col /= f32(pass_params.pass_count);

    return vec4f(col, 1.0);
    // return vec4f(pow(col, vec3f(2.2)), 1.0);
}

@vertex
fn vs(@builtin(vertex_index) vidx: u32) -> @builtin(position) vec4f {
    return full_screen_triangle(vidx);
}

fn calculate_coc(world_pos: vec3f, focal_dist: f32) -> f32 {
    // Calculate circle of confusion based on depth difference
    let depth = length(world_pos - camera.origin.xyz);
    return (depth - focal_dist) * camera.af.y * camera.af.x / focal_dist;
}

fn depth_aware_jitter(coc: f32) -> vec2f {
    // Poisson disk samples for quality jittering
    let poisson = array<vec2f, 12>(
        vec2f(-0.326, -0.406), vec2f(-0.840, -0.074),
        vec2f(-0.696, 0.457), vec2f(-0.203, 0.621),
        vec2f(0.962, -0.195), vec2f(0.519, 0.767),
        vec2f(0.507, -0.641), vec2f(0.185, -0.893),
        vec2f(0.896, 0.412), vec2f(-0.322, -0.933),
        vec2f(-0.792, -0.598), vec2f(0.291, 0.195)
    );

    // Select jitter sample based on RNG state
    let idx = u32(rand_f() * 12.0);
    return poisson[idx] * coc * 0.05;
}

fn srgb_vec(col: vec3f) -> vec3f {
    return vec3f(srgb(col.x), srgb(col.y), srgb(col.z));
}

fn srgb(channel: f32) -> f32 {
    if channel <= 0.00031308 {
        return channel * 12.92;
    } else {
        return 1.055 * pow(channel, 1.0 / 2.4) - 0.055;
    }
}

fn full_screen_triangle(vert_idx: u32) -> vec4f {
    let uv = vec2(f32((vert_idx << 1) & 2), f32(vert_idx & 2));
    let pos = 2.0 * uv - vec2f(1.0);

    return vec4(pos, 0.0, 1.0);
}


fn ray_trace(ri: Ray) -> vec3f {
    var r = ri;

    if true {
        var h = trace_voxel_mask(r);
        return h.xyz;
    }

    if true {
        var h = trace_voxel_mask_merged(r);
        return h.xyz;
    }

    return vec3f(0.0);
}


fn trace_voxel_mask(ri: Ray) -> vec4f {
    var r = ri;

    let vd = f32(pass_params.voxel_dim);
    r.o = (r.o + 1.0) / 2.0 - vec3f(0.0, 0.5, 0.0);

    var map_pos = vec3i(floor(r.o));

    let step_size = dot(abs(r.d), vec3f(.5 / vd));
    var total = vec4f(0.0);

    if !all(r.o >= vec3f(0.0) && r.o <= vec3f(1.0)) {
        let dist = rbi(r, vec3f(0.0), vec3f(1.0));
        if dist < 0.0 {
            return vec4f(0.0); // Ray doesn't intersect the volume
        }
        r.o += r.d * (dist + 0.01);
    }

    // Ray marching loop
    for (var i: u32 = 0; i < pass_params.voxel_dim * 2; i++) {
        let d = get_voxel(r.o);
        // let vis = compute_voxel_visibility(d.y);

        if d.z >= 0.0001 {
            // Render this voxel with visibility.alpha transparency
            let c1 = vec3f(-1.9, -1.0, 1.5);
            let c2 = vec3f(1.4, -1.2, -2.4);
            let color = vec3f(0.05) + d.x * (vec3f(1.0) - c1) + d.y * (c1 - c2);

            if true {
                return vec4f(calc_normal(r.o), 1.00);
                // return vec4f(color, 1.0);
            }

            total += vec4f(color * d.z * 1.0, d.z);
        }

        r.o += r.d * step_size;

        if any(r.o < vec3f(0.0) || r.o > vec3f(1.0)) {
            return total;
        }
    }

    return vec4f(0.5, 0.0, 0.5, 1.0);
}

fn trace_voxel_mask_merged(ri: Ray) -> vec4f {
    var r = ri;

    let vd = f32(pass_params.voxel_dim);
    r.o = (r.o + 1.0) / 2.0 - vec3f(0.0, 0.5, 0.0);

    // Check if ray is outside the volume and calculate entry point if needed
    if !all(r.o >= vec3f(0.0) && r.o <= vec3f(1.0)) {
        let dist = rbi(r, vec3f(0.0), vec3f(1.0));
        if dist < 0.0 {
            return vec4f(0.0); // Ray doesn't intersect the volume
        }
        r.o += r.d * (dist + 0.01);
    }

    // Calculate DDA parameters for efficient stepping
    let delta_dist = abs(vec3(length(r.d)) / r.d);
    let step_size = 1.0 / vd; // Fixed step size based on voxel dimension
    
    var total = vec4f(0.0);

    // Ray marching loop with DDA-style acceleration
    for (var i: u32 = 0; i < RMAX; i++) {
        // Sample at the current continuous position
        let d = get_voxel(r.o);
        
        if d.z >= 0.0001 {
            // Render this voxel with transparency
            let c1 = vec3f(-1.9, -1.0, 1.5);
            let c2 = vec3f(1.4, -1.2, -2.4);
            let color = vec3f(0.05) + d.x * (vec3f(1.0) - c1) + d.y * (c1 - c2);

            if d.z > 0.01 {
                return vec4f(calc_normal(r.o), 1.00);
            }

            total += vec4f(color * d.z * 1.0, d.z);
            
            // Early exit if we've accumulated enough color
            if total.w > 0.98 {
                return total;
            }
        }

        // Advance the ray with adaptive step size
        // Use smaller steps in high-detail regions, larger steps elsewhere
        let adaptive_step = step_size;
        r.o += r.d * adaptive_step;

        // Check if we've exited the volume
        if any(r.o < vec3f(0.0) || r.o > vec3f(1.0)) {
            return total;
        }
    }

    return total;
}

fn calc_normal(p: vec3f) -> vec3f {
    let ep = 1.0 / f32(pass_params.voxel_dim);
    return normalize(vec3(
        get_voxel(p - vec3(ep, 0.0, 0.0)).z - get_voxel(p + vec3(ep, 0.0, 0.0)).z,
        get_voxel(p - vec3(0.0, ep, 0.0)).z - get_voxel(p + vec3(0.0, ep, 0.0)).z,
        get_voxel(p - vec3(0.0, 0.0, ep)).z - get_voxel(p + vec3(0.0, 0.0, ep)).z
    ));
}

// fn calc_normal(pos: vec3f) -> vec3f {
//     let ep = 1.0 / f32(pass_params.voxel_dim);
//     let e = vec2f(1.0, -1.0) * 0.5773;
//
//     return normalize(
//         0. + e.xyy 
//         * get_voxel(pos + ep * e.xyy).z + e.yyx 
//         * get_voxel(pos + ep * e.yyx).z + e.yxy 
//         * get_voxel(pos + ep * e.yxy).z + e.xxx 
//         * get_voxel(pos + ep * e.xxx).z
//     );
// }

fn compute_voxel_visibility(chemical_b_concentration: f32) -> vec2f {
    // Hardcoded constants from the UI defaults
    let exponent: f32 = 3.3;
    let alpha_global: f32 = 1.0;
    let alpha_threshold: f32 = 0.0001;
    
    // Compute the alpha value
    let alpha = pow(chemical_b_concentration, exponent) * alpha_global;
    
    // Determine if the voxel is visible
    let visible = alpha >= alpha_threshold;

    return vec2f(f32(visible), alpha);
}

fn get_voxel(c: vec3f) -> vec4f {
    return textureSample(voxel, voxel_sample, c);
}

fn less_than_equal(a: vec3f, b: vec3f) -> vec3<bool> {
    return vec3<bool>(a.x <= b.x, a.y <= b.y, a.z <= b.z);
}
