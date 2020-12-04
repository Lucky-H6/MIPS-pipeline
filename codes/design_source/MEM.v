module MEM(
    input reset,
    input clk,
    input [5:0] EX_MEM_OpCode,
    input [31:0] PC_plus4_in,
    input [31:0] ALUout_in,
    input [31:0] WriteData,
    input [4:0] RegWriteDst_in,
    output RegWrite,
    output RegDst,
    output [31:0] RegWriteData,
    output [4:0] RegWriteDst,
    output [31:0] ALUout,
    output [31:0] LEDs,
    output [31:0] BCD7,
    output [31:0] SysTick,
    output Irq
);
    wire [31:0] PC_plus4;
    wire [31:0] Read_Data;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemtoReg;

    Data_Memory data_memory(
        .reset(reset),
        .clk(clk),
        .Read_Addr(ALUout),
        .Write_Addr(ALUout_in),
        .Write_Data(WriteData),
        .Read_Data(Read_Data),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .LEDs(LEDs),
        .BCD7(BCD7),
        .SysTick(SysTick),
        .Irq(Irq)
    );

    EX_MEM ex_mem(
        .reset(reset),
        .clk(clk),
        .EX_MEM_OpCode_in(EX_MEM_OpCode),
        .PC_plus4_in(PC_plus4_in),
        .ALUout_in(ALUout_in),
        .RegWriteDst_in(RegWriteDst_in),
        .RegWrite(RegWrite),
        .PC_plus4(PC_plus4),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .RegDst(RegDst),
        .ALUout(ALUout),
        .RegWriteDst(RegWriteDst)
    );

    assign RegWriteData =
        (MemtoReg == 2'b10) ? PC_plus4:
        (MemtoReg == 2'b01) ? Read_Data:
        ALUout;

endmodule : MEM