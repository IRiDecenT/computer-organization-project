module PC(
    input clk,
    input[29:0] nextAddr,
    output reg[29:0] curAddr
);
    // initial begin
    //     curAddr <= 0;
    // end
    always @(negedge clk) begin
        curAddr = nextAddr;
    end
endmodule



