#!/bin/bash

NETWORK_DIR=models/ssd_mobilenet_v2_quantized
PIPELINE_CONFIG=${NETWORK_DIR}/pipeline.config
MODEL_DIR=${NETWORK_DIR}/saved_model
INFERENCE_GRAPH_DIR=${NETWORK_DIR}/output_inference_graph
TFOD_API="modelsLib/research/object_detection"
INPUT_TYPE=image_tensor
MODEL_PREFIX=model.ckpt-$(gum input --placeholder "Enter the last training step checkpoint (Ex. 20000 if the checkpoint is model.ckpt-20000)")

if [ -d "${INFERENCE_GRAPH_DIR}" ]; then
    rm -rf "${INFERENCE_GRAPH_DIR}"
fi

python ${TFOD_API}/export_inference_graph.py \
    --input_type=${INPUT_TYPE} \
    --pipeline_config_path=${PIPELINE_CONFIG} \
    --trained_checkpoint_prefix=${MODEL_DIR}/${MODEL_PREFIX} \
    --output_directory=${INFERENCE_GRAPH_DIR}

cp train_data/label.pbtxt ${INFERENCE_GRAPH_DIR}
