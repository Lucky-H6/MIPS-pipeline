module IF_ID(reset, clk, ins_in, ins_out, PC_plus4_in, PC_plus4_out);

    input reset, clk;
    input [31:0] ins_in, PC_plus4_in;
    output [31:0] ins_out, PC_plus4_out;

    reg [31:0] ins, PC_plus4;

    assign ins_out = ins;
    assign PC_plus4_out = PC_plus4;

    always @(posedge reset or posedge clk)
        if (reset) begin
            ins <= 32'h00000000;
            PC_plus4 <= 32'h00000000;
        end
        else begin
            ins <= ins_in;
            PC_plus4 <= PC_plus4_in;
        end

endmodule