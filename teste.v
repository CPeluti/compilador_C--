.data
teste:
    .space 4
var_a:
    .space 4
var_b:
    .space 4
.text
main:

#store_imm

li t0,imm
addi sp,sp,-4
sw t0,0(sp)

la a1, var_a
li t0,2
sw t0,(a1)

la a1, var_b
li t0,3
sw t0,(a1)

addi sp,sp,-4
la t0,var_a
lw t0,0(t0)
sw t0, 0(sp)

addi sp,sp,-4
la t0,var_b
lw t0,0(t0)
sw t0, 0(sp)

lw t0, 0(sp)
lw t1, 4(sp)

la a1, teste
add t0,t0,t1
sw t0, (a1)

addi sp,sp,8

li a7,1
la a0,teste
lw a0,0(a0)

ecall




li a7,10
ecall