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
	leal	1620(%esp), %edx # int n is stored in 1620(esp)
	movl	%edx, 4(%esp)   # second paramenter for scanf
	movl	%eax, (%esp)    # first parameter for scanf 
	call	__isoc99_scanf  # the function parameters are stored in the stack
	                      # from the top in intervals of 4 byte addresses

  # standard puts pattern
	movl	$.LC2, (%esp)  # puts is used instead of printf with \n
	call	puts

	movl	$0, 1624(%esp) # int i is stored in 1624(esp)
	                     # and it is initialized with 0
	jmp	.L2              # jump to label L2
.L5:
	movl	$0, 1628(%esp) # int j is stored in 1628(esp)
	                     # here set j = 0
	jmp	.L3
	
	# body of first nested for loop
.L4:                 
  # scanf pattern with 2d array address
	movl	1624(%esp), %edx  # copy i to edx
	movl	%edx, %eax        # copy edx to eax 
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

	addl	$1, 1628(%esp)   # increment j
.L3:
	movl	1620(%esp), %eax   # copy n to eax
	cmpl	%eax, 1628(%esp)   # compare n and j
	jl	.L4                  # if j < n jump to .L4
	addl	$1, 1624(%esp)     # increment i
.L2:
	movl	1620(%esp), %eax   # copy n to eax
	cmpl	%eax, 1624(%esp)   # compare n and i
	                         # note that compl compares second with first

	jl	.L5                  # jump if less flag has been set
	                         # here means if i < n jump to .L5

  # standard puts pattern 
	movl	$.LC3, (%esp)      
	call	puts

	movl	$0, 1624(%esp)     # set i = 0
	jmp	.L6
.L9:
	movl	$0, 1628(%esp)     # set j = 0
	jmp	.L7                  # jump to L7
.L8:
	movl	1624(%esp), %edx   # copy i to edx
	movl	%edx, %eax         # copy edx to eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	1628(%esp), %eax
	movl	20(%esp,%eax,4), %edx   
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf

	addl	$1, 1628(%esp)      # increment j by one
.L7:
	movl	1620(%esp), %eax    # move n to eax 
	cmpl	%eax, 1628(%esp)    # is j < n
	jl	.L8                   # if true jump to L8

	movl	$10, (%esp)         # 10 stands for \n
	call	putchar
	addl	$1, 1624(%esp)      # increment i
.L6:
	movl	1620(%esp), %eax    # move n to eax
	cmpl	%eax, 1624(%esp)    # is i < n
	jl	.L9                   # if true jump to L9  

	# standard puts pattern
	movl	$.LC5, (%esp)
	call	puts

  # function call - cs
	movl	1620(%esp), %eax   # copy n value to eax 
	leal	20(%esp), %edx     # copy data[0][0] address to eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)    
	call	cs                 # call cs with the parameters in bottom-top order

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
  # standard base ,stack ptr save
	pushl	%ebp
	movl	%esp, %ebp

  # make space 
	subl	$24, %esp
	cmpl	$0, 8(%ebp)    # compare n and 0 
	jne	.L11             # if not equal, jump to L11

  # if n == 0
	movl	$10, (%esp)    # print newline, 10 is for \n
	call	putchar

	jmp	.L10
.L11:
	cmpl	$1, 8(%ebp)   # compare n and 1
	jne	.L13            # if not equal , jump to L13

  # if n == 1
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC6, %eax
	movl	%edx, 4(%esp)   # second param: data[0][0] 
	movl	%eax, (%esp)    # first param: the string LC6
	call	printf

	jmp	.L10
.L13:
	movl	$0, 12(%esp)    # fourth parameter to po: 0
	movl	$1, 8(%esp)     # third parameter to po: 1
	movl	12(%ebp), %eax  # move data value to eax
	movl	%eax, 4(%esp)   # second parameter to po: data addr
	movl	8(%ebp), %eax   # copy n value to eax 
	movl	%eax, (%esp)    # first parameter to po: n
	call	po

	movl	12(%ebp), %eax  # get data into eax
	leal	84(%eax), %edx  # move 84 addresses from eax
                        # 4*(20) + 4 => &data[1][1]
	movl	8(%ebp), %eax   # copy n to eax
	subl	$2, %eax        # eax -> eax - 2
	movl	%edx, 4(%esp)   # second param
	movl	%eax, (%esp)    # first param : n-2 
	call	cs
.L10:
	leave                 # exiting the function
	ret
	.size	cs, .-cs
  # cs function ends

  # po function starts
	.globl	po
	.type	po, @function
po:
  # standard function opening
	pushl	%ebp
	movl	%esp, %ebp

	# make additional space 
	subl	$24, %esp
	movl	16(%ebp), %eax  # value of type variable

	cmpl	$2, %eax        # compare 2 and type
	je	.L17              # jump to L17 if type == 2

	cmpl	$2, %eax        # comp 2 and type 
	jg	.L20              # if type > 2, go to L20

	cmpl	$1, %eax
	je	.L16
	jmp	.L14
.L20:
	cmpl	$3, %eax     # comp 3 and type 
	je	.L18
	cmpl	$4, %eax     # comp 4 and type 
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
