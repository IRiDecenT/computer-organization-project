module InstructionDecode(op, RegWr, ALUSrc, RegDst, MemtoReg, MemWr, branch, Jump, ExtOp, ALUOp, rtype);
    input[5:0] op;
    output RegWr;
    output ALUSrc;
    output RegDst;
    output MemtoReg;
    output MemWr;
    output branch;
    output Jump;
    output ExtOp;
    output [2:0] ALUOp;
    output rtype;

    wire ori, addiu, lw, sw, beq, jump;
    assign rtype = (op == 6'b000000);
    assign ori = (op == 6'b001101);
    assign addiu = (op == 6'b001001);
    assign lw = (op == 6'b100011);
    assign sw = (op == 6'b101011);
    assign beq = (op == 6'b000100);
    assign jump = (op == 6'b000010);

    assign RegWr = rtype | ori | addiu | lw;
    assign ALUSrc = ori | addiu | lw | sw;
    assign RegDst = rtype;
    assign MemtoReg = lw;
    assign MemWr = sw;
    assign branch = beq;
    assign Jump = jump;
    assign ExtOp = addiu | lw | sw;
    assign ALUOp[2] = beq;
    assign ALUOp[1] = ori;
    assign ALUOp[0] = rtype;

endmodule