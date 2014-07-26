# 12CS30011 - Commenting x86 assembly code	
	.file	"ass1.c"
	.section	.rodata  # read only data section begins
	.align 4
.LC0:
	.string	"Enter the order of the square matrix: "
.LC1:
	.string	"%d"
	.align 4
.LC2:
	.string	"Enter the matrix in row-major order:"
.LC3:
	.string	"The input matrix is:"
.LC4:
	.string	"%d "
.LC5:
	.string	"In cs order:"

	.text  # x86 instructions section begins            

	.globl	main  # indicates that main should be accessible outside the file
	              # useful in linking etc 
	.type	main, @function  # declares that main is a function
main:
	pushl	%ebp   #push base pointer original value into the stack
	movl	%esp, %ebp	# mov(long) source -> dest 
		                # stores original value in stack pointer to the base pointer

	andl	$-16, %esp  # round off to the nearest 16 byte addr
	                  # needed for some SIMD instructions in main to work properly
										# SIMD -> Singe Instruction Multiple Data
										# Our main actually does NOT need it : try by commenting it out 

	subl	$1632, %esp # making space for our variables: data - (20*20*4) => 1600
	                  #                                 n,i,j - (3*4)    =>   12
										# rounded off to the nearest 32 byte multiple
										# as we need some space on the top of the stack for function parameters

  # standard printf pattern
	movl	$.LC0, %eax    # move starting address of string .LC0 to register eax
	movl	%eax, (%esp)   # move contents of eax to 0 steps from esp
	call	printf         # printf function call

  # standard scanf pattern
	movl	$.LC1, %eax
	leal	1620(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf

	movl	$.LC2, (%esp)
	call	puts
	movl	$0, 1624(%esp)
	jmp	.L2
.L5:
	movl	$0, 1628(%esp)
	jmp	.L3
.L4:
	movl	1624(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %edx
	movl	1628(%esp), %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %edx
	leal	20(%esp), %eax
	addl	%eax, %edx
	movl	$.LC1, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf
	addl	$1, 1628(%esp)
.L3:
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	jl	.L4
	addl	$1, 1624(%esp)
.L2:
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	jl	.L5
	movl	$.LC3, (%esp)
	call	puts
	movl	$0, 1624(%esp)
	jmp	.L6
.L9:
	movl	$0, 1628(%esp)
	jmp	.L7
.L8:
	movl	1624(%esp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	1628(%esp), %eax
	movl	20(%esp,%eax,4), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	addl	$1, 1628(%esp)
.L7:
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	jl	.L8
	movl	$10, (%esp)
	call	putchar
	addl	$1, 1624(%esp)
.L6:
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	jl	.L9
	movl	$.LC5, (%esp)
	call	puts
	movl	1620(%esp), %eax
	leal	20(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	cs
	movl	$0, %eax       # eax is function return value
	                     # basically return 0 of main

	leave                # resets stack and base pointer value from initally saved one
	ret                  # returns control by popping instruction pointer 
	.size	main, .-main   # end of main function

	.section	.rodata    # read only data section once more
.LC6:
	.string	"%d\n"

	.text               # x86 instructions once more

  #cs function begins
	.globl	cs           
	.type	cs, @function  
cs:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	cmpl	$0, 8(%ebp)
	jne	.L11
	movl	$10, (%esp)
	call	putchar
	jmp	.L10
.L11:
	cmpl	$1, 8(%ebp)
	jne	.L13
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC6, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	jmp	.L10
.L13:
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	movl	12(%ebp), %eax
	leal	84(%eax), %edx
	movl	8(%ebp), %eax
	subl	$2, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	cs
.L10:
	leave
	ret
	.size	cs, .-cs
  # cs function ends

  # po function starts
	.globl	po
	.type	po, @function
po:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	16(%ebp), %eax
	cmpl	$2, %eax
	je	.L17
	cmpl	$2, %eax
	jg	.L20
	cmpl	$1, %eax
	je	.L16
	jmp	.L14
.L20:
	cmpl	$3, %eax
	je	.L18
	cmpl	$4, %eax
	je	.L19
	jmp	.L14
.L16:
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L21
	movl	$0, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L21:
	movl	12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	(%eax,%edx,4), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L17:
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L23
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L23:
	movl	20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	8(%ebp), %edx
	subl	$1, %edx
	movl	(%eax,%edx,4), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L18:
	cmpl	$0, 20(%ebp)
	jne	.L25
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L25:
	movl	8(%ebp), %eax
	leal	-1(%eax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	(%eax,%edx,4), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	jmp	.L14
.L19:
	cmpl	$0, 20(%ebp)
	je	.L28
.L27:
	movl	20(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	nop
	jmp	.L14
.L28:
	nop
.L14:
	leave
	ret
	.size	po, .-po
  # po function ends

	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
