#!env bash
MTL_HUD_ENABLED=1 WGPU_BACKEND=metal cargo run --example demo
# MTL_HUD_ENABLED=1 WGPU_BACKEND=metal cargo run --release --example demo
# MTL_HUD_ENABLED=1 WGPU_BACKEND=metal RUSTFLAGS='-C prefer-dynamic' cargo run --example demo
