module Compare(in1, in2, CpCode, out);
    input [31:0] in1, in2;
    input [2:0] CpCode;
    output out;

    assign out =
        (CpCode == 3'b000) ? (in1 == in2):
            (CpCode == 3'b001) ? (in1 != in2):
                (CpCode == 3'b010) ? (in1 <= in2):
                    (CpCode == 3'b011) ? (in1 > in2):
                        (CpCode == 3'b100) ? (in1 < in2):1'b0;

endmodule