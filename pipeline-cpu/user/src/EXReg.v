module EXReg(clk, Btarg, Jtarg, Zero, Overflow,
             ALUout, DataIn, Rw, Btarg_out,
             Jtarg_out, Zero_out, Overflow_out, Addr_out, Di_out,
             Rw_out,MemWr_out, Branch_out, Jump_out, MemtoReg_out, RegWr_out,
             MemWr, Branch, Jump, MemtoReg, RegWr);
    input clk;
    input[29:0] Btarg, Jtarg;
    input Zero, Overflow;
    input[31:0] ALUout, DataIn;
    input[4:0] Rw;
    // 控制信号
    input MemWr, Branch, Jump, MemtoReg, RegWr;

    output reg[29:0] Btarg_out, Jtarg_out;
    output reg Zero_out, Overflow_out;
    output reg[31:0] Addr_out;
    output reg[31:0] Di_out;
    output reg[4:0] Rw_out;
    // 控制信号
    output reg MemWr_out, Branch_out, Jump_out, MemtoReg_out, RegWr_out;

    always @(negedge clk) begin
        Btarg_out <= Btarg;
        Jtarg_out <= Jtarg;
        Zero_out <= Zero;
        Overflow_out <= Overflow;
        Addr_out <= ALUout;
        Di_out <= DataIn;
        Rw_out <= Rw;

        MemWr_out <= MemWr;
        Branch_out <= Branch;
        Jump_out <= Jump;
        MemtoReg_out <= MemtoReg;
        RegWr_out <= RegWr;
    end
endmodule