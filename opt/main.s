	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	text
	.bss
	.align 32
	.type	text, @object
	.size	text, 1000000001
text:
	.zero	1000000001
	.globl	generated_text
	.align 32
	.type	generated_text, @object
	.size	generated_text, 1000000001
generated_text:
	.zero	1000000001
	.globl	text_size
	.align 8
	.type	text_size, @object
	.size	text_size, 8
text_size:
	.zero	8
	.text
	.globl	input_text
	.type	input_text, @function
input_text:
	push	rbp
	mov	rbp, rsp

	push r12
	push r13

	# c -> r12
	# fin -> r13

	mov	r13, rdi
	mov	QWORD PTR text_size[rip], 0 # text_size = 0;
	jmp	.L2
.L3:
	mov	rax, QWORD PTR text_size[rip]
	lea	rdx, 1[rax] # rdx <- text_size + 1
	mov	QWORD PTR text_size[rip], rdx
	lea	rcx, text[rip]
	movzx	edx, r12b
	mov	BYTE PTR [rax+rcx], dl # text[text_size] = c
.L2:
	mov	rax, r13
	mov	rdi, rax
	call	fgetc@PLT
	mov r12b, al
	cmp	al, -1 # c != EOF
	jne	.L3
	
	pop r13
	pop r12
	
	leave
	ret
	.size	input_text, .-input_text
	.globl	gen_text
	.type	gen_text, @function
gen_text:
	endbr64
	push	rbp
	mov	rbp, rsp

	# size -> r12
	# i -> r13

	push r12
	push r13

	mov	r12, rdi
	mov	edi, 0 # NULL
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	r13, 0 # i = 0
	jmp	.L5
.L6:
	call	rand@PLT
	mov	edx, 126
	sub	edx, 32
	lea	ecx, 1[rdx] # ecx <- (allowed_characters_range_r - allowed_characters_l + 1)
	cdq
	idiv	ecx
	add	edx, 32
	lea	rcx, generated_text[rip]
	mov	rax, r13
	add	rax, rcx
	mov	BYTE PTR [rax], dl
	add	r13, 1
.L5:
	cmp	r13, r12
	jb	.L6
	lea	rdx, generated_text[rip]
	mov	rax, r12
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	
	pop r13
	pop r12
	
	leave
	ret
	.size	gen_text, .-gen_text
	.section	.rodata
.LC0:
	.string	"No parameters are provided\n"
.LC1:
	.string	"-i"
.LC2:
	.string	"-f"
	.align 8
.LC3:
	.string	"Input/output files are not provided\n"
.LC4:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"-g"
	.align 8
.LC7:
	.string	"The size of the generating text is not provided\n"
.LC8:
	.string	"Invalid parameter"
	.align 8
.LC9:
	.string	"The number of lowercase letters is %d.\n"
	.align 8
.LC10:
	.string	"The number of uppercase letters is %d.\n"
	.align 8
.LC12:
	.string	"The average time of the calculating: %f clocks or %f seconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp

	# Структура стека
	# -4 - lower_count
	# -8 - upper_count

	# argc -> r12
	# argv -> r13
	# fin -> r14
	# fout -> r15

	# start -> r12
	# end -> r13

	sub	rsp, 16
	mov r12d, edi
	mov	r13, rsi
	cmp	r12d, 1 
 	jne	.L8 # if (argc == 1)
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 27
	mov	esi, 1
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L20
.L8:
	mov	rax, r13
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	mov	rax, QWORD PTR stdin[rip]
	mov	r14, rax # fin
	mov	rax, QWORD PTR stdout[rip]
	mov	r15, rax
	jmp	.L11
.L10:
	mov	rax, r13
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L12
	cmp	r12d, 3
	jg	.L13
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 36
	mov	esi, 1
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L20
.L13:
	mov	rax, r13
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx # "r"
	mov	rdi, rax # argv[2]
	call	fopen@PLT
	mov	r14, rax # fin
	mov	rax, r13
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx # "w"
	mov	rdi, rax # argv[3]
	call	fopen@PLT
	mov	r15, rax
	jmp	.L11
.L12:
	mov	rax, r13
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L14
	cmp	r12d, 3  # now r12 is free
	je	.L15
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 48
	mov	esi, 1
	lea	rax, .LC7[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L20
.L15:
	mov	rax, r13 # now r13 is free
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cdqe
	mov	r13, rax
	mov	rdi, rax
	call	gen_text
	mov	rax, r13
	lea	rdx, .LC4[rip] # "r"
	mov	rsi, rax # size
	lea	rax, generated_text[rip]
	mov	rdi, rax # generated_text
	call	fmemopen@PLT
	mov	r14, rax
	mov	rax, QWORD PTR stdout[rip]
	mov	r15, rax
	jmp	.L11
.L14:
	mov	rax, QWORD PTR stderr[rip]
	mov	rcx, rax
	mov	edx, 17
	mov	esi, 1
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	fwrite@PLT
	mov	eax, 1
	jmp	.L20
.L11:
	mov	rdi, r14
	call	input_text
	mov	DWORD PTR -4[rbp], 0 # lower_count = 0
	mov	DWORD PTR -64[rbp], 0 # upper_count = 0
	call	clock@PLT
	mov	r12, rax # start = clock();
	mov	ebx, 0
	jmp	.L16
.L17:
	mov	rax, QWORD PTR text_size[rip]
	lea	rcx, -8[rbp] # &upper_count
	lea	rdx, -4[rbp] # &lower_count
	mov	rsi, rax # text_size
	lea	rax, text[rip]
	mov	rdi, rax # text
	call	count_letters@PLT
	add	ebx, 1
.L16:
	mov	eax, ebx
	cmp	eax, 5
	jl	.L17
	call	clock@PLT
	mov	r13, rax # end = clock()
	mov	edx, DWORD PTR -4[rbp] # lower_count
	mov	rax, r15 # fout
	lea	rcx, .LC9[rip]
	mov	rsi, rcx # lower_count
	mov	rdi, rax # fout
	mov	eax, 0
	call	fprintf@PLT
	mov	edx, DWORD PTR -9[rbp] # upper_count
	mov	rax, r15
	lea	rcx, .LC10[rip]
	mov	rsi, rcx
	mov	rdi, rax # fout
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, r13
	sub	rax, r12
	# work with SSE	
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	pxor	xmm1, xmm1
	mov rax, 5
	cvtsi2sd	xmm1, rax
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC11[rip]
	movapd	xmm2, xmm0
	divsd	xmm2, xmm1
	mov	rax, r13
	sub	rax, r12
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	pxor	xmm1, xmm1
	mov rax, 5
	cvtsi2sd	xmm1, rax
	divsd	xmm0, xmm1
	movq	rdx, xmm0
	mov	rax, r15
	movapd	xmm1, xmm2
	movq	xmm0, rdx
	lea	rdx, .LC12[rip]
	mov	rsi, rdx 
	mov	rdi, rax # fout
	mov	eax, 2
	call	fprintf@PLT
	cmp	r14, QWORD PTR stdin[rip]
	
	je	.L18
	mov	rdi, r14 # fin
	call	fclose@PLT
.L18:
	cmp r15, QWORD PTR stdout[rip]
	
	je	.L19
	mov	rdi, r15 # fout
	call	fclose@PLT
.L19:
	mov	eax, 0
.L20:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC11:
	.long	0
	.long	1093567616
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
