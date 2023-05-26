.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:

    # Prologue
    li t0, 1
    li t1, 0x80000000   # max
    li t2, -1   # idx
    li t3, 0    # i
    bge a1, t0, loop_start
    li a1, 77
    j exit2

loop_start:
    #muli t5, t3, 4
    slli t5, t3, 2
    add t6, a0, t5
    lw t4, 0(t6)
    bgt t4, t1, then
    j loop_continue
then:
    mv t2, t3
    mv t1, t4

loop_continue:
    addi t3, t3, 1
    blt t3, a1, loop_start
    j loop_end

loop_end:
    mv a0, t2
    ret
