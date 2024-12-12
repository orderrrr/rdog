#!env bash
MTL_HUD_ENABLED=1 WGPU_BACKEND=metal RUSTFLAGS='-C prefer-dynamic' cargo run --release --example demo
