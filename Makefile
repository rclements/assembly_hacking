# Simple Makefile that knows how to run the assembler and linker
# for all the examples. To build everything, just run `make`.

TARGETS=HelloWorld JustExit VariableDemo SimpleDemo

all:: $(TARGETS)

%.o: %.s
	as -o $@ $<

HelloWorld: HelloWorld.o
	ld -o $@ $<

JustExit: JustExit.o
	ld -o $@ $<

VariableDemo: VariableDemo.o
	ld -o $@ $<

SimpleDemo: SimpleDemo.c
	gcc -m32 -g -o $@ $<

clean::
	rm -f *.o $(TARGETS)

