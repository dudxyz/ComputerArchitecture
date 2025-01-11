# 1 a n
.data
	 linha: .asciiz "\n"

.text
main:
	li $v0, 5 # 5 codigo pra ler int
	syscall # faz a leitura
	move $t0, $v0 # armazeno o valor lido em t0
	
	li $t1,1 # inicia o contador com 1
	
	loop: #inicia o loop
	# printa o valor do contador
	move $a0, $t1 
	li $v0, 1
	syscall
	
	# printa um espaço
	la $a0, linha # carrega "space" em a0
	li $v0, 4
	syscall
	
	# incrementa o contador
	addi $t1, $t1, 1
	
	# verifica se o contador <= numero
	ble $t1, $t0, loop # se o contador <= n então o loop continua
	