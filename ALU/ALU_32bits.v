// ULA - Unidade Lógica e Aritmética de 32 bits em Verilog :)

// Somador de 1 bit
module meio_somador (A, B, S, C);
  input A, B;
  output S, C;
  assign S = A ^ B;
  assign C = A & B;
endmodule

// Somador de 1 bit com carry-in
module Somador1bit (A, B, Cin, Soma, Cout);
  input A, B, Cin;
  output Soma, Cout;
  wire Carry_1, Carry_2, Soma_1;
  meio_somador U1 (.A(A), .B(B), .S(Soma_1), .C(Carry_1));
  meio_somador U2 (.A(Cin), .B(Soma_1), .S(Soma), .C(Carry_2));
  assign Cout = Carry_1 | Carry_2;
endmodule

// Somador de 32 bits
module somador_32bits (
  input [31:0] A, B,
  input Cin,
  output [31:0] Soma,
  output Cout
);
  wire [31:0] carry;

  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : somadores
      if (i == 0) begin
        Somador1bit somador0 (
          .A(A[i]), .B(B[i]), .Cin(Cin),
          .Soma(Soma[i]), .Cout(carry[i])
        );
      end else begin
        Somador1bit somador_i (
          .A(A[i]), .B(B[i]), .Cin(carry[i-1]),
          .Soma(Soma[i]), .Cout(carry[i])
        );
      end
    end
  endgenerate

  assign Cout = carry[31];
endmodule

// Subtrator de 1 bit
module meio_subtrator (A, B, D, Bout);
  input A, B;
  output D, Bout;
  assign D = A ^ B;
  assign Bout = ~A & B;
endmodule

module Subtrator1bit (A, B, Bin, D, Bout);
  input A, B, Bin;
  output D, Bout;
  wire Diff1, Borrow1, Borrow2;
  meio_subtrator U1 (.A(A), .B(B), .D(Diff1), .Bout(Borrow1));
  meio_subtrator U2 (.A(Diff1), .B(Bin), .D(D), .Bout(Borrow2));
  assign Bout = Borrow1 | Borrow2;
endmodule

// Subtrator de 32 bits
module subtrator_32bits (
  input [31:0] A, B,
  input Bin,
  output [31:0] D,
  output Bout
);
  wire [31:0] borrow;

  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : subtratores
      if (i == 0) begin
        Subtrator1bit subtrator0 (
          .A(A[i]), .B(B[i]), .Bin(Bin),
          .D(D[i]), .Bout(borrow[i])
        );
      end else begin
        Subtrator1bit subtrator_i (
          .A(A[i]), .B(B[i]), .Bin(borrow[i-1]),
          .D(D[i]), .Bout(borrow[i])
        );
      end
    end
  endgenerate

  assign Bout = borrow[31];
endmodule

// Operações lógicas
module and_32bits (input [31:0] A, B, output [31:0] Y);
  assign Y = A & B;
endmodule

module or_32bits (input [31:0] A, B, output [31:0] Y);
  assign Y = A | B;
endmodule

module nand_32bits (input [31:0] A, B, output [31:0] Y);
  assign Y = ~(A & B);
endmodule

module xnor_32bits (input [31:0] A, B, output [31:0] Y);
  assign Y = ~(A ^ B);
endmodule

module not_32bits (input [31:0] A, output [31:0] Y);
  assign Y = ~A;
endmodule

module pass_through_32bits (input [31:0] A, output [31:0] Y);
  assign Y = A;
endmodule

// Multiplexador 8:1 de 32 bits
module mux_8_para_1_32bits (
  input [31:0] in0, in1, in2, in3, in4, in5, in6, in7,
  input [2:0] sel,
  output reg [31:0] out
);
  always @(*) begin
    case (sel)
      3'b000: out = in0;
      3'b001: out = in1;
      3'b010: out = in2;
      3'b011: out = in3;
      3'b100: out = in4;
      3'b101: out = in5;
      3'b110: out = in6;
      3'b111: out = in7;
      default: out = 32'bx;
    endcase
  end
endmodule

// ULA de 32 bits
module ula_32bits (
  input [31:0] A, B,
  input Cin, Bin,
  input [2:0] op_sel,
  output [31:0] resultado,
  output Cout, Bout
);
  wire [31:0] soma_result, sub_result, and_result, or_result, nand_result, xnor_result, not_result, pass_result;

  somador_32bits somador (.A(A), .B(B), .Cin(Cin), .Soma(soma_result), .Cout(Cout));
  subtrator_32bits subtrator (.A(A), .B(B), .Bin(Bin), .D(sub_result), .Bout(Bout));
  and_32bits and_op (.A(A), .B(B), .Y(and_result));
  or_32bits or_op (.A(A), .B(B), .Y(or_result));
  nand_32bits nand_op (.A(A), .B(B), .Y(nand_result));
  xnor_32bits xnor_op (.A(A), .B(B), .Y(xnor_result));
  not_32bits not_op (.A(A), .Y(not_result));
  pass_through_32bits pass_op (.A(A), .Y(pass_result));

  mux_8_para_1_32bits mux (
    .in0(soma_result), .in1(sub_result), .in2(and_result), .in3(or_result),
    .in4(nand_result), .in5(xnor_result), .in6(not_result), .in7(pass_result),
    .sel(op_sel), .out(resultado)
  );
endmodule

