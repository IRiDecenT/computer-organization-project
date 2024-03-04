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
        if(curAddr > 4)begin
            curAddr = nextAddr;
        end
        else begin
            curAddr = curAddr + 1;
        end
        #20 $display("PC: %d", curAddr);
    end
endmodule



