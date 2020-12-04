module Ctrl(
    input PC31,
    input [5:0] OpCode,
    input [5:0] funct,
    output reg [1:0] PCSrc,
    output reg Branch,
    output reg [2:0] CpCode,
    output reg CtrlFlush,
    output reg LuOp,
    output reg ExtOp,
    output reg BadOp,
    output [12:0] ID_EX_OpCode
);

    reg ALUSrc1;
    reg ALUSrc2;
    wire [3:0] ALUOp;
    reg RtRd;
    reg MemRead;
    reg MemWrite;
    reg [1:0] MemtoReg;
    reg RegWrite;
    reg RegDst;

    assign ID_EX_OpCode = {ALUSrc1, ALUSrc2, ALUOp, RtRd, MemRead, MemWrite, MemtoReg, RegWrite, RegDst};

    always @(*) begin
        case (OpCode)
            6'h23: begin    // lw
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                MemtoReg = 2'b01;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h2b: begin    // sw
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h0f: begin    // lui
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b1;
                ExtOp = 1'bx;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h00: begin    // add addu sub subu and or xor nor slt sltu || sll srl sra || jr || jalr
                if (funct[5] == 1'b1) begin  // add addu sub subu and or xor nor slt sltu
                    PCSrc = 2'b00;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b0;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b0;
                    ALUSrc1 = 1'b0;
                    ALUSrc2 = 1'b0;
                    RtRd = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'b00;
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                end
                else if (funct[3] == 1'b0) begin // sll srl sra
                    PCSrc = 2'b00;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b0;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b0;
                    ALUSrc1 = 1'b1;
                    ALUSrc2 = 1'b0;
                    RtRd = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'b00;
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                end
                else if (funct[2] == 1'b0) begin // jr
                    PCSrc = 2'b10;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b1;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b0;
                    ALUSrc1 = 1'bx;
                    ALUSrc2 = 1'bx;
                    RtRd = 1'bx;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'bxx;
                    RegWrite = 1'b0;
                    RegDst = 1'bx;
                end
                else begin // jalr
                    PCSrc = 2'b10;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b1;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b0;
                    ALUSrc1 = 1'bx;
                    ALUSrc2 = 1'bx;
                    RtRd = 1'b1;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'b10;
                    RegWrite = 1'b1;
                    RegDst = 1'b0;
                end
            end
            6'h08: begin    // addi
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h09: begin    // addiu
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h0c: begin    // andi
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h0d: begin           //ori
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h0a: begin    // slti
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h0b: begin    // sltiu
                PCSrc = 2'b00;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b0;
                BadOp = 1'b0;
                ALUSrc1 = 1'b0;
                ALUSrc2 = 1'b1;
                RtRd = 1'b0;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                RegDst = 1'b0;
            end
            6'h04: begin    // beq
                PCSrc = 2'b00;
                Branch = 1'b1;
                CpCode = 3'b000;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h05: begin    // bne
                PCSrc = 2'b00;
                Branch = 1'b1;
                CpCode = 3'b001;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h06: begin    // blez
                PCSrc = 2'b00;
                Branch = 1'b1;
                CpCode = 3'b010;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h07: begin    // bgtz
                PCSrc = 2'b00;
                Branch = 1'b1;
                CpCode = 3'b011;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h01: begin    // bltz
                PCSrc = 2'b00;
                Branch = 1'b1;
                CpCode = 3'b100;
                CtrlFlush = 1'b0;
                LuOp = 1'b0;
                ExtOp = 1'b1;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h02: begin    // j
                PCSrc = 2'b01;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b1;
                LuOp = 1'bx;
                ExtOp = 1'bx;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'bxx;
                RegWrite = 1'b0;
                RegDst = 1'bx;
            end
            6'h03: begin    // jal
                PCSrc = 2'b01;
                Branch = 1'b0;
                CpCode = 3'bxxx;
                CtrlFlush = 1'b1;
                LuOp = 1'bx;
                ExtOp = 1'bx;
                BadOp = 1'b0;
                ALUSrc1 = 1'bx;
                ALUSrc2 = 1'bx;
                RtRd = 1'bx;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                MemtoReg = 2'b10;
                RegWrite = 1'b1;
                RegDst = 1'b1;
            end
            default: begin  // BadOp
                if (PC31) begin
                    PCSrc = 2'b00;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b0;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b0;
                    ALUSrc1 = 1'bx;
                    ALUSrc2 = 1'bx;
                    RtRd = 1'bx;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'bxx;
                    RegWrite = 1'b0;
                    RegDst = 1'bx;
                end else begin
                    PCSrc = 2'b00;
                    Branch = 1'b0;
                    CpCode = 3'bxxx;
                    CtrlFlush = 1'b0;
                    LuOp = 1'bx;
                    ExtOp = 1'bx;
                    BadOp = 1'b1;
                    ALUSrc1 = 1'bx;
                    ALUSrc2 = 1'bx;
                    RtRd = 1'bx;
                    MemRead = 1'b0;
                    MemWrite = 1'b0;
                    MemtoReg = 2'bxx;
                    RegWrite = 1'b0;
                    RegDst = 1'bx;
                end
            end
        endcase
    end

    assign ALUOp[2:0] =
        (OpCode == 6'h00) ? 3'b010:
            (OpCode == 6'h04) ? 3'b001:
                (OpCode == 6'h0c) ? 3'b100:
                    (OpCode == 6'h0a || OpCode == 6'h0b) ? 3'b101:
                        (OpCode == 6'h0d) ? 3'b110:
                        3'b000;

    assign ALUOp[3] = OpCode[0];

endmodule : Ctrl
