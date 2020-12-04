module Register(
    input reset,
    input clk,
    input [4:0] Write_Addr,
    input [4:0] Read_Addr_1,
    input [4:0] Read_Addr_2,
    input [31:0] Write_Data,
    output [31:0] Read_Data_1,
    output [31:0] Read_Data_2,
    input RegWrite,
    input [31:0] Register_26,
    input PCBackup
);

    reg [31:0] Register_Data [31:1];

    assign Read_Data_1 = (Read_Addr_1 == 5'b00000) ? 32'h00000000:Register_Data[Read_Addr_1];
    assign Read_Data_2 = (Read_Addr_2 == 5'b00000) ? 32'h00000000:Register_Data[Read_Addr_2];

    integer i;

    always @(posedge reset or posedge clk) begin
        if (reset) begin
            for (i = 1; i < 32; i = i+1)
                if (i == 29)
                    Register_Data[i] <= 32'h00000800;
                else
                    Register_Data[i] <= 32'h00000000;
        end else begin
            if (RegWrite && (Write_Addr != 5'b00000))
                Register_Data[Write_Addr] <= Write_Data;
            if (PCBackup)
                Register_Data[26] <= Register_26;
        end
    end

endmodule : Register