#!/bin/bash

PIPELINE_CONFIG="models/ssd_mobilenet_v2_quantized/pipeline.config"
MODEL_DIR="models/ssd_mobilenet_v2_quantized/saved_model"
TFOD_API="modelsLib/research/object_detection"

python ${TFOD_API}/model_main.py \
    --pipeline_config_path=${PIPELINE_CONFIG} \
    --model_dir=${MODEL_DIR} \
    --alsologtostderr