#Assignment 1

###What?
See specifications in Assignment1.pdf

###Build Instructions

```
cc -Wall -g -S -m32 ass1.c
```
creates the base ass1.s program for 32 bit machine.

To ensure the created assembly code runs, 

```
cc -m32 ass1.s
```
this takes the assembly code and creates the corresponding binary.
