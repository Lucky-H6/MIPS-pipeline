module Signal_Extend(in, ExtOp, out);
    input [15:0] in;
    input ExtOp;
    output [31:0] out;

    assign out = {ExtOp ? {16{in[15]}}:16'h0000, in};

endmodule