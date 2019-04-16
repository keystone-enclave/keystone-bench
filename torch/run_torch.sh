#!/bin/bash

# Output logs

source $TEST_CONFIG
source torch_config.sh

# can't for various reasons
#set -e

for tst in ${TORCH_TESTS}; do

    echo "Running $tst"
    for RUN_N in $(seq $SHORT_REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        if [[ $RUN_BASELINE == 1 ]]; then
            { time ./${tst}; } &> ${BASE_LOG_FILE}
        fi
        if [[ $RUN_KEYSTONE == 1 ]]; then
            { time ${TEST_RUNNER} ${tst} ${EYRIE_FULL_SUPPORT} 2048 524288 1 0; } &> ${KEYSTONE_LOG_FILE}
        fi
    done
done
