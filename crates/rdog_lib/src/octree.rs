pub fn calculate_full_depth(depth: u32) -> u32 {
    ((8_f64.powf((depth + 1) as f64) - 1.) / 7.) as u32
}
