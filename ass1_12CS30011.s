# Chander G -- 27/07/14 -- chandergovind@gmail.com 
# 12CS30011 - Commenting x86 assembly code	
	.file	"ass1.c"
	.section	.rodata  # read only data section begins
	.align 4           # instruction to use 4 byte word for everything 

# all string constants needed in the program	
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

  # note sal => Shift Arithmetic Left
	# equivalent to multiplying by 2 for each shift left

	movl	1624(%esp), %edx  # copy i to edx
	movl	%edx, %eax        # eax -> i
	sall	$2, %eax          # eax -> 4i 
	addl	%edx, %eax        # eax -> 4i + i -> 5i
	sall	$2, %eax          # eax -> 4*5i -> 20i
	movl	%eax, %edx        # edx -> 20i
	movl	1628(%esp), %eax  # j
	addl	%edx, %eax        # eax -> j + 20i  
	leal	0(,%eax,4), %edx  # address of 4(20i + j) where 4 stands for 4 bytes
	leal	20(%esp), %eax    # standard adjustment of 20
	addl	%eax, %edx
	movl	$.LC1, %eax
	movl	%edx, 4(%esp)   # second param : &data[i][j] 
	movl	%eax, (%esp)     # first param : the string LC1
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
	movl	1624(%esp), %edx       # copy i to edx
	movl	%edx, %eax             # copy edx to eax
	sall	$2, %eax               # 4i
	addl	%edx, %eax             # 5i 
	sall	$2, %eax               # 20i
	addl	1628(%esp), %eax       # 20i + j
	movl	20(%esp,%eax,4), %edx  # 20 + 4(20i + j) 
	                             # the structure is very similar to scanf before  
	                             # notice the lack of leal 
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)          # param 2 : data[i][j]
	movl	%eax, (%esp)           # param 1 : string LC4 
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

# for whatever reason : the variables passed to the function are accesible at 8 bytes + original location
# must be due to function pointer

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

	cmpl	$1, %eax        # if type == 1
	je	.L16              # jumpt to L16
	jmp	.L14              # jumpt to L14
.L20:
	cmpl	$3, %eax     # comp 3 and type 
	je	.L18           # if type == 3, go to L18

	cmpl	$4, %eax     # comp 4 and type 
	je	.L19           # if type == 4, go to L19

	jmp	.L14           # jump to L14

.L16:
  # if type == 1
	movl	8(%ebp), %eax     # copy n 
	subl	$1, %eax          # eax -> n-1
	cmpl	20(%ebp), %eax    # compare index var and n-1
	jne	.L21                # jump to L21 if inde != n-1

	movl	$0, 12(%esp)      # param 4 : 0
	movl	$2, 8(%esp)       # param 3 : 2
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)     # param 2 : data 
	movl	8(%ebp), %eax
	movl	%eax, (%esp)      # param 1 : n
	call	po

	jmp	.L14
.L21:
  # else part of case 1
	movl	12(%ebp), %eax         # data param copied to eax
	movl	20(%ebp), %edx         # ind copied to  edx
	movl	(%eax,%edx,4), %edx    # edx -> eax + 4*edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)          # param 2: data[0][ind] 
	movl	%eax, (%esp)           # param 1: LC4 string
	call	printf

	movl	20(%ebp), %eax      # copy ind to eax
	addl	$1, %eax
	movl	%eax, 12(%esp)      # param 4 : ind + 1 
	movl	$1, 8(%esp)         # param 3 : 1
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)       # param 2 : data 
	movl	8(%ebp), %eax       # n copied to eax
	movl	%eax, (%esp)        # param 1 : n
	call	po

	jmp	.L14

.L17:
  # case 2
	movl	8(%ebp), %eax   # n copied to eax
	subl	$1, %eax        # eax -> eax -1 
	cmpl	20(%ebp), %eax  # comparing ind and n-1 
	jne	.L23              # if ind != n-1 jump to L23

  # if part of case 2
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)   # param 4: n-1
	movl	$3, 8(%esp)      # param 3: 3
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)    # param 2: data
	movl	8(%ebp), %eax
	movl	%eax, (%esp)     # param 1 : n
	call	po

	jmp	.L14
.L23:
  # else part of case 2
	# same like commented before
	movl	20(%ebp), %edx       # ind
	movl	%edx, %eax
	sall	$2, %eax             # 4ind
	addl	%edx, %eax           # 5ind 
	sall	$4, %eax             # 80ind   
	addl	12(%ebp), %eax       # data
	movl	8(%ebp), %edx        # n
	subl	$1, %edx             # n-1
	movl	(%eax,%edx,4), %edx   
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)        # param 2 : data[ind][n-1] 
	movl	%eax, (%esp)         # param 1 : string LC4
	call	printf

	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)       # param 4 : ind + 1
	movl	$2, 8(%esp)          # param 3 : 2
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)        # param 2 : data 
	movl	8(%ebp), %eax
	movl	%eax, (%esp)         # param 1 : n
	call	po

	jmp	.L14
.L18:
  # case 3
	cmpl	$0, 20(%ebp)        # compare ind and 0  
	jne	.L25                  # if not equal jump to L25

  # if part of case 3
	movl	8(%ebp), %eax       # copy n to eax
	subl	$1, %eax            # eax -> eax - 1
	movl	%eax, 12(%esp)      # param 4 : n - 1
	movl	$4, 8(%esp)         # param 3 : 4
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)       # param 2 : data
	movl	8(%ebp), %eax
	movl	%eax, (%esp)        # param 1 : n
	call	po

	jmp	.L14
.L25:
  # else part of case 3
	# same like before
	movl	8(%ebp), %eax           # n
	leal	-1(%eax), %edx          # n-1
	movl	%edx, %eax     
	sall	$2, %eax                # 4(n-1) 
	addl	%edx, %eax              # 5(n-1) 
	sall	$4, %eax                # 80(n-1)
	addl	12(%ebp), %eax          # 80(n-1) + data
	movl	20(%ebp), %edx          # plus an ind 
	movl	(%eax,%edx,4), %edx     # 4 byte for the whole thing 
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)           # param 2 : data[n-1][ind]
	movl	%eax, (%esp)            # param 1 : string LC4
	call	printf

	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)   # param 4 : ind - 1
	movl	$3, 8(%esp)      # param 3 : 3
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)    # param 2 : data 
	movl	8(%ebp), %eax
	movl	%eax, (%esp)     # param 1 : n
	call	po

	jmp	.L14
.L19:
  # case 4
	cmpl	$0, 20(%ebp)     # compare ind and 0
	je	.L28               # if equal go to L28
.L27:
  # else part of case  4
	# standard printf pattern
	movl	20(%ebp), %edx    # ind   
	movl	%edx, %eax
	sall	$2, %eax          # 4ind  
	addl	%edx, %eax        # 5ind
	sall	$4, %eax          # 80ind
	addl	12(%ebp), %eax    # data
	movl	(%eax), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)     # param 2: data[ind][0]
	movl	%eax, (%esp)      # param 1: the string LC4
	call	printf

	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)    # param 4 : ind - 1
	movl	$4, 8(%esp)       # param 3 : 4
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)     # param 2 : data 
	movl	8(%ebp), %eax
	movl	%eax, (%esp)      # param 1 : n
	call	po

	nop
	jmp	.L14
.L28:
  # if part of case 4
	nop       # no operation          
.L14:
	leave               # return from function
	ret
	.size	po, .-po
  # po function ends

	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
