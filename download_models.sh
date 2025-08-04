#!/bin/bash
set -e

# Model URLs and paths
declare -A models
models["models/diffusion_models/wan2.1_i2v_480p_14B_fp16.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_i2v_480p_14B_fp16.safetensors"
models["models/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"
models["models/vae/wan_2.1_vae.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors"
models["models/clip_vision/clip_vision_h.safetensors"]="https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors"

# Create folders if not exist
mkdir -p models/diffusion_models models/text_encoders models/vae models/clip_vision

# Download missing models
for path in "${!models[@]}"; do
    url="${models[$path]}"
    if [ ! -f "$path" ]; then
        echo "Downloading $path ..."
        wget -O "$path" "$url"
    else
        echo "$path already exists, skipping."
    fi
done

# Start ComfyUI
exec python main.py --port 8188