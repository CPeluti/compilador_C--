.data
teste: .space 4
a: .space 4
b: .space 4
.text
li t0, 2
addi sp, sp, -4
sw t0, 0(sp)
la a0, a
lw t0, 0(sp)
sw t0, (a0)
addi sp, sp, 4
li t0, 3
addi sp, sp, -4
sw t0, 0(sp)
la a0, b
lw t0, 0(sp)
sw t0, (a0)
addi sp, sp, 4
la t0, a
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
la t0, b
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
lw t0, 4(sp)
lw t1, 0(sp)
add t0, t0, t1
addi sp, sp, 4
sw t0, 0(sp)
la a0, teste
lw t0, 0(sp)
sw t0, (a0)
addi sp, sp, 4
la t0, a
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
la t1, b
lw t0, 0(sp)
lw t2, (t1)
sub t0, t2, t0
sw t0, (t1)
addi sp, sp, 4
while_0:
la t0, a
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
li t0, 0
addi sp, sp, -4
sw t0, 0(sp)
lw t0, 4(sp)
lw t1, 0(sp)
slt t0, t1, t0
addi sp, sp, 4
sw t0, 0(sp)
lw t0, 0(sp)
addi sp, sp, 4
beqz t0, end_while_0
la t1, b
lw t0, 0(t1)
addi t0, t0, 1
sw t0, (t1)
la t1, a
lw t0, 0(t1)
addi t0, t0, -1
sw t0, (t1)
la t0, a
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
la t0, b
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
j while_0
end_while_0:
la t0, teste
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
la t0, b
addi sp, sp, -4
lw t0, 0(t0)
sw t0, 0(sp)
lw t0, 4(sp)
lw t1, 0(sp)
add t0, t0, t1
addi sp, sp, 4
sw t0, 0(sp)
lw a0, 0(sp)
li a7, 1
ecall
addi sp, sp, 4
li a7, 10
ecall
