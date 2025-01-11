# bhaskara
main:
	li $v0, 5 # lê o primeiro coeficiente (a)
	syscall #executa a leitura
	move $t0, $v0 # armazena o valor em t0
	
	li $v0, 5 # lê o segundo coeficiente (b)
	syscall 
	move $t1, $v0 #armazena o valor em t1
	
	li $v0, 5 # lê o terceiro coeficiente (c)
	syscall 
	move $t2, $v0 #armazena o valor em t2
	
	# delta = b^2 - 4ac
	delta:
		mul $t3, $t1, $t1 # b^2 -> t3
		mul $t4, $t0, $t2 # ac -> t4
		li $t5, 4         # armazena o 4 em t5
		mul $t6, $t4, $t5 # 4ac -> t6
		sub $t5, $t3, $t6 # b^2 - 4ac -> t5
		
		move $a0, $t5
		li $v0, 1
		syscall