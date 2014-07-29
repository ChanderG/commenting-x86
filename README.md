#Commenting-x86

###What?
The C code in ass1.c has been converted to assembly language and heavily commented to understand. The assembly language here is x86-32.
The important file here is cass1.s meaning commented-ass1.s

If you are new to assembly, some pointers:

* This is x86-32 also called IA-32.
* This is a CISC ISA.
* If you are looking for a RISC ISA, search for MIPS etc.
* The instructions given below are for a 64 bit machine.

###Build Instructions

```
cc -Wall -g -S -m32 -fno-asynchronous-unwind-tables ass1.c
```
creates the base ass1.s program for 32 bit machine.It removes cfi directives and debug information.

To ensure the created assembly code runs, 

```
cc -m32 cass1.s
./a.out
```
this takes the assembly code and creates the corresponding binary and runs it.
