module ExtendByOp(
    input [15:0] imm16,
    input ExtOp,
    output [31:0] imm32
);
    // 1为符号扩展，0为0扩展
    assign imm32 = ExtOp ? {{16{imm16[15]}}, imm16} : {16'b0, imm16};
endmodule