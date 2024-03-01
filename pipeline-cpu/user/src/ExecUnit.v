`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/ALU.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/ExtendByOp.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/ALUctr.v"
module ExecUnit(B, busA, busB,imm16, func, ExtOp,
            ALUSrc, ALUop, Rtype, Btarg, Zero, Overflow, ALUout);
    input[29:0] B;
    input[31:0] busA, busB;
    input[15:0] imm16;
    input[5:0] func;
    input ExtOp, ALUSrc;
    input[2:0] ALUop;
    input Rtype;
    output reg[29:0] Btarg;
    output Zero, Overflow;
    output[31:0] ALUout;

    wire [31:0] 	imm32;
    ExtendByOp u_ExtendByOp(
        .imm16 	( imm16  ),
        .ExtOp 	( ExtOp  ),
        .imm32 	( imm32  )
    );

    wire [2:0] 	ALUctr1;
    ALUctr u_ALUctr(
        .func   	( func    ),
        .ALUctr 	( ALUctr1  )
    );

    reg[31:0] rhs;
    reg[2:0] ctr;
    wire         	Zero;
    wire         	Overflow;
    ALU u_ALU(
        .A        	( busA      ),
        .B        	( rhs       ),
        .ALUctr   	( ctr       ),
        .Result   	( ALUout    ),
        .Zero     	( Zero      ),
        .Overflow 	( Overflow  )
    );

always @ (*)begin
    Btarg = B + imm32[29:0];
    rhs = ALUSrc ? imm32 : busB;
    ctr = Rtype ? ALUctr1 : ALUop;
    end

endmodule