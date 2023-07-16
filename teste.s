.data
counter: .space 4
.text
li t0, 2
addi sp, sp, -4
sw t0, 0(sp)
li t0, 3
addi sp, sp, -4
sw t0, 0(sp)
lw t0, 4(sp)
lw t1, 0(sp)
addi t1, t1, -1
mv t3, t0
loop_0:
beqz t1, end_loop_0
mul t3, t0, t3
addi t1, t1, -1
jal t4, loop_0
end_loop_0:
addi sp, sp, 4
sw t3, 0(sp)
la a0, counter
lw t0, 0(sp)
sw t0, (a0)
addi sp, sp, 4
la t0, counter
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
lw a0, 0(sp)
li a7, 1
ecall
addi sp, sp, 4
li a7, 11
li a0, 10
ecall
li a7, 10
ecall
