use glam::{UVec3, Vec2, Vec3};

pub fn rng01(s: Vec2, seed: u32, width: u32) -> f32 {
    let x = (s.x as u32).wrapping_mul(seed);
    let y = (s.y as u32).wrapping_mul(seed);
    let u = x.wrapping_add(y.wrapping_mul(width));

    (pcg(u) as f32) * (1.0 / (0xffffffffu32 as f32))
}

pub fn rng(s: Vec3, seed: u32) -> f32 {
    let x = (s.x as u32).wrapping_mul(seed);
    let y = (s.y as u32).wrapping_mul(seed);
    let z = (s.z as u32).wrapping_mul(seed);
    let u = x.wrapping_add(y.wrapping_mul(200).wrapping_add(z.wrapping_mul(200)));

    (pcg(u) as f32) * (1.0 / (0xffffffffu32 as f32))
}

/// Hash function that converts a 2D vector into a pseudo-random 3D vector.
/// Using PCG3D (Permuted Congruential Generator) for the final randomization step.
pub fn hash(s: Vec2, seed: u32) -> UVec3 {
    // Convert the float components to unsigned integers
    let x = s.x as u32 * seed;
    let y = s.y as u32 * seed;

    // Create a 3D vector with:
    // - First two components from input
    // - Third component as XOR of x and y
    let u = UVec3::new(x, y, x ^ y);

    pcg3d(u)
}

/// Original implementation from:
/// http://www.jcgt.org/published/0009/03/02/
pub fn pcg3d(mut v: UVec3) -> UVec3 {
    // Perform the linear congruential step
    v = v
        .wrapping_mul(UVec3::splat(1664525))
        .wrapping_add(UVec3::splat(1013904223));

    // First round of component mixing
    v.x += v.y.wrapping_mul(v.z);
    v.y += v.z.wrapping_mul(v.x);
    v.z += v.x.wrapping_mul(v.y);

    // Bitwise XOR with right-shifted values
    let shifted = v >> 16u32;
    v.x ^= shifted.x;
    v.y ^= shifted.y;
    v.z ^= shifted.z;

    // Second round of component mixing
    v.x += v.y.wrapping_mul(v.z);
    v.y += v.z.wrapping_mul(v.x);
    v.z += v.x.wrapping_mul(v.y);

    v
}

// https://www.pcg-random.org/
pub fn pcg(v: u32) -> u32 {
    let state = v.wrapping_mul(747796405).wrapping_add(2891336453);
    let word = ((state >> ((state >> 28) + 4)) ^ state).wrapping_mul(277803737);
    (word >> 22) ^ word
}
