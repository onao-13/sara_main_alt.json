# --- Login to Hugginface ---
set -e;
hf auth login --token ${HF_TOKEN};

# --- PRIVATE MODELS THROUGH HUGGINGFACE-CLI ---
hf download ananona/dependencies \
    sara_lora_000002500.safetensors \
    --local-dir /comfyui/models/loras;

hf download ananona/dependencies \
    WAN2.2-HighNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/loras;

hf download ananona/dependencies \
    WAN2.2-LowNoise_SmartphoneSnapshotPhotoReality_v3_by-AI_Characters.safetensors \
    --local-dir /comfyui/models/loras;

echo "Starting ComfyUI"

python -u /comfyui/main.py --disable-auto-launch --disable-metadata --log-stdout &

echo "Starting ComfyUI Handler"
python -u /handler.py