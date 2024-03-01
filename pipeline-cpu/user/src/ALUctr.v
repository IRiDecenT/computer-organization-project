module ALUctr(
    input [5:0] func,
    output reg[2:0] ALUctr
);

always @(*) begin
    case(func)
        6'b100000: ALUctr = 3'b001; // add
        6'b100010: ALUctr = 3'b101; // sub
        6'b100011: ALUctr = 3'b100; // subu
        6'b101010: ALUctr = 3'b111; // slt
        6'b101011: ALUctr = 3'b110; // sltu
    endcase
end
endmodule