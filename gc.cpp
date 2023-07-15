#include<string>
#include "gc.h"
void GC::gen_code(std::string operacao, std::string id){
    std::string res="";
    if(operacao == "data"){
        res += ".data\n";

    } else if(operacao == "text"){
        res += ".text\n";

    } else if(operacao == "end"){
        res += "li a7, 10\n";
        res += "ecall\n";

    } else if(operacao == "symbol"){
        res += id + ": .space 4\n";

    } else if(operacao == "jump"){
        res += "j " + id + '\n';

    } else if(operacao == "assign"){
        res += "la a0, " + id + '\n';    // coloca o endereco de id em a0
        res += "lw t0, 0(sp)\n";        // tira o num da pilha e coloca em a0
        res += "sw t0, (a0)\n";         // coloca o valor de t0 no endereco de id (que esta em a1)
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha

    } else if(operacao == "check"){
        res += "lw t0, 0(sp)\n";            // tira o num da pilha e coloca em a0
        res += "addi sp, sp, 4\n";          // devolve 4 bytes na pilha
        res += "beqz t0, " + id + '\n'; // compara t0 com 0 e

    } else if(operacao == "label"){
        res += id + ":\n";

    } else if(operacao == "read"){
        res += "li a7, 5\n";            // coloca o valor 5 em a7 (read int)
        res += "ecall\n";               
        res += "la a1, " + id + '\n';   // coloca o endereço do id em a1
        res += "lw a0, 0(a1)\n";        // coloca o valor lido no endereco do id

    } else if(operacao == "write"){
        res += "lw a0, 0(sp)\n";        // tira o num da pilha e coloca em a0
        res += "li a7, 1\n";            // coloca o valor 1 em a7 (print int)
        res += "ecall\n";
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha

    } else if(operacao == "endl"){
        res += "li a7, 11\n";           // printar \n 
        res += "li a0, 10\n";
        res += "ecall\n"; 

    } else if(operacao == "++"){
        res += "la t1, " + id + '\n';
        res += "lw t0, 0(t1)\n";        // tira o segundo num da pilha e coloca em t1
        res += "addi t0, t0, 1\n";
        res += "sw t0, (t1)\n";

    } else if(operacao == "--"){
        res += "la t1, " + id + '\n';
        res += "lw t0, 0(t1)\n";        // tira o segundo num da pilha e coloca em t1
        res += "addi t0, t0, -1\n";
        res += "sw t0, (t1)\n";

    } else if(operacao == "+="){
        res += "la t1, " + id + '\n';
        res += "lw t0, 0(sp)\n";        // tira o num da pilha e coloca em t1
        res += "lw t2, (t1)\n";
        res += "add t0, t0, t2\n";
        res += "sw t0, (t1)\n";
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha

    } else if(operacao == "-="){
        res += "la t1, " + id + '\n';
        res += "lw t0, 0(sp)\n";        // tira o num da pilha e coloca em t1
        res += "lw t2, (t1)\n";
        res += "sub t0, t2, t0\n";
        res += "sw t0, (t1)\n";
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha

    } else if(operacao == "store_imm"){
        res += "li t0, " + id + '\n';  // coloca o valor de var em t0
        res += "addi sp, sp, -4\n";     // reserva 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o valor de t0 na pilha

    } else if(operacao == "store"){
        res += "la t0, " + id + '\n';  // coloca o endereco de var em t0
        res += "addi sp, sp, -4\n";     // reserva 4 bytes na pilha
        res += "lw t0, 0(t0)\n";        // coloca o valor do endereco de var (que estah em t0) em t0
        res += "sw t0, 0(sp)\n";        // coloca o valor de t0 na pilha

    } else if(operacao == "less"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "slt t0, t0, t1\n";      // compara os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 na pilha

    } else if(operacao == "equal"){
        res += "lw t0, 4(sp)\n";        // tira o num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o num da pilha e coloca em t1
        res += "sub t0, t0, t1\n";      // subtrai os dois nums e coloca o resultado em t0
        res += "seqz t0, t0\n";         // checa se t0 eh 0
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 na pilha

    } else if(operacao == "greater"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "slt t0, t1, t0\n";      // compara os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 na pilha

    } else if(operacao == "add"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "add t0, t0, t1\n";      // soma os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 (soma) na pilha

    } else if(operacao == "sub"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "sub t0, t0, t1\n";      // subtrai os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 (subtração) na pilha

    } else if(operacao == "mul"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "mul t0, t0, t1\n";      // multiplica os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 (multiplicação) na pilha

    } else if(operacao == "div"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "div t0, t0, t1\n";      // divide os dois nums e coloca o resultado em t0
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 (divisão) na pilha

    } else if(operacao == "pow"){
        res += "lw t0, 4(sp)\n";        // tira o primeiro num da pilha e coloca em t0
        res += "lw t1, 0(sp)\n";        // tira o segundo num da pilha e coloca em t1
        res += "subi t1, t1, 1\n";      // t1--
        res += "loop_pow: beqz t1, 16\n";// se t1 chegar a 0 acaba
        res += "mul t0, t0, t0\n";      // multiplica t0 com ele mesmo
        res += "subi t1, t1, 1\n";      // t1--
        res += "jal t3, -16\n";         // volta a comparacao
        res += "addi sp, sp, 4\n";      // devolve 4 bytes na pilha
        res += "sw t0, 0(sp)\n";        // coloca o resultado de t0 (exponeciacao) na pilha
    }

    return code.push_back(res);
}
