#!/bin/bash

# Output logs

set -e

for RUN_N in $(seq $REPS); do

    BASE_LOG_FILE=${TEST_LOG_DIR}/base_iozone_${RUN_N}.log
    KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_iozone_${RUN_N}.log

    ./iozone > ${BASE_LOG_FILE} 2> ${BASE_LOG_FILE}.err

    mv results.xls ${BASE_LOG_FILE}.xls

    ${TEST_RUNNER} iozone ${EYRIE_FULL_SUPPORT} 2048 49152 0 0 > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err

    mv results.xls ${KEYSTONE_LOG_FILE}.xls
done
