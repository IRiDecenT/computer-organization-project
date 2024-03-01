module IDReg(
    input clk,
    input[29:0] B,
    input[29:0] Jtarg,
    input[5:0] func,
    input[15:0] imm16,
    input[31:0] busA,
    input[31:0] busB,
    input[4:0] Rt,
    input[4:0] Rd,
    // 保存十个控制信号
    input RegWr,
    input ALUSrc,
    input RegDst,
    input MemtoReg,
    input MemWr,
    input branch,
    input Jump,
    input ExtOp,
    input rtype,
    input[2:0] ALUOp,

    output reg[29:0] B_out,
    output reg[29:0] Jtarg_out,
    output reg[5:0] func_out,
    output reg[15:0] imm16_out,
    output reg[31:0] busA_out,
    output reg[31:0] busB_out,
    output reg[4:0] Rt_out,
    output reg[4:0] Rd_out,

    output reg RegWr_out,
    output reg ALUSrc_out,
    output reg RegDst_out,
    output reg MemtoReg_out,
    output reg MemWr_out,
    output reg branch_out,
    output reg Jump_out,
    output reg ExtOp_out,
    output reg[2:0] ALUOp_out,
    output reg rtype_out
    );
    always @(negedge clk) begin
        B_out <= B;
        Jtarg_out <= Jtarg;
        func_out <= func;
        imm16_out <= imm16;
        busA_out <= busA;
        busB_out <= busB;
        Rt_out <= Rt;
        Rd_out <= Rd;

        RegWr_out <= RegWr;
        ALUSrc_out <= ALUSrc;
        RegDst_out <= RegDst;
        MemtoReg_out <= MemtoReg;
        MemWr_out <= MemWr;
        branch_out <= branch;
        Jump_out <= Jump;
        ExtOp_out <= ExtOp;
        ALUOp_out <= ALUOp;
        rtype_out <= rtype;
    end
endmodule