`timescale 1ns / 1ps

module tb_ULA_32bit;
  reg [31:0] A_tb, B_tb;
  reg Cin_tb, Bin_tb;
  reg [2:0] op_sel_tb;
  wire [31:0] resultado_tb;
  wire Cout_tb, Bout_tb;

  ula_32bits dut (
    .A(A_tb), .B(B_tb), .Cin(Cin_tb), .Bin(Bin_tb),
    .op_sel(op_sel_tb), .resultado(resultado_tb), .Cout(Cout_tb), .Bout(Bout_tb)
  );

  task display_results;
    begin
      $display("Tempo: %0t | A: %h | B: %h | Cin: %b | Bin: %b | OpSel: %b | Resultado: %h | Cout: %b | Bout: %b",
               $time, A_tb, B_tb, Cin_tb, Bin_tb, op_sel_tb, resultado_tb, Cout_tb, Bout_tb);
    end
  endtask

  initial begin
    $dumpfile("ula.vcd");
    $dumpvars(0, tb_ULA_32bit);

    A_tb = 0; B_tb = 0; Cin_tb = 0; Bin_tb = 0; op_sel_tb = 3'b000; #10;

    // Testes da ULA
    op_sel_tb = 3'b000; A_tb = 32'h12345678; B_tb = 32'h87654321; #10; display_results;
    op_sel_tb = 3'b001; A_tb = 32'h87654321; B_tb = 32'h12345678; #10; display_results;
    op_sel_tb = 3'b010; A_tb = 32'hF0F0F0F0; B_tb = 32'h0F0F0F0F; #10; display_results;

    #10 $finish;
  end
endmodule

