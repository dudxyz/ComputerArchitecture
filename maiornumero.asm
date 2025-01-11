# maior numero
main:
	li $v0, 5 # 5 codigo pra ler int
	syscall # faz a leitura
	move $t0, $v0 # armazeno o valor lido em t0
	
	li $v0, 5 # codigo de load immediate p ler int
	syscall #executa a leitura
	move $t1, $v0 # armazeno o segundo valor em t1

	bge $t0, $t1, print_t0 # se o primeiro int (t0) for maior que ou igual a  o segundo in (t1) vai pra funcao print_t0 que armazena t0 em um valor t2 que e o valor a ser imprimido(maior)
	move $t2, $t1 # se t0 nao for maior que t1, guardo o valor de t1 em t2 que armazena o maior valor e vai ser impresso
	j print_resultado # pula p printar o resultado
	
	print_t0:
 	move $t2, $t0
 	
 	print_resultado:
 	move $a0, $t2
 	li $v0, 1
 	syscall