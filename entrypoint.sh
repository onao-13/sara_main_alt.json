# --- Login to Hugginface ---
curl -LsSf https://hf.co/cli/install.sh | bash;
hf auth login --token ${HF_TOKEN}

# --- PRIVATE MODELS THROUGH HUGGINGFACE-CLI ---
hf download ananona/dependencies \
    sara_lora_000002500.safetensors \
    --local-dir /comfyui/models/lora;

hf download ibuildproducts/instagirlv2 \
    Instagirlv2.0_hinoise.safetensors \
    --local-dir /comfyui/models/lora;

hf download ibuildproducts/instagirlv2 \
    Instagirlv2.0_lownoise.safetensors \
    --local-dir /comfyui/models/lora;

hf download ananona/dependencies \
    WAN2.2-HighNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora;

hf download ananona/dependencies \
    WAN2.2-LowNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora;

python /src/entrypoint.py