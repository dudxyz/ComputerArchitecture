Para testar os códigos com iVerilog e GTKWave:

1 - Compile os Arquivos:
iverilog -o ula_testbench tb_ULA_32bit.v ULA_32bit.v

2 - Execute a Simulação:
vvp ula_testbench

3 - Visualizar no GTKWave:
gtkwave ula.vcd

