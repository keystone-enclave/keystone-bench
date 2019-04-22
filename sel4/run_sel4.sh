#!/bin/bash

# Output logs

source $TEST_CONFIG

# can't for various reasons
#set -e
idx=0
for tst in tests/*; do
    tst=$(basename $tst)
    echo "Running $tst"
    for RUN_N in $(seq $SHORT_REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        # Cannot run these
        # if [[ $RUN_BASELINE == 1 ]]; then
        #     { time ./${tst}; } &> ${BASE_LOG_FILE}
        # fi
        if [[ $RUN_KEYSTONE == 1 ]]; then
            { time ${TEST_RUNNER} tests/${tst} rt_sel4 ${DEFAULT_USZ} 524288 1 0 0x40000000; } &> ${KEYSTONE_LOG_FILE}
        fi
    done

done
