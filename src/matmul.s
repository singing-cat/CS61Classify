.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    ble a1, x0, exit_72
    ble a2, x0, exit_72
    ble a4, x0, exit_73
    ble a5, x0, exit_73
    bne a2, a4, exit_74

    # Prologue
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)


    li s0, 0    # s0: i
    li s1, 0    # s1: j

outer_loop_start:
    li s1, 0    # s1: j
    blt s0, a1, inner_loop_start
    j outer_loop_end

inner_loop_start:
    bge s1, a5, inner_loop_end

    addi sp, sp, -32
    sw a1, 0(sp)
    sw a2, 4(sp)
    sw ra, 8(sp)
    sw a0, 12(sp)
    sw a3, 16(sp)
    sw a5, 20(sp)
    sw a6, 24(sp)
    sw a4, 28(sp)

    mul t0, s0, a2
    slli t0, t0, 2
    add a0, a0, t0
    slli t1, s1, 2
    add a1, a3, t1
    addi a3, x0, 1
    mv a4, a5
    jal ra, dot
    lw a5, 20(sp)
    lw a6, 24(sp)
    mul t0, s0, a5
    add t0, t0, s1
    slli t0, t0, 2
    add t1, a6, t0
    sw a0, 0(t1)
    addi s1, s1, 1  # j++

    lw a1, 0(sp)
    lw a2, 4(sp)
    lw ra, 8(sp)
    lw a0, 12(sp)
    lw a3, 16(sp)
    lw a4, 28(sp)
    addi sp, sp, 32

    j inner_loop_start

inner_loop_end:
    addi s0, s0, 1  # i++
    j outer_loop_start


outer_loop_end:
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    
    ret

exit_72:
    li a1, 72
    j exit2

exit_73:
    li a1, 73
    j exit2

exit_74:
    li a1, 74
    j exit2