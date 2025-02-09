module fulladder(
    output s,
    output cout,
    input a,
    input b,
    input cin
);

    assign {cin,s} = a+b;

endmodule
