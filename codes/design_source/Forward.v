module Forward(
    input EX_MEM_RegWrite, 
    input [4:0] EX_MEM_RegWriteDst, 
    input MEM_WB_RegWrite, 
    input [4:0] MEM_WB_RegWriteDst, 
    input [4:0] ID_EX_RegisterRs, 
    input [4:0] ID_EX_RegisterRt, 
    input [4:0] IF_ID_RegisterRs, 
    input [4:0] IF_ID_RegisterRt, 
    output RegData1, 
    output RegData2, 
    output [1:0] DataSrc1, 
    output [1:0] DataSrc2
);

    assign RegData1 = EX_MEM_RegWrite && EX_MEM_RegWriteDst != 0 && EX_MEM_RegWriteDst == IF_ID_RegisterRs;
    assign RegData2 = EX_MEM_RegWrite && EX_MEM_RegWriteDst != 0 && EX_MEM_RegWriteDst == IF_ID_RegisterRt;

    assign DataSrc1 = (EX_MEM_RegWrite &&
        EX_MEM_RegWriteDst != 5'b00000 &&
        EX_MEM_RegWriteDst == ID_EX_RegisterRs) ? 2'b10:
        (MEM_WB_RegWrite &&
            MEM_WB_RegWriteDst != 5'b00000 &&
            MEM_WB_RegWriteDst == ID_EX_RegisterRs) ? 2'b01:2'b00;
    assign DataSrc2 = (EX_MEM_RegWrite &&
        EX_MEM_RegWriteDst != 5'b00000 &&
        EX_MEM_RegWriteDst == ID_EX_RegisterRt) ? 2'b10:
        (MEM_WB_RegWrite &&
            MEM_WB_RegWriteDst != 5'b00000 &&
            MEM_WB_RegWriteDst == ID_EX_RegisterRt) ? 2'b01:2'b00;

endmodule