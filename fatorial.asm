# FATORIAL

# Código em Haskell

# fatorial :: Int -> Int           -- Declaração da função fatorial, recebe um inteiro e devolve um inteiro
# fatorial 0 = 1                   -- caso base (fat(0)=1)
# fatorial n = n * fatorial (n-1)  -- chamada recursiva da função

# main :: IO ()                 -- Declaração do tipo da função principal
# main = do			
# putStrLn "Digite um número: "	-- Printa uma frase pedindo um número n ao usuário
# input <- getLine 		-- Lê a entrada do usuário
# let n = read input :: Int	-- Converte a entrada para inteiro
# let resultado = fatorial n	-- Calcula o fatorial
# putStrLn ("O fatorial do número digitado é: ")	-- Printa o resultado
# putStrLn (show resultado)			        --        //

# Código em MIPS Assembly

# O código será dividido em duas partes:
# .data: onde serão armazenados dados que serão utilizados pelo programa (como mensagens)
# .text: onde contém o conjunto de instruções do programa

.data
mensagem_1: .asciiz "Fatorial"
mensagem_2: .asciiz "Digite um número: "
fatorial: .asciiz " é o resultado do fatorial do número digitado."
novalinha: .asciiz "\n"
mensagem_negativo: .asciiz "O número informado é negativo, ou seja, não é possível calcular o fatorial. Encerrrando programa..."

.text
main:	# Declaração da função principal

	# Imprimindo a mensagem "Fatorial"	
	la $a0, mensagem_1	# Carrega o endereço $a0 com a mensagem_1
	li $v0,	4		# Load immediate, código 4 para imprimir string
	syscall			# Faz o print
	la $a0, novalinha	# Carregando endereço com "novalinha"
	li $v0,	4		# li para printar string
	syscall			# printa "\n"

	# Imprimindo a mensagem pedindo um número ao usuário	
	la $a0, mensagem_2	# Carrega o endereço $a0 com a mensagem_2
	li $v0,	4		# Load immediate, código 4 para imprimir string
	syscall			# Faz o print
		
	# Lê o inteiro (n) informado pelo usuário
	li $v0, 5	# Load immediate, código 5 pra ler inteiros
	syscall		# Faz a leitura
	move $a0, $v0   # Armazeno o valor lido em t0
	blt $a0, $zero, negativo	# Checa se o número digitado é negativo, caso seja, pula para "negativo"
	
	# Após ler o inteiro, pulamos para a função calculaFatorial(n)
	jal calculaFatorial

	# Printa o resultado
	move $a0, $v0	 # Printa o número com o resultado
	li $v0, 1
	syscall		
	la $a0, fatorial # Printa a mensagem final
	li $v0, 4
	syscall
	
	# Finaliza a execução
	li $v0, 10	# Load immediate, código 4 para dar exit, forçar a saída
	syscall
	
calculaFatorial:	# Declaração da função recursiva responsável pelo cálculo do fatorial
	
	addi $sp, $sp, -8	# Reservando dois lugares na pilha (8bits) para o argumento (n) e o retorno (ra)
	sw $ra, 4($sp)		# Guarda o endereço de retorno
	sw $a0, 0($sp)		# Guarda o argumento (n)
	
	slti $t0, $a0, 1		# Testando se a0 é menor que 1, caso seja t0 recebe o valor 1 (true), caso não seja ele recebe 0 (false)
	beq $t0, $zero, trecho1 	# Agora testando se t0 é zero, se for, ele pula pra trecho1, caso contrario ele continua 
	
	li $v0, 1	# Atribui o valor 1 ao registrador v0
	add $sp, $sp, 8 # Antes de pular de volta, limpa a pilha criada
	jr $ra		# Pula de volta pra linha de instruções principal
	
trecho1:	# Continuação do cálculo do fatorial para os casos onde n => 1
	
	sub $a0, $a0, 1		# Subtrai 1 de a0 (n-1) para a nova chamada
	jal calculaFatorial	# Pula pra calculaFatorial com o novo n decrementado
	
	# Para continuar o código, precisamos fazer o desempilhamento e o retorno da chamada recursiva
	lw $a0, 0($sp)	# Recupera e carrega o argumento inicial (n)
	lw $ra, 4($sp)  # Recupera e carrega o endereço de retorno inicial
	add $sp, $sp, 8	# Libera o espaço reservado na pilha
	
	mul $v0, $a0, $v0	# Calcula n * calculaFatorial (n-1)
	jr $ra			# Pula de volta pro código principal com o resultado final
	
# Otimização para o caso de serem digitados números negativos (não presente no código original)
negativo:	
	# Imprimindo a mensagem de "erro"	
	la $a0, mensagem_negativo	# Carrega o endereço $a0 com a mensagem_negativo
	li $v0,	4			# Load immediate, código 4 para imprimir string
	syscall				# Faz o print
	
	# Finaliza o programa
	li $v0, 10	# Load immediate, código 4 para dar exit, forçar a saída
	syscall
