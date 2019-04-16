# Test directory names
TEST_FRAMEWORKS="rv8-bench torch beebs coremark iozone"
# Which things to run
RUN_KEYSTONE=1
RUN_BASELINE=1


# Where to stage our binaries/scripts
STAGING_OUTPUT_DIR=$(pwd)/staging

# Number of runs of each thing, short is for torch/iozone
REPS=2
SHORT_REPS=1

# Where to store logs
LOG_DIR_NAME=logs

# What is the name of the host bin we use?
TEST_RUNNER_NAME=bench-runner.riscv
DEFAULT_USZ=4096

DEFAULT_FSZ=32768
LARGE_FSZ=49152
XLARGE_FSZ=524288
# Various eyrie configs
EYRIE_FULL_SUPPORT_NAME=eyrie-rt
