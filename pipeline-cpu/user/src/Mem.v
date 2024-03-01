module Mem(clk, RA, WA, Di, Do, MemWr);
    input clk;
    input [31:0] RA, WA;
    input [31:0] Di;
    output reg [31:0] Do;
    input MemWr;
    // 定义一个256个元素的内存数组，每个元素是一个8位宽的寄存器
    (* ram_style = "distributed" *) reg [7:0] mem [255:0];

initial
begin
    $readmemh("/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/data/data.txt", mem);
end

always @ (posedge clk) begin
    if(MemWr == 1) begin
        {mem[WA + 3], mem[WA + 2], mem[WA + 1], mem[WA]} <= Di;
        $display("mem[%d] <= %h", WA, Di);
    end
    Do <= {mem[RA + 3], mem[RA + 2], mem[RA + 1], mem[RA]};
end


endmodule