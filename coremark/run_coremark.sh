#!/bin/bash

# Output logs

for RUN_N in $(seq $REPS); do

    BASE_LOG_FILE=${TEST_LOG_DIR}/base_coremark_${RUN_N}.log
    KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_coremark_${RUN_N}.log

    ./coremark.exe > ${BASE_LOG_FILE}

    ${TEST_RUNNER} coremark.exe ${EYRIE_FULL_SUPPORT} > ${KEYSTONE_LOG_FILE}
done
