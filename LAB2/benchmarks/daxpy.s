	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	
	.bss 
	X: .zero  32768        // vector X(4096)*8
	Y: .zero  32768        // Vector Y(4096)*8
    Z: .zero  32768        // Vector Y(4096)*8

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp
	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	ldr     x0, N
    ldr     x10, =Alpha
    ldr     x2, =X
    ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------

    UCVTF D4, x10

loop_start: 
    CMP x1, x0
    B.GE loop_end

	LDR D0, [x2, x1, LSL #3]
	LDR D1, [x3, x1, LSL #3]
    FMUL D0, D0, D4
    FADD D0, D0, D1
    STR D0, [x4, x1, LSL #3]
    ADD x1, x1, #1

    LDR D2, [x2, x1, LSL #3]
	LDR D3, [x3, x1, LSL #3]
    FMUL D2, D2, D4
    FADD D2, D2, D3
    STR D2, [x4, x1, LSL #3]

    ADD x1, x1, #1
    B loop_start

loop_end:

//---------------------- END CODE -------------------------------------

	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
	mov	w0, 0
	ldp	x29, x30, [sp], 16
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
