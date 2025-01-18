#![allow(unexpected_cfgs)]
#![cfg_attr(target_arch = "spirv", no_std)]
// #![deny(warnings)] // meh

// pub mod ray;
pub mod atmosphere;

pub mod direct;
pub mod scatter;
pub mod specular;

// pub mod combined;
// pub mod ray;
// pub mod trace;

// pub mod z_trace;
// pub mod z_gaussian;
// pub mod z_motion;

pub mod raster;
