#!/bin/bash

# Output logs
source $TEST_CONFIG
set -e

for RUN_N in $(seq $REPS); do

    BASE_LOG_FILE=${TEST_LOG_DIR}/base_coremark_${RUN_N}.log
    KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_coremark_${RUN_N}.log

    if [[ $RUN_BASELINE == 1 ]]; then
        ./coremark.exe > ${BASE_LOG_FILE} 2> ${BASE_LOG_FILE}.err
    fi
    if [[ $RUN_KEYSTONE == 1 ]]; then
        ${TEST_RUNNER} coremark.exe ${EYRIE_FULL_SUPPORT} 2048 49152 0 0 > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err
    fi
done
