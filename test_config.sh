# Test directory names
TEST_FRAMEWORKS="rv8-bench torch beebs coremark iozone"

# Where to stage our binaries/scripts
STAGING_OUTPUT_DIR=$(pwd)/staging

# Number of runs of each thing
REPS=10

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
