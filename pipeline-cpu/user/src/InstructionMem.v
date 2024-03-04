module InstructionMem(
    input [31:0] InsAddr,
    output reg [31:0] InsData
    );

    reg [7:0] rom[1023:0];

    initial begin
        $readmemh("/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/data/Instruction.txt", rom);
    end
    // 大端方式
    always @(InsAddr) begin
        InsData[7:0] = rom[InsAddr+3];
        InsData[15:8] = rom[InsAddr+2];
        InsData[23:16] = rom[InsAddr+1];
        InsData[31:24] = rom[InsAddr];
    end

endmodule
