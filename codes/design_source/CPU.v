module CPU(
    input reset,
    input clk,
    output [11:0] BCD7
);
    
    wire [34:0] ID2IF;
    wire [95:0] IF2ID;
    wire [1:0] Forward2ID;
    wire [70:0] MEM2ID;
    wire [166:0] ID2EX;
    wire [31:0] WB2EX;
    wire [3:0] Forward2EX;
    wire [106:0] EX2MEM;
    wire [9:0] EX2Forward;
    wire [5:0] WB2Forward;
    wire [31:0] LEDs;
    wire [31:0] BCD7_extend;
    wire [31:0] SysTick;
    wire Irq;

    assign BCD7 = BCD7_extend[11:0];
    
    IF instruction_fetch(
        .reset(reset),
        .clk(clk),
        .PC_in(ID2IF[34:3]),
        .CtrlFlush(ID2IF[2]),
        .BranchPCSrc(ID2IF[1]),
        .ExpFlush(ID2IF[0]),
        .Instruction(IF2ID[95:64]),
        .PC_plus4(IF2ID[63:32]),
        .PC_out(IF2ID[31:0])
    );
    
    ID instruction_decode(
        .reset(reset),
        .clk(clk),
        .PC_plus4_in(IF2ID[63:32]),
        .Ins_in(IF2ID[95:64]),
        .RegData1(Forward2ID[1]),
        .RegData2(Forward2ID[0]),
        .RegWriteDst(MEM2ID[36:32]),
        .Write_Data(MEM2ID[68:37]),
        .PC(IF2ID[31:0]),
        .ALUout(MEM2ID[31:0]),
        .RegWrite(MEM2ID[70]),
        .RegDst(MEM2ID[69]),
        .Irq(Irq),
        .PC_next(ID2IF[34:3]),
        .Rt(ID2EX[4:0]),
        .Rd(ID2EX[9:5]),
        .Rs(ID2EX[14:10]),
        .funct(ID2EX[20:15]),
        .shamt(ID2EX[25:21]),
        .immediate(ID2EX[57:26]),
        .Read_Data_2(ID2EX[89:58]),
        .Read_Data_1(ID2EX[121:90]),
        .BranchPCSrc(ID2IF[1]),
        .CtrlFlush(ID2IF[2]),
        .ExpFlush(ID2IF[0]),
        .ID_EX_OpCode(ID2EX[134:122]),
        .PC_plus4(ID2EX[166:135])
    );

    EX execution(
        .reset(reset),
        .clk(clk),
        .ID_EX_OpCode(ID2EX[134:122]),
        .PC_plus4_in(ID2EX[166:135]),
        .Read_Data_1_in(ID2EX[121:90]),
        .Read_Data_2_in(ID2EX[89:58]),
        .immediate_in(ID2EX[57:26]),
        .Rt_in(ID2EX[4:0]),
        .Rd_in(ID2EX[9:5]),
        .Rs_in(ID2EX[14:10]),
        .funct_in(ID2EX[20:15]),
        .shamt_in(ID2EX[25:21]),
        .ALUout_prev(MEM2ID[31:0]),
        .MemtoReg(WB2EX),
        .DataSrc1(Forward2EX[3:2]),
        .DataSrc2(Forward2EX[1:0]),
        .EX_MEM_OpCode(EX2MEM[106:101]),
        .PC_plus4(EX2MEM[100:69]),
        .ALUout(EX2MEM[68:37]),
        .Write_Data(EX2MEM[36:5]),
        .RegWriteDst(EX2MEM[4:0]),
        .Rs(EX2Forward[9:5]),
        .Rt(EX2Forward[4:0])
    );

    MEM memory(
        .reset(reset),
        .clk(clk),
        .EX_MEM_OpCode(EX2MEM[106:101]),
        .PC_plus4_in(EX2MEM[100:69]),
        .ALUout_in(EX2MEM[68:37]),
        .WriteData(EX2MEM[36:5]),
        .RegWriteDst_in(EX2MEM[4:0]),
        .RegWrite(MEM2ID[70]),
        .RegDst(MEM2ID[69]),
        .RegWriteData(MEM2ID[68:37]),
        .RegWriteDst(MEM2ID[36:32]),
        .ALUout(MEM2ID[31:0]),
        .LEDs(LEDs),
        .BCD7(BCD7_extend),
        .SysTick(SysTick),
        .Irq(Irq)
    );

    WB write_back(
        .reset(reset),
        .clk(clk),
        .RegWrite_in(MEM2ID[70]),
        .MEM_WB_Forward_Data_in(MEM2ID[68:37]),
        .RegWriteDst_in(MEM2ID[36:32]),
        .RegWrite(WB2Forward[5]),
        .MEM_WB_Forward_Data(WB2EX),
        .RegWriteDst(WB2Forward[4:0])
    );

    Forward forwarding(
        .EX_MEM_RegWrite(MEM2ID[70]),
        .EX_MEM_RegWriteDst(MEM2ID[36:32]),
        .MEM_WB_RegWrite(WB2Forward[5]),
        .MEM_WB_RegWriteDst(WB2Forward[4:0]),
        .ID_EX_RegisterRs(EX2Forward[9:5]),
        .ID_EX_RegisterRt(EX2Forward[4:0]),
        .IF_ID_RegisterRs(ID2EX[14:10]),
        .IF_ID_RegisterRt(ID2EX[4:0]),
        .RegData1(Forward2ID[1]),
        .RegData2(Forward2ID[0]),
        .DataSrc1(Forward2EX[3:2]),
        .DataSrc2(Forward2EX[1:0])
    );
    
endmodule : CPU