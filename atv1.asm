main: # Inicio do codigo

	li $v0, 5 # 5 codigo pra ler int
	syscall # faz a leitura
	move $t0, $v0 # armazeno o valor lido em t0
	
	li $v0, 5 # codigo de load immediate p ler int
	syscall #executa a leitura
	move $t1, $v0 # armazeno o segundo valor em t1

	add $t0, $t0, $t1 # soma t0 <- t0 + t1

	# vou imprimir o resultado na tela. O resultado tem que estar em $a0
	# para isso, o resultado tem que estar em $a0
	move $a0, $t0

	#preparo uma chamada de sistema para imprimir
	# Escreve o código 1 em $v0. Código 1 significa imprimir inteiro
	li $v0, 1 # load immediate
	syscall # Termina o programa.