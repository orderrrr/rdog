#!env bash
# MTL_HUD_ENABLED=1 WGPU_BACKEND=metal cargo run --release --example initial $@
MTL_HUD_ENABLED=1 WGPU_BACKEND=metal cargo run --release --example reaction_diffusion $@
