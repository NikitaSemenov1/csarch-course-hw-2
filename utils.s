	.file	"utils.c"
	.intel_syntax noprefix
	.text
	.type	is_lower, @function
is_lower:
	endbr64
	push	rbp
	mov	rbp, rsp
	# Структура стека
	# -4 - letter
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	cmp	BYTE PTR -4[rbp], 96
	jle	.L2
	cmp	BYTE PTR -4[rbp], 122
	jg	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	mov	eax, 0
.L3:
	and	eax, 1
	pop	rbp
	ret
	.size	is_lower, .-is_lower
	.type	is_upper, @function
is_upper:
	endbr64
	push	rbp
	mov	rbp, rsp
	# Структура стека
	# -4 - letter
	mov	eax, edi
	mov	BYTE PTR -4[rbp], al
	cmp	BYTE PTR -4[rbp], 64
	jle	.L6
	cmp	BYTE PTR -4[rbp], 90
	jg	.L6
	mov	eax, 1
	jmp	.L7
.L6:
	mov	eax, 0
.L7:
	and	eax, 1
	pop	rbp
	ret
	.size	is_upper, .-is_upper
	.globl	count_letters
	.type	count_letters, @function
count_letters:
	endbr64
	push	rbp
	mov	rbp, rsp

	# Структура стека
	# -8  - i
	# -24 - text
	# -32 - size
	# -40 - lower_count
	# -48 - upper_count

	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -40[rbp], rdx
	mov	QWORD PTR -48[rbp], rcx
	mov	rax, QWORD PTR -40[rbp]
	mov	DWORD PTR [rax], 0 # *lower_count = 0
	mov	rax, QWORD PTR -48[rbp]
	mov	DWORD PTR [rax], 0 # *upper_count = 0
	mov	QWORD PTR -8[rbp], 0 # i = 0
	jmp	.L10
.L11:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax # edi <- text[i]
	call	is_lower
	mov	rdx, QWORD PTR -40[rbp] 
	mov	edx, DWORD PTR [rdx] # edx <- *lower_count
	movzx	eax, al
	add	edx, eax # edx += is_lower
	mov	rax, QWORD PTR -40[rbp]
	mov	DWORD PTR [rax], edx # *lower_count <- edx
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax # edi <- text[i]
	call	is_upper
	mov	rdx, QWORD PTR -48[rbp]
	mov	edx, DWORD PTR [rdx] # edx <- *upper_count
	movzx	eax, al
	add	edx, eax # edx += is_upper
	mov	rax, QWORD PTR -48[rbp]
	mov	DWORD PTR [rax], edx # *upper_count <- edx
	add	QWORD PTR -8[rbp], 1 # i++
.L10:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -32[rbp]
	jb	.L11
	nop
	nop
	leave
	ret
	.size	count_letters, .-count_letters
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
