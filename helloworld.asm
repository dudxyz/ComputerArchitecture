# Hello World in MIPS Assembly
	.data # carrega a string no primeiro endereco
		# disponivel do proximo segmento de dados
hello_msg: .ascii "Hello World!\n“
	.text

main: # Inicio do codigo
	# Carrega o endereco da mensagem em $a0
	la $a0, hello_msg #load address
	# Carrega o codigo 4 no registrador $v0
	li $v0, 4 #load immediate
	syscall #imprime uma string