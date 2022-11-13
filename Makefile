CFLAGS += -fno-asynchronous-unwind-tables \
		-fno-jump-tables \
		-fno-stack-protector \
		-fno-exceptions

CFLAGS += -Wall

all: main

%.s: %.c
	gcc -S -masm=intel $(CFLAGS) -o $@ $^

main: main.s utils.s
	gcc -o main $^

clean-all:
	rm *.s main

run-tests:
	./main -f tests/1.in tests/output/1.out
	./main -f tests/2.in tests/output/2.out
	./main -f tests/3.in tests/output/3.out
	./main -f tests/4.in tests/output/4.out
	./main -f tests/5.in tests/output/5.out

	./opt/main -f tests/1.in tests/opt_output/1.out
	./opt/main -f tests/2.in tests/opt_output/2.out
	./opt/main -f tests/3.in tests/opt_output/3.out
	./opt/main -f tests/4.in tests/opt_output/4.out
	./opt/main -f tests/5.in tests/opt_output/5.out
