    .data
    N:       .dword 4096    // Number of elements in the vectors
    Alpha:   .dword 2      // scalar value
    
    .bss 
    X: .zero  32768        // vector X(4096)*8
    Y: .zero  32768        // Vector Y(4096)*8
    Z: .zero  32768        // Vector Y(4096)*8

    .text
    MRS X9, CPACR_EL1            // Read EL1 Architectural Feature Access Control Register
    MOVZ X10, 0x0030, lsl #16            // Set BITs 20 and 21
    ORR X9, X9, X10
    MSR CPACR_EL1, X9            // Write EL1 Architectural Feature Access Control Register

    ldr     x0, N
    ldr     x10, Alpha
    ldr     x2, =X
    ldr     x3, =Y
	ldr     x4, =Z
    mov     x1, 0

inicializar:
    CMP x1, x0
    B.GE fin_inicializar
  
    STR x1, [x2, x1, LSL #3]
    STR x1, [x3, x1, LSL #3]
  
    ADD x1, x1, #1    
    B inicializar
fin_inicializar:
    MOV x1, 0

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
    B loop_start         

loop_end:

