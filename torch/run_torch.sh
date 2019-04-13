#!/bin/bash

# Output logs

source torch_config.sh

set -e

for tst in ${TORCH_TESTS}; do
    for RUN_N in $(seq $REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        { time ./${tst}; } &> ${BASE_LOG_FILE}

        ${TEST_RUNNER} ${tst} ${EYRIE_FULL_SUPPORT} 2048 524288 1 0 > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err
    done
done
