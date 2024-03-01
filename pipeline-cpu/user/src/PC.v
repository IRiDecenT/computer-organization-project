`timescale 1ns/1ps
module PC(
    input clk,
    input[29:0] nextAddr,
    output reg[29:0] curAddr
);
    initial begin
        curAddr <= 0;
    end
    always @(negedge clk) begin
        curAddr = nextAddr;
        #20 $display("PC: %d", curAddr);
    end
endmodule



