module EX(
    input reset,
    input clk,
    input [12:0] ID_EX_OpCode,
    input [31:0] PC_plus4_in,
    input [31:0] Read_Data_1_in,
    input [31:0] Read_Data_2_in,
    input [31:0] immediate_in,
    input [4:0] Rt_in,
    input [4:0] Rd_in,
    input [4:0] Rs_in,
    input [5:0] funct_in,
    input [4:0] shamt_in,
    input [31:0] ALUout_prev,
    input [31:0] MemtoReg,
    input [1:0] DataSrc1,
    input [1:0] DataSrc2,
    output [5:0] EX_MEM_OpCode,
    output [31:0] PC_plus4,
    output [31:0] ALUout,
    output [31:0] Write_Data,
    output [4:0] RegWriteDst,
    output [4:0] Rs,
    output [4:0] Rt
);
    wire ALUSrc1, ALUSrc2;
    wire [3:0] ALUOp;
    wire RtRd;
    wire [31:0] ALUdata1, ALUdata2;
    wire [31:0] immediate;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [31:0] Read_Data_1;
    wire [31:0] Read_Data_2;
    wire [4:0] ALUCtl;
    wire [4:0] Rd;
    wire Sign;

    ALU alu(
        .in1(ALUdata1),
        .in2(ALUdata2),
        .ALUCtl(ALUCtl),
        .Sign(Sign),
        .out(ALUout)
    );

    ALU_Ctrl alu_ctrl(
        .ALUOp(ALUOp),
        .Funct(funct),
        .ALUCtl(ALUCtl),
        .Sign(Sign)
    );

    ID_EX id_ex(
        .reset(reset),
        .clk(clk),
        .ID_EX_OpCode_in(ID_EX_OpCode),
        .EX_MEM_OpCode_out(EX_MEM_OpCode),
        .PC_plus4_in(PC_plus4_in),
        .PC_plus4_out(PC_plus4),
        .ALUSrc1_out(ALUSrc1),
        .ALUSrc2_out(ALUSrc2),
        .ALUOp_out(ALUOp),
        .RtRd_out(RtRd),
        .Read_Data_1_in(Read_Data_1_in),
        .Read_Data_1_out(Read_Data_1),
        .Read_Data_2_in(Read_Data_2_in),
        .Read_Data_2_out(Read_Data_2),
        .immediate_in(immediate_in),
        .immediate_out(immediate),
        .Rt_in(Rt_in),
        .Rt_out(Rt),
        .Rd_in(Rd_in),
        .Rd_out(Rd),
        .Rs_in(Rs_in),
        .Rs_out(Rs),
        .funct_in(funct_in),
        .funct_out(funct),
        .shamt_in(shamt_in),
        .shamt_out(shamt)
    );

    assign ALUdata1 =
        ALUSrc1 ? {{27{1'b0}}, shamt}:
            (DataSrc1 == 2'b10) ? ALUout_prev:
                (DataSrc1 == 2'b01) ? MemtoReg:
                    Read_Data_1;
    
    assign Write_Data = 
        (DataSrc2 == 2'b10) ? ALUout_prev:
                (DataSrc2 == 2'b01) ? MemtoReg:
                    Read_Data_2;
    
    assign ALUdata2 = ALUSrc2 ? immediate: Write_Data;
    assign RegWriteDst = RtRd ? Rd : Rt;

endmodule: EX