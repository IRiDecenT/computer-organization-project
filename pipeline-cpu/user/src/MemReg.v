module MemReg(clk, Overflow, MemData, ALUData, Rw, MemData_out, ALUData_out, Rw_out, Overflow_out, MemtoReg_out, RegWr_out, MemtoReg, RegWr);
    input clk;
    input Overflow;
    input[31:0] MemData, ALUData;
    input[4:0] Rw;
    // 控制信号
    input MemtoReg, RegWr;

    output reg[31:0] MemData_out, ALUData_out;
    output reg[4:0] Rw_out;
    output reg Overflow_out;
    output reg MemtoReg_out, RegWr_out;

    always @(negedge clk) begin
        MemData_out <= MemData;
        ALUData_out <= ALUData;
        Rw_out <= Rw;
        Overflow_out <= Overflow;
        MemtoReg_out <= MemtoReg;
        RegWr_out <= RegWr;
    end

endmodule