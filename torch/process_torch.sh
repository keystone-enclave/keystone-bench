#!/bin/bash

source $TEST_CONFIG
source torch_config.sh

for tst in ${TORCH_TESTS}; do
    tst=$(basename $tst)
    TEST_LOG_FILE=${TEST_LOG_DIR}/BASE_${tst}.log
    KTEST_LOG_FILE=${TEST_LOG_DIR}/KEYSTONE_${tst}.log
    rm -f ${TEST_LOG_FILE}
    rm -f ${KTEST_LOG_FILE}
    for RUN_N in $(seq $SHORT_REPS); do

        BASE_LOG_FILE=${TEST_LOG_DIR}/base_${tst}_${RUN_N}.log
        KEYSTONE_LOG_FILE=${TEST_LOG_DIR}/keystone_${tst}_${RUN_N}.log

        if [[ $RUN_BASELINE == 1 ]]; then
            cat ${BASE_LOG_FILE} | grep "real" | cut -d' ' -f '2' >> ${TEST_LOG_FILE}
        fi

        if [[ $RUN_KEYSTONE == 1 ]]; then
            cat ${KEYSTONE_LOG_FILE} | grep "real" | cut -d' ' -f '2' >> ${KTEST_LOG_FILE}
            cat ${KEYSTONE_LOG_FILE} | grep "Init:"  >> ${KTEST_LOG_FILE}
            cat ${KEYSTONE_LOG_FILE} | grep "Runtime:" >> ${KTEST_LOG_FILE}
        fi

    done;

    echo ${tst} >> ${TEST_LOG_DIR}/TESTLIST
done;
