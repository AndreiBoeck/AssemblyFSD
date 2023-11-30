    .data
vetorA: .word -100, 150, -200, 250, -300, 350, -400, 450
vetorB: .word 400, -350, 300, -250, 200, -150, 100, -50
vetorC: .word -500, 600, -700, 800, -900, 1000, -1100, 1200
vetorD: .word 1300, -1400, 1500, -1600, 1700, -1800, 1900, -2000
tamanho: .word 8
resultado_PE: .word 0

    .text
    .globl main

main:
    # Adição de vetores
    la $a0, vetorA        # Endereço de vetorA para $a0
    la $a1, vetorB        # Endereço de vetorB para $a1
    la $a2, vetorC        # Endereço de vetorC para $a2
    lw $a3, tamanho       # Tamanho do vetor
    jal add_vectors       # Chamada da função add_vectors

    # Subtração de vetores
    la $a0, vetorA        # Endereço de vetorA para $a0
    la $a1, vetorB        # Endereço de vetorB para $a1
    la $a2, vetorD        # Endereço de vetorD para $a2
    lw $a3, tamanho       # Tamanho do vetor
    jal sub_vectors       # Chamada da função sub_vectors

    # Produto Escalar
    la $a0, vetorC        # Endereço de vetorC para $a0
    la $a1, vetorD        # Endereço de vetorD para $a1
    lw $a3, tamanho       # Tamanho do vetor
    jal dot_product       # Chamada da função dot_product

    # Finaliza o programa
    li $v0, 10
    syscall

# Sub-rotina para adicionar vetores
add_vectors:
    li $t0, 0          # Índice do vetor: 0
    sll $t1, $a3, 2    # Tamanho do vetor em bytes (tamanho * 4)
add_loop:
    bge $t0, $t1, end_add  # Se o índice for >= tamanho * 4, termina
    lw $t2, 0($a0)     # Carrega elemento de vetorA
    lw $t3, 0($a1)     # Carrega elemento de vetorB
    add $t4, $t2, $t3  # Adiciona os elementos
    sw $t4, 0($a2)     # Armazena o resultado em vetorC
    addi $a0, $a0, 4   # Avança para o próximo elemento de vetorA
    addi $a1, $a1, 4   # Avança para o próximo elemento de vetorB
    addi $a2, $a2, 4   # Avança para o próximo elemento de vetorC
    addi $t0, $t0, 4   # Incrementa o índice
    j add_loop         # Volta para o início do loop
end_add:
    jr $ra             # Retorna para a função chamadora


# Sub-rotina para subtrair vetores
sub_vectors:
    li $t0, 0          # Índice do vetor: 0
    sll $t1, $a3, 2    # Tamanho do vetor em bytes (tamanho * 4)
sub_loop:
    bge $t0, $t1, end_sub  # Se o índice for >= tamanho * 4, termina
    lw $t2, 0($a0)     # Carrega elemento de vetorA
    lw $t3, 0($a1)     # Carrega elemento de vetorB
    sub $t4, $t2, $t3  # Subtrai os elementos
    sw $t4, 0($a2)     # Armazena o resultado em vetorD
    addi $a0, $a0, 4   # Avança para o próximo elemento de vetorA
    addi $a1, $a1, 4   # Avança para o próximo elemento de vetorB
    addi $a2, $a2, 4   # Avança para o próximo elemento de vetorD
    addi $t0, $t0, 4   # Incrementa o índice
    j sub_loop         # Volta para o início do loop
end_sub:
    jr $ra             # Retorna para a função chamadora


# Sub-rotina para produto escalar
dot_product:
    li $t0, 0          # Índice do vetor: 0
    li $t5, 0          # Inicializa a soma do produto escalar com 0
    sll $t1, $a3, 2    # Tamanho do vetor em bytes (tamanho * 4)
dot_loop:
    bge $t0, $t1, end_dot  # Se o índice for >= tamanho * 4, termina
    lw $t2, 0($a0)     # Carrega elemento de vetorC
    lw $t3, 0($a1)     # Carrega elemento de vetorD
    mul $t4, $t2, $t3  # Multiplica os elementos
    add $t5, $t5, $t4  # Acumula o resultado
    addi $a0, $a0, 4   # Avança para o próximo elemento de vetorC
    addi $a1, $a1, 4   # Avança para o próximo elemento de vetorD
    addi $t0, $t0, 4   # Incrementa o índice
    j dot_loop         # Volta para o início do loop
end_dot:
    sw $t5, resultado_PE  # Armazena o resultado do produto escalar
    jr $ra
