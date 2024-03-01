module RFile(Ra, Rb, Rw, Di, WE, busA, busB, clk);
parameter n = 32;
input clk;
input wire[4:0] Ra, Rb, Rw;
input wire[n-1:0] Di;
input wire WE;
output reg[n-1:0] busA, busB;
// 32个32位寄存器
reg [31:0] mem [0:31];
// 初始化时将前四个寄存器的值设置为32'h0，
initial
    begin
        mem[0] <= 32'h0;
        mem[1] <= 32'h0;
        mem[2] <= 32'h0;
        mem[3] <= 32'h0;
    end
// // 在时钟信号的下降沿，如果Rw为1，则将输入数据总线的值写入到寄存器数组的Rw位置
// always @ (negedge Clock)
//     begin
//         if (RegWr == 1)begin
//             mem[Rw] <= busW;
//             $display("[DEBUG] write %h to reg%h", busW, Rw);
//         end
//     end
always @ (*)
    begin
        busA <= mem[Ra];
        busB <= mem[Rb];
        // if (WE == 1)begin
        //     mem[Rw] <= Di;
        //     $display("[DEBUG] write %h to reg%h", Di, Rw);
        // end
    end
// 实现寄存器前半个周期读,后半个周期写的问题
always @ (negedge clk) begin
        if (WE == 1)begin
            mem[Rw] <= Di;
            $display("[DEBUG] write %h to reg%h", Di, Rw);
        end
end
endmodule