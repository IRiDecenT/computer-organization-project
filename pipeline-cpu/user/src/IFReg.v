// 第一个流水段IF的寄存器
// 需要保存指令, PC + 4 作为B, 以及PC的前四位作为J
module IFReg(
    input clk,
    input[29:0] B,
    input[3:0] J,
    input[31:0] instruction,
    output reg[29:0] B_out,
    output reg[29:0] Jtarg,
    output reg[31:0] instruction_out
    );
    always @(negedge clk) begin
        B_out <= B;
        Jtarg <= {J, instruction[25:0]};
        instruction_out <= instruction;
    end

endmodule