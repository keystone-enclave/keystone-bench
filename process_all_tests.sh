#!/bin/bash

source test_config.sh

LOG_DIR=$(pwd)/${LOG_DIR_NAME}
TEST_RUNNER=$(pwd)/${TEST_RUNNER_NAME}
EYRIE_FULL_SUPPORT=$(pwd)/${EYRIE_FULL_SUPPORT_NAME}

export REPS

for testf in $TEST_FRAMEWORKS; do
    cd $testf
    export TEST_LOG_DIR=${LOG_DIR}/$testf
    ./process_${testf}.sh
    cd ..
done
