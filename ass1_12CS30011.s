	.file	"ass1_12CS30011.c"
	.text
.Ltext0:
	.section	.rodata
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.file 1 "ass1_12CS30011.c"
	.loc 1 9 0
	.cfi_startproc
	pushl	%ebp
.LCFI0:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI1:
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$1632, %esp
	.loc 1 12 0
	movl	$.LC0, %eax
	movl	%eax, (%esp)
	call	printf
	.loc 1 13 0
	movl	$.LC1, %eax
	leal	1620(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf
	.loc 1 14 0
	movl	$.LC2, (%esp)
	call	puts
	.loc 1 15 0
	movl	$0, 1624(%esp)
	jmp	.L2
.L5:
	.loc 1 16 0
	movl	$0, 1628(%esp)
	jmp	.L3
.L4:
	.loc 1 17 0 discriminator 2
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
	.loc 1 16 0 discriminator 2
	addl	$1, 1628(%esp)
.L3:
	.loc 1 16 0 is_stmt 0 discriminator 1
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	jl	.L4
	.loc 1 15 0 is_stmt 1
	addl	$1, 1624(%esp)
.L2:
	.loc 1 15 0 is_stmt 0 discriminator 1
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	jl	.L5
	.loc 1 18 0 is_stmt 1
	movl	$.LC3, (%esp)
	call	puts
	.loc 1 19 0
	movl	$0, 1624(%esp)
	jmp	.L6
.L9:
	.loc 1 20 0
	movl	$0, 1628(%esp)
	jmp	.L7
.L8:
	.loc 1 20 0 is_stmt 0 discriminator 2
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
	.loc 1 20 0 discriminator 1
	movl	1620(%esp), %eax
	cmpl	%eax, 1628(%esp)
	jl	.L8
	.loc 1 21 0 is_stmt 1
	movl	$10, (%esp)
	call	putchar
	.loc 1 19 0
	addl	$1, 1624(%esp)
.L6:
	.loc 1 19 0 is_stmt 0 discriminator 1
	movl	1620(%esp), %eax
	cmpl	%eax, 1624(%esp)
	jl	.L9
	.loc 1 23 0 is_stmt 1
	movl	$.LC5, (%esp)
	call	puts
	.loc 1 24 0
	movl	1620(%esp), %eax
	leal	20(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	cs
	.loc 1 25 0
	movl	$0, %eax
	.loc 1 26 0
	leave
	.cfi_restore 5
.LCFI2:
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
.LC6:
	.string	"%d\n"
	.text
	.globl	cs
	.type	cs, @function
cs:
.LFB1:
	.loc 1 27 0
	.cfi_startproc
	pushl	%ebp
.LCFI3:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI4:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 1 28 0
	cmpl	$0, 8(%ebp)
	jne	.L11
	.loc 1 29 0
	movl	$10, (%esp)
	call	putchar
	.loc 1 30 0
	jmp	.L10
.L11:
	.loc 1 32 0
	cmpl	$1, 8(%ebp)
	jne	.L13
	.loc 1 33 0
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	$.LC6, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	.loc 1 34 0
	jmp	.L10
.L13:
	.loc 1 36 0
	movl	$0, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 37 0
	movl	12(%ebp), %eax
	leal	84(%eax), %edx
	movl	8(%ebp), %eax
	subl	$2, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	cs
.L10:
	.loc 1 38 0
	leave
	.cfi_restore 5
.LCFI5:
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	cs, .-cs
	.globl	po
	.type	po, @function
po:
.LFB2:
	.loc 1 40 0
	.cfi_startproc
	pushl	%ebp
.LCFI6:
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
.LCFI7:
	.cfi_def_cfa_register 5
	subl	$24, %esp
	.loc 1 41 0
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
	.loc 1 43 0
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L21
	.loc 1 43 0 is_stmt 0 discriminator 1
	movl	$0, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 48 0 is_stmt 1 discriminator 1
	jmp	.L14
.L21:
	.loc 1 45 0
	movl	12(%ebp), %eax
	movl	20(%ebp), %edx
	movl	(%eax,%edx,4), %edx
	movl	$.LC4, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	.loc 1 46 0
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$1, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 48 0
	jmp	.L14
.L17:
	.loc 1 50 0
	movl	8(%ebp), %eax
	subl	$1, %eax
	cmpl	20(%ebp), %eax
	jne	.L23
	.loc 1 50 0 is_stmt 0 discriminator 1
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 55 0 is_stmt 1 discriminator 1
	jmp	.L14
.L23:
	.loc 1 52 0
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
	.loc 1 53 0
	movl	20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$2, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 55 0
	jmp	.L14
.L18:
	.loc 1 57 0
	cmpl	$0, 20(%ebp)
	jne	.L25
	.loc 1 57 0 is_stmt 0 discriminator 1
	movl	8(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 62 0 is_stmt 1 discriminator 1
	jmp	.L14
.L25:
	.loc 1 59 0
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
	.loc 1 60 0
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$3, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 62 0
	jmp	.L14
.L19:
	.loc 1 64 0
	cmpl	$0, 20(%ebp)
	je	.L28
.L27:
	.loc 1 66 0
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
	.loc 1 67 0
	movl	20(%ebp), %eax
	subl	$1, %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	po
	.loc 1 69 0
	nop
	jmp	.L14
.L28:
	.loc 1 64 0
	nop
.L14:
	.loc 1 71 0
	leave
	.cfi_restore 5
.LCFI8:
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	po, .-po
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x16b
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.long	.LASF13
	.byte	0x1
	.long	.LASF14
	.long	.LASF15
	.long	.Ltext0
	.long	.Letext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x3
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF7
	.uleb128 0x2
	.byte	0x4
	.byte	0x5
	.long	.LASF8
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF9
	.uleb128 0x4
	.byte	0x1
	.long	.LASF11
	.byte	0x1
	.byte	0x8
	.long	0x4f
	.long	.LFB0
	.long	.LFE0
	.long	.LLST0
	.long	0xc4
	.uleb128 0x5
	.string	"n"
	.byte	0x1
	.byte	0xa
	.long	0x4f
	.byte	0x3
	.byte	0x74
	.sleb128 1620
	.uleb128 0x5
	.string	"i"
	.byte	0x1
	.byte	0xa
	.long	0x4f
	.byte	0x3
	.byte	0x74
	.sleb128 1624
	.uleb128 0x5
	.string	"j"
	.byte	0x1
	.byte	0xa
	.long	0x4f
	.byte	0x3
	.byte	0x74
	.sleb128 1628
	.uleb128 0x6
	.long	.LASF10
	.byte	0x1
	.byte	0xb
	.long	0xc4
	.byte	0x2
	.byte	0x74
	.sleb128 20
	.byte	0
	.uleb128 0x7
	.long	0x4f
	.long	0xda
	.uleb128 0x8
	.long	0x25
	.byte	0x13
	.uleb128 0x8
	.long	0x25
	.byte	0x13
	.byte	0
	.uleb128 0x9
	.byte	0x1
	.string	"cs"
	.byte	0x1
	.byte	0x1b
	.byte	0x1
	.long	.LFB1
	.long	.LFE1
	.long	.LLST1
	.long	0x10d
	.uleb128 0xa
	.string	"n"
	.byte	0x1
	.byte	0x1b
	.long	0x4f
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xb
	.long	.LASF10
	.byte	0x1
	.byte	0x1b
	.long	0x11d
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.byte	0
	.uleb128 0x7
	.long	0x4f
	.long	0x11d
	.uleb128 0x8
	.long	0x25
	.byte	0x13
	.byte	0
	.uleb128 0xc
	.byte	0x4
	.long	0x10d
	.uleb128 0xd
	.byte	0x1
	.string	"po"
	.byte	0x1
	.byte	0x28
	.byte	0x1
	.long	.LFB2
	.long	.LFE2
	.long	.LLST2
	.uleb128 0xa
	.string	"n"
	.byte	0x1
	.byte	0x28
	.long	0x4f
	.byte	0x2
	.byte	0x91
	.sleb128 0
	.uleb128 0xb
	.long	.LASF10
	.byte	0x1
	.byte	0x28
	.long	0x11d
	.byte	0x2
	.byte	0x91
	.sleb128 4
	.uleb128 0xb
	.long	.LASF12
	.byte	0x1
	.byte	0x28
	.long	0x4f
	.byte	0x2
	.byte	0x91
	.sleb128 8
	.uleb128 0xa
	.string	"ind"
	.byte	0x1
	.byte	0x28
	.long	0x4f
	.byte	0x2
	.byte	0x91
	.sleb128 12
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.long	.LFB0-.Ltext0
	.long	.LCFI0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI0-.Ltext0
	.long	.LCFI1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI1-.Ltext0
	.long	.LCFI2-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI2-.Ltext0
	.long	.LFE0-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST1:
	.long	.LFB1-.Ltext0
	.long	.LCFI3-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI3-.Ltext0
	.long	.LCFI4-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI4-.Ltext0
	.long	.LCFI5-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI5-.Ltext0
	.long	.LFE1-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
.LLST2:
	.long	.LFB2-.Ltext0
	.long	.LCFI6-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	.LCFI6-.Ltext0
	.long	.LCFI7-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 8
	.long	.LCFI7-.Ltext0
	.long	.LCFI8-.Ltext0
	.value	0x2
	.byte	0x75
	.sleb128 8
	.long	.LCFI8-.Ltext0
	.long	.LFE2-.Ltext0
	.value	0x2
	.byte	0x74
	.sleb128 4
	.long	0
	.long	0
	.section	.debug_aranges,"",@progbits
	.long	0x1c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x4
	.byte	0
	.value	0
	.value	0
	.long	.Ltext0
	.long	.Letext0-.Ltext0
	.long	0
	.long	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF6:
	.string	"long long int"
.LASF2:
	.string	"short unsigned int"
.LASF12:
	.string	"type"
.LASF13:
	.string	"GNU C 4.6.3"
.LASF3:
	.string	"long unsigned int"
.LASF7:
	.string	"long long unsigned int"
.LASF10:
	.string	"data"
.LASF1:
	.string	"unsigned char"
.LASF11:
	.string	"main"
.LASF15:
	.string	"/media/Storage/Grow/Kgp/Sem5/Compilers/Lab/Assignment1"
.LASF8:
	.string	"long int"
.LASF4:
	.string	"signed char"
.LASF5:
	.string	"short int"
.LASF0:
	.string	"unsigned int"
.LASF9:
	.string	"char"
.LASF14:
	.string	"ass1_12CS30011.c"
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
