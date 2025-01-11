# soma e subtração de dois numeros
.data
novalinha: .asciiz "\n" # definindo o caractere de nova liva

.text
main:
	li $v0, 5 # load immediate para ler int
	syscall  #faz a leitura
	move $t0, $v0 # armazena o valor lido em t0
	
	# faz a mesma coisa para o segundo numero e armazena ele em t1
	li $v0, 5
	syscall
	move $t1, $v0 
	
	add $t2, $t0, $t1 # soma os dois numeros e armazena em t2
	move $a0, $t2
	li $v0, 1
	syscall
	
	# imprimir uma linha entre os 2 resultados
	li $v0, 4
	la $a0, novalinha
	syscall
	
	sub $t2, $t0, $t1 # subtrai os dois numeros e armazena em t3
	move $a0, $t2
	li $v0, 1
	syscall
	