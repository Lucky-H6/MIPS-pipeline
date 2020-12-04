module WB(
    input reset,
    input clk,
    input RegWrite_in,
    input [31:0]  MEM_WB_Forward_Data_in,
    input [4:0] RegWriteDst_in,
    output reg RegWrite,
    output reg [31:0] MEM_WB_Forward_Data,
    output reg [4:0] RegWriteDst
);

    always @(posedge reset or posedge clk) begin
        if  (reset) begin
            RegWrite <= 1'b0;
            MEM_WB_Forward_Data <= 32'h00000000;
            RegWriteDst <= 5'b00000;
        end
        else begin
            RegWrite <= RegWrite_in;
            MEM_WB_Forward_Data <= MEM_WB_Forward_Data_in;
            RegWriteDst <= RegWriteDst_in;
        end
    end

endmodule : WB