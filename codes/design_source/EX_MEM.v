module EX_MEM(
    input reset,
    input clk,
    input [5:0] EX_MEM_OpCode_in,
    input [31:0] PC_plus4_in,
    input [31:0] ALUout_in,
    input [4:0] RegWriteDst_in,
    output reg RegWrite,
    output reg [31:0] PC_plus4,
    output reg MemRead,
    output MemWrite,
    output reg [1:0] MemtoReg,
    output reg RegDst,
    output reg [31:0] ALUout,
    output reg [4:0] RegWriteDst
);
    assign MemWrite = EX_MEM_OpCode_in[4];
    
    always @(posedge reset or posedge clk) begin

        if (reset) begin
            RegWrite <= 1'b0;
            RegDst <= 1'b0;
            ALUout <= 32'h00000000;
            RegWriteDst <= 5'b00000;
            MemtoReg <= 2'b00;
            MemRead <= 1'b0;
            PC_plus4 <= 32'h00000000;
        end
        else begin
            RegWrite <= EX_MEM_OpCode_in[1];
            RegDst <= EX_MEM_OpCode_in[0];
            ALUout <= ALUout_in;
            RegWriteDst <= RegWriteDst_in;
            MemtoReg <= EX_MEM_OpCode_in[3:2];
            MemRead <= EX_MEM_OpCode_in[5];
            PC_plus4 <= PC_plus4_in;
        end
    end

endmodule : EX_MEM