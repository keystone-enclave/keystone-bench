.PHONY: all bench-runner coremark rv8-bench

all: bench-runner coremark rv8-bench
	rm -rf staging
	./copy_all_tests.sh

coremark:
	make -C ./coremark/ CC=riscv64-unknown-linux-gnu-gcc link
rv8-bench:
	make -C ./rv8-bench/
bench-runner:
	make -C ./bench-runner/

clean:
	make -C ./rv8-bench clean
	make -C ./coremark clean
	make -C ./bench-runner clean
	rm -r staging
