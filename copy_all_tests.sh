#!/bin/bash

set -e

KEYSTONE_BINS_DIR=${KEYSTONE_DIR}/sdk/bin/

source test_config.sh

mkdir ${STAGING_OUTPUT_DIR}

for testf in $TEST_FRAMEWORKS; do
    export TEST_OUTPUT_DIR=${STAGING_OUTPUT_DIR}/${testf}
    mkdir ${TEST_OUTPUT_DIR}
    cd $testf
    ./copy_${testf}.sh
    cp run_${testf}.sh ${TEST_OUTPUT_DIR}
    cp process_${testf}.sh ${TEST_OUTPUT_DIR}
    cd ..
done

cp run_all_tests.sh ${STAGING_OUTPUT_DIR}

cp test_config.sh ${STAGING_OUTPUT_DIR}

KEYSTONE_BINS=" ${EYRIE_FULL_SUPPORT_NAME}"

for bin in $KEYSTONE_BINS; do
    cp ${KEYSTONE_BINS_DIR}/${bin} ${STAGING_OUTPUT_DIR}
done

cp bench-runner/bench-runner.riscv ${STAGING_OUTPUT_DIR}
