`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/crtgenerator.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/adder32.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/extend32.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/mux2to1_1bit.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/mux2to1_32bit_01mux.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/mux3to1_32bit.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/or32.v"
`include "/Users/yr/code/computer-organization/computer-organization-labs/ALU/user/src/xor32.v"

module ALU(A, B, ALUctr, Zero, Overflow, Result);
	parameter n = 32;
	input [n-1:0] A;
	input [n-1:0] B;
	input [2:0] ALUctr;
	output [n-1:0] Result;
	//flags
	output Zero;
	output Overflow;
	// ctr signals
	wire SUBctr, OVctr, SIGctr;
	wire[1:0] OPctr;
	wire[n-1:0] SUBctr_ext;
	wire[n-1:0] B_to_add;
	wire Add_Carry, Add_Overflow, Add_Sign;
	wire[n-1:0]Add_Result;
	wire[n-1:0] mux3_op2;
	wire[n-1:0] mux3_op3;
	wire mux2_op1, mux2_op2;
	wire less;

	crtgenerator gen(.ALUctr(ALUctr), .SUBctr(SUBctr),
					 .OPctr(OPctr), .OVctr(OVctr), .SIGctr(SIGctr));

	extend32 extend(.SUBctr(SUBctr), .extend_out(SUBctr_ext));

	xor32 x(.operendA(B), .operendB(SUBctr_ext), .out(B_to_add));

	adder32 adder(.A(A), .B(B_to_add), .Cin(SUBctr),
			.Add_Carry(Add_Carry),
			.Add_Overflow(Add_Overflow),
			.Add_Sign(Add_Sign),
			.Add_Result(Add_Result), .Zero(Zero));

	and(Overflow, Add_Overflow, OVctr);

	xor(mux2_op1, SUBctr, Add_Carry);
	xor(mux2_op2, Add_Overflow, Add_Sign);

	mux2to1_1bit mux1(.choice1(mux2_op1), .choice2(mux2_op2),
					  .out(less), .sel(SIGctr));

	mux2to1_32bit_01mux mux2(.sel(less), .out(mux3_op3));

	or32 or_gate(.operendA(A), .operendB(B), .out(mux3_op2));

	mux3to1_32bit mux3(.choice1(Add_Result),
					   .choice2(mux3_op2),
					   .choice3(mux3_op3),
					   .out(Result), .sel(OPctr));
endmodule


