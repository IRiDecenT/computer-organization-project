`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/InstructionMem.v"
module IUnit(
    input[29:0] PC,
    output reg[29:0] B,
    output reg[3:0] J,
    output[31:0] instruction
    );

always @(PC) begin
    B = PC + 1;
    J = PC[29:26];
end

InstructionMem im(
    .InsAddr({PC, 2'b00}),
    .InsData(instruction)
);

endmodule