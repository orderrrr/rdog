#![allow(unexpected_cfgs)]
#![cfg_attr(target_arch = "spirv", no_std)]
// #![deny(warnings)] // meh

// pub mod ray;
// pub mod atmosphere;

// // #[cfg(feature = "not-combined")]
// pub mod direct;
// // #[cfg(feature = "not-combined")]
// pub mod scatter;
// // #[cfg(feature = "not-combined")]
// pub mod specular;

// #[cfg(feature = "combined")]
pub mod combined;

// pub mod ray;
// pub mod trace;

// pub mod z_trace;
// pub mod z_gaussian;
// pub mod z_motion;

// pub mod raster;
