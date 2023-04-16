#!/bin/bash

NETWORK_DIR=models/ssd_mobilenet_v2_quantized
PIPELINE_CONFIG=${NETWORK_DIR}/pipeline.config
MODEL_DIR=${NETWORK_DIR}/saved_model
INFERENCE_GRAPH_DIR=${NETWORK_DIR}/tflite
TFOD_API="modelsLib/research/object_detection"
INPUT_TYPE=image_tensor
MODEL_PREFIX=model.ckpt-42408

if [ -d "${INFERENCE_GRAPH_DIR}" ]; then
    rm -rf "${INFERENCE_GRAPH_DIR}"
fi

python ${TFOD_API}/export_tflite_ssd_graph.py \
    --pipeline_config_path=${PIPELINE_CONFIG} \
    --trained_checkpoint_prefix=${MODEL_DIR}/${MODEL_PREFIX} \
    --output_directory=${INFERENCE_GRAPH_DIR} \
    --add_postprocessing_op=true

tflite_convert \
    --graph_def_file=${INFERENCE_GRAPH_DIR}/tflite_graph.pb \
    --output_file=${INFERENCE_GRAPH_DIR}/detect.tflite \
    --input_shapes=1,300,300,3 \
    --input_arrays=normalized_input_image_tensor \
    --output_arrays="TFLite_Detection_PostProcess","TFLite_Detection_PostProcess:1","TFLite_Detection_PostProcess:2","TFLite_Detection_PostProcess:3" \
    --inference_type=QUANTIZED_UINT8 \
    --mean_values=128 \
    --std_dev_values=128 \
    --change_concat_input_ranges=false \
    --allow_custom_ops

cp train_data/label.pbtxt ${INFERENCE_GRAPH_DIR}
