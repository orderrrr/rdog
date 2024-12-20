#![cfg_attr(target_arch = "spirv", no_std)]
// #![deny(warnings)] // meh

// pub mod ray;
pub mod atmosphere;
pub mod direct;
pub mod raster;
// pub mod ray;
pub mod scatter;
pub mod specular;
pub mod trace;
