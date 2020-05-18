.PHONY: all bench-runner coremark rv8-bench eyrie-rt

all: bench-runner coremark rv8-bench eyrie-rt
	rm -rf staging
	./copy_all_tests.sh

coremark:
	make -C ./coremark/ CC=riscv64-unknown-linux-gnu-gcc PORT_DIR=rv64 compile
rv8-bench:
	make -C ./rv8-bench/
bench-runner:
	make -C ./bench-runner/
eyrie-rt:
	${KEYSTONE_DIR}/sdk/rts/eyrie/build.sh freemem untrusted_io_syscall env_setup linux_syscall
clean:
	make -C ./rv8-bench clean
	make -C ./coremark clean
	make -C ./bench-runner clean
	rm -r staging
