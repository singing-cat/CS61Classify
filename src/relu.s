.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    li t1, 1
    blt a1, t1, flag

loop_start:
    lw t0, 0(a0)
    blt t0, x0, then
    j loop_continue

then:
    sw x0, 0(a0)


loop_continue:
    addi a0, a0, 4
    addi a1, a1, -1
    beq a1, x0, loop_end
    j loop_start

flag:
    li a1, 78
    j exit2

loop_end:
	ret
