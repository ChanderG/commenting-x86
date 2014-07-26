#Assignment 1

###What?
See specifications in Assignment1.pdf
The important file here is cass1.s meaning commented-ass1.s

###Build Instructions

```
cc -Wall -g -S -m32 -fno-asynchronous-unwind-tables ass1.c
```
creates the base ass1.s program for 32 bit machine.

To ensure the created assembly code runs, 

```
cc -m32 ass1.s
```
this takes the assembly code and creates the corresponding binary.
