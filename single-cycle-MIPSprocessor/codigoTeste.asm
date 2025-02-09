# codigo em assembly para o mips (em código de máquina na memória de intruções)

main:
    addi $t0, $zero, 5       # $t0 = 5 (addi)
    addi $t1, $zero, 3       # $t1 = 3 (addi)
    add  $t2, $t0, $t1       # $t2 = $t0 + $t1 = 8 (add)
    sub  $t3, $t0, $t1       # $t3 = $t0 - $t1 = 2 (sub)
    sw   $t2, 0($zero)       # Armazena $t2 (8) na memória[0] (sw)
    lw   $t4, 0($zero)       # Carrega memória[0] (8) em $t4 (lw)
    beq  $t4, $t2, branch_ok # Se $t4 == $t2, pula para branch_ok (beq)
    j    error               # Se não, pula para error (j)

branch_ok:
    addi $t5, $zero, 10      # $t5 = 10 (addi)
    j    end                 # Pula para end (j)

error:
    addi $t5, $zero, 20      # $t5 = 20 (addi)

end:
    sw   $t5, 4($zero)       # Armazena $t5 (10 ou 20) na memória[4] (sw)