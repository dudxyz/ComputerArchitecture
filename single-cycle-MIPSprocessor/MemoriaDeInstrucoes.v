module MemoriaDeInstrucoes(
    input wire [31:0] addr,      // Endereço da instrução
    output wire [31:0] instrucao // Instrução lida
);

    // Memória de instruções (256 palavras de 32 bits)
    reg [31:0] memoria [255:0];

    // Inicialização da memória com o programa de teste
    integer i;
    initial begin
        // Programa de teste
        memoria[0] = 32'h20080005;  // addi $t0, $zero, 5
        memoria[1] = 32'h20090003;  // addi $t1, $zero, 3
        memoria[2] = 32'h01095020;  // add  $t2, $t0, $t1
        memoria[3] = 32'h01095822;  // sub  $t3, $t0, $t1
        memoria[4] = 32'hAC0A0000;  // sw   $t2, 0($zero)
        memoria[5] = 32'h8C0C0000;  // lw   $t4, 0($zero)
        memoria[6] = 32'h118A0002;  // beq  $t4, $t2, branch_ok (desvio para 8 + 2 = 10)
        memoria[7] = 32'h0800000A;  // j    error (salto para 10)
        memoria[8] = 32'h200A000A;  // addi $t5, $zero, 10
        memoria[9] = 32'h0800000B;  // j    end (salto para 11)
        memoria[10] = 32'h200A0014; // addi $t5, $zero, 20
        memoria[11] = 32'hAC0A0004; // sw   $t5, 4($zero)

        // Zera o restante da memória
        for (i = 12; i < 256; i = i + 1) begin
            memoria[i] = 32'b0;
        end
    end

    // Leitura combinacional
    assign instrucao = memoria[addr[9:2]]; // Usa os bits 9:2 para indexar (alinhado em palavras)
endmodule