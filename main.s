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
	endbr64
	push	rbp
	mov	rbp, rsp
	# Структура стека
	# rbp_last
	# -1  - c
	# -24 - fin
	
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR text_size[rip], 0 # text_size = 0;
	jmp	.L2
.L3:
	mov	rax, QWORD PTR text_size[rip]
	lea	rdx, 1[rax] # rdx <- text_size + 1
	mov	QWORD PTR text_size[rip], rdx
	lea	rcx, text[rip]
	movzx	edx, BYTE PTR -1[rbp]
	mov	BYTE PTR [rax+rcx], dl # text[text_size] = c
.L2:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -1[rbp], al
	cmp	BYTE PTR -1[rbp], -1 # c != EOF
	jne	.L3
	nop
	nop
	leave
	ret
	.size	input_text, .-input_text
	.globl	gen_text
	.type	gen_text, @function
gen_text:
	endbr64
	push	rbp
	mov	rbp, rsp

	# Структура стека
	# rbp_last
	# -12 - allowed_characters_range_l
	# -16 - allowed_characters_range_r
	# -24 - size
	# -8 - i

	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -12[rbp], 32
	mov	DWORD PTR -16[rbp], 126
	mov	edi, 0 # NULL
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	mov	QWORD PTR -8[rbp], 0 # i = 0
	jmp	.L5
.L6:
	call	rand@PLT
	mov	edx, DWORD PTR -16[rbp]
	sub	edx, DWORD PTR -12[rbp]
	lea	ecx, 1[rdx] # ecx <- (allowed_characters_range_r - allowed_characters_l + 1)
	cdq
	idiv	ecx
	mov	eax, edx
	mov	edx, eax # )
	mov	eax, DWORD PTR -12[rbp]
	add	eax, edx
	mov	edx, eax
	lea	rcx, generated_text[rip]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rcx
	mov	BYTE PTR [rax], dl
	add	QWORD PTR -8[rbp], 1
.L5:
	mov	rax, QWORD PTR -8[rbp]
	cmp	rax, QWORD PTR -24[rbp]
	jb	.L6
	lea	rdx, generated_text[rip]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
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
	# -8  - fin
	# -16 - fout
	# -20 - i (count_letters loop)
	# -32 - size (local)
	# -36 - iterations
	# -48 - start
	# -56 - end
	# -60 - lower_count
	# -64 - upper_count
	# -68 - argc
	# -80 - argv

	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	cmp	DWORD PTR -68[rbp], 1 
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
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L10
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L12
	cmp	DWORD PTR -68[rbp], 3
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
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC4[rip]
	mov	rsi, rdx # "r"
	mov	rdi, rax # argv[2]
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 24
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx # "w"
	mov	rdi, rax # argv[3]
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L11
.L12:
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rdx, .LC6[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcmp@PLT
	test	eax, eax
	jne	.L14
	cmp	DWORD PTR -68[rbp], 3
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
	mov	rax, QWORD PTR -80[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	cdqe
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	gen_text
	mov	rax, QWORD PTR -32[rbp]
	lea	rdx, .LC4[rip] # "r"
	mov	rsi, rax # size
	lea	rax, generated_text[rip]
	mov	rdi, rax # generated_text
	call	fmemopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
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
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	input_text
	mov	DWORD PTR -60[rbp], 0 # lower_count = 0
	mov	DWORD PTR -64[rbp], 0 # upper_count = 0
	mov	DWORD PTR -36[rbp], 5 # iterations = 5
	call	clock@PLT
	mov	QWORD PTR -48[rbp], rax # start = clock();
	mov	DWORD PTR -20[rbp], 0
	jmp	.L16
.L17:
	mov	rax, QWORD PTR text_size[rip]
	lea	rcx, -64[rbp] # &upper_count
	lea	rdx, -60[rbp] # &lower_count
	mov	rsi, rax # text_size
	lea	rax, text[rip]
	mov	rdi, rax # text
	call	count_letters@PLT
	add	DWORD PTR -20[rbp], 1
.L16:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L17
	call	clock@PLT
	mov	QWORD PTR -56[rbp], rax # end = clock()
	mov	edx, DWORD PTR -60[rbp] # lower_count
	mov	rax, QWORD PTR -16[rbp] # fout
	lea	rcx, .LC9[rip]
	mov	rsi, rcx # lower_count
	mov	rdi, rax # fout
	mov	eax, 0
	call	fprintf@PLT
	mov	edx, DWORD PTR -64[rbp] # upper_count
	mov	rax, QWORD PTR -16[rbp]
	lea	rcx, .LC10[rip]
	mov	rsi, rcx
	mov	rdi, rax # fout
	mov	eax, 0
	call	fprintf@PLT
	mov	rax, QWORD PTR -56[rbp]
	sub	rax, QWORD PTR -48[rbp]
	# work with SSE	
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -36[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC11[rip]
	movapd	xmm2, xmm0
	divsd	xmm2, xmm1
	mov	rax, QWORD PTR -56[rbp]
	sub	rax, QWORD PTR -48[rbp]
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -36[rbp]
	divsd	xmm0, xmm1
	movq	rdx, xmm0
	mov	rax, QWORD PTR -16[rbp]
	movapd	xmm1, xmm2
	movq	xmm0, rdx
	lea	rdx, .LC12[rip]
	mov	rsi, rdx 
	mov	rdi, rax # fout
	mov	eax, 2
	call	fprintf@PLT
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax
	je	.L18
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax # fin
	call	fclose@PLT
.L18:
	mov	rax, QWORD PTR stdout[rip]
	cmp	QWORD PTR -16[rbp], rax
	je	.L19
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax # fout
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
