module IF(
    input reset,
    input clk,
    input [31:0] PC_in,
    input CtrlFlush,
    input BranchPCSrc,
    input ExpFlush,
    output [31:0] Instruction,
    output [31:0] PC_plus4,
    output [31:0] PC_out
);

    wire [31:0] Ins;
    wire flush;

    PC pc(.reset(reset), .clk(clk), .in(PC_in), .out(PC_out));
    Instruction_Memory instruction_mem(.ReadAddr(PC_out), .Ins(Ins));

    assign PC_plus4 = PC_out+32'h00000004;
    assign flush = CtrlFlush | BranchPCSrc | ExpFlush;
    assign Instruction = flush ? 32'h00000000:Ins;

endmodule
