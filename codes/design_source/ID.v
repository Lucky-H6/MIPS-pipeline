module ID(
    input reset,
    input clk,
    input [31:0] PC_plus4_in,
    input [31:0] Ins_in,
    input RegData1,
    input RegData2,
    input [4:0] RegWriteDst,
    input [31:0] Write_Data,
    input [31:0] PC,
    input [31:0] ALUout,
    input RegWrite,
    input RegDst,
    input Irq,
    output [31:0] PC_next,
    output [4:0] Rt,
    output [4:0] Rd,
    output [4:0] Rs,
    output [5:0] funct,
    output [4:0] shamt,
    output [31:0] immediate,
    output [31:0] Read_Data_2,
    output [31:0] Read_Data_1,
    output BranchPCSrc,
    output CtrlFlush,
    output ExpFlush,
    output [12:0] ID_EX_OpCode,
    output [31:0] PC_plus4
);

    wire [31:0] Ins;
    wire [4:0] Write_Addr;
    wire [1:0] PCSrc;
    wire Branch, LuOp, ExtOp, BadOp;
    wire [2:0] CpCode;
    wire IrqPCSrc;
    wire ExceptPCSrc;
    wire PCBackup;
    wire [31:0] extended_imm;
    wire [31:0] cp_data_1;
    wire [31:0] cp_data_2;
    wire cp_out;
    wire [31:0] BranchDst;

    IF_ID ifid(
        .reset(reset),
        .clk(clk),
        .ins_in(Ins_in),
        .ins_out(Ins),
        .PC_plus4_in(PC_plus4_in),
        .PC_plus4_out(PC_plus4)
    );

    Register register(
        .reset(reset),
        .clk(clk),
        .Write_Addr(Write_Addr),
        .Read_Addr_1(Ins[25:21]),
        .Read_Addr_2(Ins[20:16]),
        .Write_Data(Write_Data),
        .Read_Data_1(Read_Data_1),
        .Read_Data_2(Read_Data_2),
        .RegWrite(RegWrite),
        .Register_26(PC),
        .PCBackup(PCBackup)
    );

    Signal_Extend signal_extend(
        .in(Ins[15:0]),
        .ExtOp(ExtOp),
        .out(extended_imm)
    );

    Compare compare(
        .in1(cp_data_1),
        .in2(cp_data_2),
        .CpCode(CpCode),
        .out(cp_out)
    );

    Ctrl contrl(
        .PC31(PC_plus4[31]),
        .OpCode(Ins[31:26]),
        .funct(Ins[5:0]),
        .PCSrc(PCSrc),
        .Branch(Branch),
        .CpCode(CpCode),
        .CtrlFlush(CtrlFlush),
        .LuOp(LuOp),
        .ExtOp(ExtOp),
        .BadOp(BadOp),
        .ID_EX_OpCode(ID_EX_OpCode)
    );

    Exception_Unit except(
        .Irq(Irq),
        .BadOp(BadOp),
        .IrqPCSrc(IrqPCSrc),
        .ExceptPCSrc(ExceptPCSrc),
        .PCBackup(PCBackup),
        .ExpFlush(ExpFlush)
    );


    assign Write_Addr = RegDst ? 5'b11111:RegWriteDst;
    assign immediate = LuOp ? {Ins[15:0], 16'h0000}:extended_imm;
    assign cp_data_1 = RegData1 ? ALUout:Read_Data_1;
    assign cp_data_2 = RegData2 ? ALUout:Read_Data_2;
    assign BranchPCSrc = Branch & cp_out;
    assign Rt = Ins[20:16];
    assign Rd = Ins[15:11];
    assign Rs = Ins[25:21];
    assign funct = Ins[5:0];
    assign shamt = Ins[10:6];
    assign BranchDst = {immediate[29:0], 2'b00}+PC_plus4;
    assign PC_next =
        IrqPCSrc ? 32'h80000004:
            ExceptPCSrc ? 32'h80000008:
                (PCSrc == 2'b10) ? cp_data_1:
                    (PCSrc == 2'b01) ? {PC_plus4[31:28], Ins[25:0], 2'b00}:
                        BranchPCSrc ? BranchDst:
                            PC_plus4_in;

endmodule : ID