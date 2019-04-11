#!/bin/bash

# Output logs

set -e

for tst in riscv64/*; do
    tst=$(basename $tst)
    for RUN_N in $(seq $REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        { time ./riscv64/${tst}; } &> ${BASE_LOG_FILE}

        ${TEST_RUNNER} ./riscv64/${tst} ${EYRIE_FULL_SUPPORT} ${DEFAULT_USZ} ${XLARGE_FSZ} 1 0 > ${KEYSTONE_LOG_FILE} 2> ${KEYSTONE_LOG_FILE}.err
    done
done
