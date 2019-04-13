#!/bin/bash

source test_config.sh

LOG_DIR=$(pwd)/${LOG_DIR_NAME}
TEST_RUNNER=$(pwd)/${TEST_RUNNER_NAME}
EYRIE_FULL_SUPPORT=$(pwd)/${EYRIE_FULL_SUPPORT_NAME}

export REPS
export TEST_RUNNER
export EYRIE_FULL_SUPPORT
export DEFAULT_USZ
export DEFAULT_FSZ
export LARGE_FSZ
export XLARGE_FSZ

mkdir $LOG_DIR

echo "Eyrie: " > ${LOG_DIR}/CONFIG
md5sum ${EYRIE_FULL_SUPPORT} >> ${LOG_DIR}/CONFIG

echo "" >> ${LOG_DIR}/CONFIG

echo "Test runner: " >> ${LOG_DIR}/CONFIG
md5sum ${TEST_RUNNER} >> ${LOG_DIR}/CONFIG

for testf in $TEST_FRAMEWORKS; do
    cd $testf
    export TEST_LOG_DIR=${LOG_DIR}/$testf
    mkdir -p $TEST_LOG_DIR
    ./run_${testf}.sh
    ./process_${testf}.sh
    cd ..
done
