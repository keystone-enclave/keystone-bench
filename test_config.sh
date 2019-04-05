# Test directory names
TEST_FRAMEWORKS="coremark beebs"

# Where to stage our binaries/scripts
STAGING_OUTPUT_DIR=$(pwd)/test_staging

# Number of runs of each thing
REPS=10

# Where to store logs
LOG_DIR_NAME=logs

# What is the name of the host bin we use?
TEST_RUNNER_NAME=test_runner.riscv

# Various eyrie configs
EYRIE_FULL_SUPPORT_NAME=eyrie-rt
