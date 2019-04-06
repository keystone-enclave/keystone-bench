#!/bin/bash

# Output logs

for RUN_N in $(seq $REPS); do

    BASE_LOG_FILE=${TEST_LOG_DIR}/base_iozone_${RUN_N}.log
    KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_iozone_${RUN_N}.log

    ./iozone > ${BASE_LOG_FILE}

    ${TEST_RUNNER} iozone ${EYRIE_FULL_SUPPORT} > ${KEYSTONE_LOG_FILE}
done
