module Data_Memory(
    input reset, 
    input clk, 
    input [31:0] Read_Addr,
    input [31:0] Write_Addr,
    input [31:0] Write_Data, 
    output [31:0] Read_Data, 
    input MemRead, 
    input MemWrite,
    output reg [31:0] LEDs,
    output reg [31:0] BCD7,
    output reg [31:0] SysTick,
    output Irq
);

    parameter RAM_SIZE=512;
    parameter RAM_SIZE_BIT=9;

    reg [31:0] RAM_data [RAM_SIZE-1:0];
    reg [31:0] Timer [2:0];

    assign Read_Data =
        MemRead ? (Read_Addr < 32'h000007ff) ? RAM_data[Read_Addr[RAM_SIZE_BIT+1:2]]:
            (Read_Addr == 32'h40000000) ? Timer[0]:
                (Read_Addr == 32'h40000004) ? Timer[1]:
                    (Read_Addr == 32'h40000008) ? Timer[2]:
                        (Read_Addr == 32'h4000000c) ? LEDs:
                            (Read_Addr == 32'h40000010) ? BCD7:
                                (Read_Addr == 32'h40000014) ? SysTick:
                                    32'h00000000:
            32'h00000000;
    assign Irq = Timer[2][2];

    integer i;
    always @(posedge reset or posedge clk) begin
        if (reset) begin
			RAM_data[0] <= 32'h8351D612;
			RAM_data[1] <= 32'h836A9DF7;
			RAM_data[2] <= 32'h069897D9;
			RAM_data[3] <= 32'h6BE08520;
			RAM_data[4] <= 32'h96C082D1;
			RAM_data[5] <= 32'h4F041323;
			RAM_data[6] <= 32'h905C8664;
			RAM_data[7] <= 32'h16151644;
			RAM_data[8] <= 32'h736050AE;
			RAM_data[9] <= 32'h3456A8EA;
			RAM_data[10] <= 32'hE769062B;
			RAM_data[11] <= 32'h481C43B4;
			RAM_data[12] <= 32'h800EF561;
			RAM_data[13] <= 32'hA7095BC5;
			RAM_data[14] <= 32'h7932B90F;
			RAM_data[15] <= 32'hDD470FFA;
			RAM_data[16] <= 32'hE0D11B93;
			RAM_data[17] <= 32'hCBB64EB7;
			RAM_data[18] <= 32'h29C2410B;
			RAM_data[19] <= 32'h8F5EEA78;
			RAM_data[20] <= 32'hD521D426;
			RAM_data[21] <= 32'hA2FE6E5F;
			RAM_data[22] <= 32'hBB7A4B6F;
			RAM_data[23] <= 32'h5F8930BC;
			RAM_data[24] <= 32'h6B6FFB03;
			RAM_data[25] <= 32'h99CB5C1A;
			RAM_data[26] <= 32'hE5829B71;
			RAM_data[27] <= 32'h41C54A4D;
			RAM_data[28] <= 32'h1EEC40F5;
			RAM_data[29] <= 32'hB7EE6A43;
			RAM_data[30] <= 32'hA06BAA2A;
			RAM_data[31] <= 32'h67FAA645;
			RAM_data[32] <= 32'hD7FB71E1;
			RAM_data[33] <= 32'h9C8A8841;
			RAM_data[34] <= 32'h57757A9A;
			RAM_data[35] <= 32'h3307DD5B;
			RAM_data[36] <= 32'h307DB362;
			RAM_data[37] <= 32'hE9ECAF7F;
			RAM_data[38] <= 32'hD37AAD7D;
			RAM_data[39] <= 32'h9F01A984;
			RAM_data[40] <= 32'h4577F5A9;
			RAM_data[41] <= 32'h670CA18B;
			RAM_data[42] <= 32'h0D412931;
			RAM_data[43] <= 32'hBA044BF3;
			RAM_data[44] <= 32'h599B2245;
			RAM_data[45] <= 32'hD489E00D;
			RAM_data[46] <= 32'h4F554E9E;
			RAM_data[47] <= 32'h415F9ECE;
			RAM_data[48] <= 32'h5B666505;
			RAM_data[49] <= 32'hB8680CAC;
			RAM_data[50] <= 32'h4963237B;
			RAM_data[51] <= 32'h12240C85;
			RAM_data[52] <= 32'h764EB018;
			RAM_data[53] <= 32'hA0AEE90E;
			RAM_data[54] <= 32'h8337088F;
			RAM_data[55] <= 32'hD988D050;
			RAM_data[56] <= 32'h27609C46;
			RAM_data[57] <= 32'h162C632E;
			RAM_data[58] <= 32'hE0718679;
			RAM_data[59] <= 32'hEE13F331;
			RAM_data[60] <= 32'h0E8C4A32;
			RAM_data[61] <= 32'hC83629A5;
			RAM_data[62] <= 32'hAAE7CC9E;
			RAM_data[63] <= 32'hCF0FCD0A;
			RAM_data[64] <= 32'h2C34C446;
			RAM_data[65] <= 32'h8CF9BC12;
			RAM_data[66] <= 32'h9233C30A;
			RAM_data[67] <= 32'hA29E2600;
			RAM_data[68] <= 32'h734A83E3;
			RAM_data[69] <= 32'h53D7EFB8;
			RAM_data[70] <= 32'h59DC6B77;
			RAM_data[71] <= 32'h4C4A0C0A;
			RAM_data[72] <= 32'h457C9A85;
			RAM_data[73] <= 32'h5D53BCA9;
			RAM_data[74] <= 32'h7E435DD6;
			RAM_data[75] <= 32'hB3FA252E;
			RAM_data[76] <= 32'h7DC3C884;
			RAM_data[77] <= 32'hB62FDB0A;
			RAM_data[78] <= 32'h1EEA63F9;
			RAM_data[79] <= 32'h62B9AC1D;
			RAM_data[80] <= 32'h592159E3;
			RAM_data[81] <= 32'h520B84BF;
			RAM_data[82] <= 32'h88720454;
			RAM_data[83] <= 32'hF659301F;
			RAM_data[84] <= 32'hE47DC8BF;
			RAM_data[85] <= 32'h9CCD8207;
			RAM_data[86] <= 32'hCB9BC334;
			RAM_data[87] <= 32'h201EEC6B;
			RAM_data[88] <= 32'h58C6B375;
			RAM_data[89] <= 32'h51504A1B;
			RAM_data[90] <= 32'h08CE437E;
			RAM_data[91] <= 32'h24EF2D3D;
			RAM_data[92] <= 32'h57A7EAE7;
			RAM_data[93] <= 32'hACBEDE23;
			RAM_data[94] <= 32'h23B5FF8D;
			RAM_data[95] <= 32'h1A7CDE02;
			RAM_data[96] <= 32'hA7135275;
			RAM_data[97] <= 32'h6B1BE15E;
			RAM_data[98] <= 32'h7EFB9732;
			RAM_data[99] <= 32'h290FC9E6;
			RAM_data[100] <= 32'h33F028BF;
			RAM_data[101] <= 32'hE43CD0B6;
			RAM_data[102] <= 32'hEE76B70A;
			RAM_data[103] <= 32'h5AF5674F;
			RAM_data[104] <= 32'h3540B38A;
			RAM_data[105] <= 32'h1D32C8D9;
			RAM_data[106] <= 32'h12B8AA63;
			RAM_data[107] <= 32'h50F00CD2;
			RAM_data[108] <= 32'hE58E6A03;
			RAM_data[109] <= 32'h8CE51DBF;
			RAM_data[110] <= 32'hDE7C67EE;
			RAM_data[111] <= 32'hBCA106BA;
			RAM_data[112] <= 32'hC25D6ED9;
			RAM_data[113] <= 32'h62ADE556;
			RAM_data[114] <= 32'hF1E9D4C1;
			RAM_data[115] <= 32'hE942D167;
			RAM_data[116] <= 32'h2186F405;
			RAM_data[117] <= 32'h0ED35BF9;
			RAM_data[118] <= 32'h1B61B50E;
			RAM_data[119] <= 32'h02BDDF05;
			RAM_data[120] <= 32'hFF1E3948;
			RAM_data[121] <= 32'hF6473FF0;
			RAM_data[122] <= 32'h9D422CC2;
			RAM_data[123] <= 32'h43D3460F;
			RAM_data[124] <= 32'hA7DC9992;
			RAM_data[125] <= 32'h48122D6D;
			RAM_data[126] <= 32'hEAC15BCE;
			RAM_data[127] <= 32'hDA1E623C;
            for (i = 128; i < RAM_SIZE; i = i+1)
                RAM_data[i] <= 32'h00000000;
            LEDs <= 32'h00000000;
            BCD7 <= 32'h00000000;
            SysTick <= 32'h00000000;
            for (i = 0; i < 3; i = i + 1)
                Timer[i] <= 32'h00000000;
        end
        else begin
            if (MemWrite) begin
                if (Write_Addr < 32'h000007ff)
                    RAM_data[Write_Addr[RAM_SIZE_BIT+1:2]] <= Write_Data;
                else if (Write_Addr == 32'h4000000c)
                    LEDs <= Write_Data;
                else if (Write_Addr == 32'h40000010)
                    BCD7 <= Write_Data;
            end
            if (MemWrite && Write_Addr == 32'h40000000)
                Timer[0] <= Write_Data;
            else if (MemWrite && Write_Addr == 32'h40000004)
                Timer[1] <= Write_Data;
            else if (MemWrite && Write_Addr == 32'h40000008)
                Timer[2] <= Write_Data;
            else begin
                if (Timer[2][0]) begin
                    if (Timer[1] == Timer[0]) begin
                        Timer[1] <= 32'h00000000;
                        if (Timer[2][1])
                            Timer[2][2] <= 1'b1;
                    end
                    else
                        Timer[1] <= Timer[1] + 32'h00000001;
                        if (Timer[1] == 32'h00000001)
                            Timer[2][2] <= 1'b0;
                end
            end
            
            if (MemWrite && Write_Addr == 32'h40000014)
                    SysTick <= Write_Data;
            else
                SysTick <= SysTick + 32'h00000001;
        end
    end
endmodule