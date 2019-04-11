#!/bin/bash

source torch_config.sh

cp $TORCH_TESTS ${TEST_OUTPUT_DIR}
cp -r cifarimages ${TEST_OUTPUT_DIR}
cp torch_config.sh ${TEST_OUTPUT_DIR}
