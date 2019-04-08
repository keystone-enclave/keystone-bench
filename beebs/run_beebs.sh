#!/bin/bash

# Output logs

set -e

for tst in bin/*; do
    tst=$(basename $tst)
    for RUN_N in $(seq $REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        ./bin/${tst} > ${BASE_LOG_FILE} 2> ${BASE_LOG_FILE}.err

        ${TEST_RUNNER} ./bin/${tst} ${EYRIE_FULL_SUPPORT} ${DEFAULT_USZ} ${DEFAULT_FSZ} 0 0 > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err
    done
done
