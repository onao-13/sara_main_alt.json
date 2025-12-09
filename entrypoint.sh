# --- Login to Hugginface ---
set -e;
hf auth login --token ${HF_TOKEN};

# --- PRIVATE MODELS THROUGH HUGGINGFACE-CLI ---
hf download ananona/dependencies \
    sara_lora_000002500.safetensors \
    --local-dir /comfyui/models/lora;

hf download ananona/dependencies \
    WAN2.2-HighNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora;

hf download ananona/dependencies \
    WAN2.2-LowNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/lora;

echo "Starting Runpod ComfyUI worker..."
exec python /src/worker.py