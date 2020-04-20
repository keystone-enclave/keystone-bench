Benchmarking tools for Keystone modifications.

Partially functional, rv8 tests should be fine.

You will need to have a complete build of the rv8 musl toolchain
somewhere on your PATH!

You will also need to ensure your buildroot build has BASH as its
default shell!

Then, `KEYSTONE_DIR=PATH_TO_KEYSTONE_ROOT_DIR make`, copy the entire
`staging/` directory into your keystone's `build/overlay/root/`,
rebuild the keystone image, and run `run_all_tests.sh`.
