module ID_EX(
    input reset,
    input clk,
    input [12:0] ID_EX_OpCode_in,
    output [5:0] EX_MEM_OpCode_out,
    input [31:0] PC_plus4_in,
    output [31:0] PC_plus4_out,
    output ALUSrc1_out,
    output ALUSrc2_out,
    output [3:0] ALUOp_out,
    output RtRd_out,
    input [31:0] Read_Data_1_in,
    output [31:0] Read_Data_1_out,
    input [31:0] Read_Data_2_in,
    output [31:0] Read_Data_2_out,
    input [31:0] immediate_in,
    output [31:0] immediate_out,
    input [4:0] Rt_in,
    output [4:0] Rt_out,
    input [4:0] Rd_in,
    output [4:0] Rd_out,
    input [4:0] Rs_in,
    output [4:0] Rs_out,
    input [5:0] funct_in,
    output [5:0] funct_out,
    input [4:0] shamt_in,
    output [4:0] shamt_out
);
    reg [5:0] EX_MEM_OpCpde;
    reg [31:0] PC_plus4;
    reg ALUSrc1;
    reg ALUSrc2;
    reg [3:0] ALUOp;
    reg RtRd;
    reg [31:0] Read_Data_1;
    reg [31:0] Read_Data_2;
    reg [31:0] immediate;
    reg [4:0] Rt, Rs, Rd;
    reg [5:0] funct;
    reg [4:0] shamt;

    assign EX_MEM_OpCode_out = EX_MEM_OpCpde;
    assign PC_plus4_out = PC_plus4;
    assign ALUSrc1_out = ALUSrc1;
    assign ALUSrc2_out = ALUSrc2;
    assign ALUOp_out = ALUOp;
    assign RtRd_out = RtRd;
    assign Read_Data_1_out = Read_Data_1;
    assign Read_Data_2_out = Read_Data_2;
    assign immediate_out = immediate;
    assign Rt_out = Rt;
    assign Rs_out = Rs;
    assign Rd_out = Rd;
    assign funct_out = funct;
    assign shamt_out = shamt;

    always @(posedge reset or posedge clk) begin
        if (reset) begin
            EX_MEM_OpCpde <= 6'b000000;
            PC_plus4 <= 32'h00000000;
            ALUSrc1 <= 1'b0;
            ALUSrc2 <= 1'b0;
            ALUOp <= 4'b0000;
            RtRd <= 1'b0;
            Read_Data_1 <= 32'h00000000;
            Read_Data_2 <= 32'h00000000;
            immediate <= 32'h00000000;
            Rt <= 5'b00000;
            Rs <= 5'b00000;
            Rd <= 5'b00000;
            funct <= 6'b000000;
            shamt <= 5'b00000;
        end
        else begin
            ALUSrc1 <= ID_EX_OpCode_in[12];
            ALUSrc2 <= ID_EX_OpCode_in[11];
            ALUOp <= ID_EX_OpCode_in[10:7];
            RtRd <= ID_EX_OpCode_in[6];
            EX_MEM_OpCpde <= ID_EX_OpCode_in[5:0];
            PC_plus4 <= PC_plus4_in;
            Read_Data_1 <= Read_Data_1_in;
            Read_Data_2 <= Read_Data_2_in;
            immediate <= immediate_in;
            Rt <= Rt_in;
            Rs <= Rs_in;
            Rd <= Rd_in;
            funct <= funct_in;
            shamt <= shamt_in;
        end
    end

endmodule