# add
lw t0, 0(sp)
lw t1, 4(sp)
add 

#store_imm

li t0,imm
addi sp,sp,-4
sw t0,0(sp)

##########################

.data
teste:
    .space 4
var_a:
    .space 4
var_b:
    .space 4
.text
main:


# atribuicao a = 2
la a1, var_a
li t0,2
sw t0,(a1)

# atribuicao b = 3
la a1, var_b
li t0,3
sw t0,(a1)

# coloca o valor de a na pilha
addi sp,sp,-4
la t0,var_a
lw t0,0(t0)
sw t0, 0(sp)

#coloca o valor de b na pilha
addi sp,sp,-4
la t0,var_b
lw t0,0(t0)
sw t0, 0(sp)

# pega o valor de a e de b
lw t0, 0(sp)
lw t1, 4(sp)

# soma os dois valores e coloca o resultado no endereco teste
la a1, teste
add t0,t0,t1
sw t0, (a1)

# devolve 8 bytes da pilha
addi sp,sp,8

# print integer
li a7,1
la a0,teste
lw a0,0(a0)

ecall




li a7,10
ecall