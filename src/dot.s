.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    li t0, 1
    blt a2, t0, flag1
    blt a3, t0, flag2
    blt a4, t0, flag2
    li t0, 0    # t0: dotsum
    li t1, 0    # t1: i
    slli a3, a3, 2
    slli a4, a4, 2

loop_start:
    mul t2, t1, a3
    add t3, a0, t2  # t3: a0[i]
    lw t3, 0(t3)
    mul t4, t1, a4
    add t5, a1, t4  # t5: a1[i]
    lw t5, 0(t5)
    mul t6, t3, t5
    add t0, t0, t6
    addi t1, t1, 1  # i++
    blt t1, a2, loop_start
    j loop_end

flag1:
    li a1, 75
    j exit2

flag2:
    li a1, 76
    j exit2

loop_end:
    mv a0, t0
    ret
