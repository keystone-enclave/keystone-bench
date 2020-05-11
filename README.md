Benchmarking tools for Keystone modifications.

Partially functional, rv8 tests should be fine.

You will need to have a complete build of the rv8 musl toolchain
somewhere on your PATH!

Then, `KEYSTONE_DIR=PATH_TO_KEYSTONE_ROOT_DIR make`, copy the entire
`staging/` directory into your keystone's `build/overlay/root/`,
rebuild the keystone image, and run `run_all_tests.sh` after booting
and inserting the module.

You will need to copy the logs directory out when done, it will not
persist by default in our images.
