	.data
	N:       .dword 64	
	t_amb:   .dword 25   
	n_iter:  .dword 10    
	
	.bss 
	x: .zero  32768        
	x_temp: .zero  32768    

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
    ldr     x1, =x 
    ldr     x2, =x_temp
    ldr     x3, n_iter
	ldr     x4, t_amb

//---------------------- CODE HERE ------------------------------------
// Consideramos que en x5, x6 y x7 esta fc_x, fc_y y fc_temp respectivamente
    mov x19, #8		// Para multiplicar por 8 
	mov x10, 0		// indice k
	mul x14, x0, x0	// x14 = N*N
	mov x20, #4 	
	SCVTF s2, x20	// Para multiplicar por 4
	SCVTF s4, x4	// Convertimos la temperatura ambiente a flotante

# Usamos x10 para k, x11 para i, x12 para j, x13 para el for del final
# Usamos s0 para el sum
main_2:
    mov x11, 0		// indice i
i_loop:

    mov x12, 0		// indice j
j_loop:     
    // If grande
	
    mul x7, x5, x0
    add x7, x7, x6

    mul x8, x11, x0
    add x8, x8, x12
    
    cmp x7, x8		// (i*N+j) != (fc_x*N + fc_y)
    b.eq not_outer_if

    mov x20, #0		
    SCVTF s0, x20	// sum = 0

    // Ifs chiquitos
    
    add x7, x11, #1
    cmp x7, x0		// i+1 < N
    b.lt if_1
    fadd s0, s0, s4
    b fin_if_1

if_1:
    mul x7, x7, x0
    add x7, x7, x12
    mul x7, x7, x19
    ldr s1, [x1, x7]
    fadd s0, s0, s1		// sum = sum + x[(i+1)*N+j]

fin_if_1:

    sub x7, x11, #1
    cmp x7, 0		// i-1 >= 0
    b.ge if_2
    fadd s0, s0, s4
    b fin_if_2

if_2:
    mul x7, x7, x0
    add x7, x7, x12
    mul x7, x7, x19
    ldr s1, [x1, x7]
    fadd s0, s0, s1		// sum = sum + x[(i-1)*N+j]

fin_if_2:

    add x7, x12, #1
    cmp x7, x0		// j+1 < N
    b.lt if_3
    fadd s0, s0, s4
    b fin_if_3

if_3:
    mul x8, x11, x0
    add x7, x8, x7
    mul x7, x7, x19
    ldr s1, [x1, x7]
    fadd s0, s0, s1		// sum = sum + x[i*N+ j+1]

fin_if_3:

    sub x7, x12, #1
    cmp x7, 0		// j-1 >= 0
    b.ge if_4
    fadd s0, s0, s4		
    b fin_if_4

if_4:
    mul x8, x11, x0
    add x7, x8, x7
    mul x7, x7, x19
    ldr s1, [x1, x7]	// sum = sum + x[i*N+ j-1]
    fadd s0, s0, s1

fin_if_4:

    // Fin ifs 

    mul x7, x11, x0
    add x7, x7, x12
    mul x7, x7, x19

    fdiv s0, s0, s2		// sum = sum / 4
    str s0, [x2, x7]	// x_tmp[i*N + j] = sum / 4


    // Fin If grande

not_outer_if:
    add x12,x12, #1
    cmp x12, x0
    b.lt j_loop

    add x11, x11, #1
    cmp x11, x0
    b.lt i_loop

// Segundo for del for grande
    mov x13, 0	// indice i
iter_loop:
    mul x7, x5, x0
    add x7, x7, x6
    cmp x7, x13		// i != (fc_x*N + fc_y)
    b.eq not_if

    mul x15, x13, x19
    ldr s1, [x2, x15]
    str s1, [x1, x15]

not_if:
    add x13, x13, #1
    cmp x13, x14 
    b.lt iter_loop

    add x10, x10, #1
    cmp x10, x3
    b.lt main_2


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
