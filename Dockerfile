FROM runpod/worker-comfyui:5.5.0-base

# --- HUGGINGFACE TOKEN ---
ARG HF_TOKEN
ENV HUGGINGFACE_HUB_TOKEN=${HF_TOKEN}

# Устанавливаем huggingface-cli
RUN pip install --no-cache-dir huggingface_hub[hf_transfer]

# --- ComfyUI NODES ---
RUN comfy node install --exit-on-fail comfyui-easy-use@1.3.4

# --- PUBLIC MODELS (через comfy-cli) ---
RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
    --relative-path models/clip \
    --filename umt5_xxl_fp8_e4m3fn_scaled.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors \
    --relative-path models/vae \
    --filename wan_2.1_vae.safetensors

RUN comfy model download \
    --url https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_T2V_14B_cfg_step_distill_v2_lora_rank32_bf16.safetensors \
    --relative-path models/lora \
    --filename lightx2v_T2V_14B_cfg_step_distill_v2_lora_rank32_bf16.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors \
    --relative-path models/diffusion_models \
    --filename wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors

RUN comfy model download \
    --url https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors \
    --relative-path models/diffusion_models \
    --filename wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors


# --- PRIVATE MODELS THROUGH HUGGINGFACE-CLI ---

# Пример: скачивание LoRA из приватного репозитория user/private-loras
# ЗАМЕНИ пути на свои
RUN hf download ananona/dependencies \
    --include sara_lora_000002500.safetensors \
    --local-dir /comfyui/models/lora \
    --local-dir-use-symlinks False

RUN hf download ibuildproducts/instagirlv2 \
    --include Instagirlv2.0_hinoise.safetensors \
    --local-dir /comfyui/models/lora \
    --local-dir-use-symlinks False

RUN hf download ibuildproducts/instagirlv2 \
    --include Instagirlv2.0_lownoise.safetensors \
    --local-dir /comfyui/models/lora \
    --local-dir-use-symlinks False

RUN hf download ananona/dependencies \
    --include WAN2.2-HighNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora \
    --local-dir-use-symlinks False

RUN hf download ananona/dependencies \
    --include WAN2.2-LowNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora \
    --local-dir-use-symlinks False
