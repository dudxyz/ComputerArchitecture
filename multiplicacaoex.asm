.globl main
.text
main:
	addi $v0, $zero, 5 # $v0 deve receber o valor 5.
	syscall # Chamada de sistema. Solicita a digitacao de um valor.
	add $a0, $zero, $v0 # Dado digitado retorna em $v0. Copia valor de $v0 para $a0
	
	addi $v0, $zero, 5 # $v0 deve receber o valor 5.
	syscall # Chamada de sistema. Solicita digitacao de um outro valor
	mul $a0, $a0, $v0 # resultado digitado em $v0 é multiplicado pelo primeiro
			  # valor que estava em $a0 e armazenado em $a0.
	addi $v0, $zero, 1 # $v0 recebe valor 1.
	syscall # Imprimindo resultado da multiplicacao em tela.
	addi $v0, $zero, 10 # $v0 recebe valor 10.
	 # Termina o programa