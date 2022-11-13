	.file	"utils.c"
	.intel_syntax noprefix
	.text
	.type	is_lower, @function
is_lower:
	# c -> dil
	cmp	dil, 96
	jle	.L2
	cmp	dil, 122
	jg	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	mov	eax, 0
.L3:
	and	eax, 1
	ret
	.size	is_lower, .-is_lower
	.type	is_upper, @function
is_upper:
	# c -> dil
	cmp	dil, 64
	jle	.L6
	cmp	dil, 90
	jg	.L6
	mov	eax, 1
	jmp	.L7
.L6:
	mov	eax, 0
.L7:
	and	eax, 1
	ret
	.size	is_upper, .-is_upper
	.globl	count_letters
	.type	count_letters, @function
count_letters:
	# text -> r10
	# size -> rsi
	# lower_counter -> r8
	# upper_counter -> r9
	# i -> rcx

	mov	r10, rdi
	mov	r8, rdx
	mov	r9, rcx
	mov	DWORD PTR [r8], 0 # *lower_count = 0
	
	mov	DWORD PTR [r9], 0 # *upper_count = 0
	mov	rcx, 0 # i = 0
	jmp	.L10
.L11:
	mov	rdx, r10
	mov	rax, rcx
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax # edi <- text[i]
	call	is_lower
	 
	mov	edx, DWORD PTR [r8] # edx <- *lower_count
	movzx	eax, al
	add	edx, eax # edx += is_lower
	
	mov	DWORD PTR [r8], edx # *lower_count <- edx
	mov	rdx, r10
	mov	rax, rcx
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax # edi <- text[i]
	call	is_upper
	
	mov	edx, DWORD PTR [r9] # edx <- *upper_count
	movzx	eax, al
	add	edx, eax # edx += is_upper
	mov	DWORD PTR [r9], edx # *upper_count <- edx
	add	rcx, 1 # i++
.L10:
	cmp	rcx, rsi
	jb	.L11
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
