#!env bash
WGPU_BACKEND=metal RUSTFLAGS='-C prefer-dynamic' cargo run --release --example demo
