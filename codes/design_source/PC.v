module PC(reset, clk, in, out);

    input reset, clk;
    input [31:0] in;
    output [31:0] out;

    reg [31:0] register_PC;

    assign out = register_PC;

    always @(posedge reset or posedge clk)
        if (reset)
            register_PC <= 32'h00400000;
        else
            register_PC <= in;

endmodule