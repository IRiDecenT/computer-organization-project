`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/PC.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/IUnit.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/IFReg.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/InstructionDecode.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/RFile.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/IDReg.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/ExecUnit.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/EXReg.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/Mem.v"
`include "/Users/yr/code/computer-organization/computer-organization-project/pipeline-cpu/user/src/MemReg.v"
module PipeLineCPU(input clk);

    // PC
    reg [29:0] nextAddr;
    wire [29:0] 	curAddr;

    // IUnit
    wire [29:0] 	B;
    wire [3:0] 	    J;
    wire [31:0] 	instruction;

    // IFReg
    wire [29:0] 	B_out_IF;
    wire [29:0] 	    Jtarg;
    wire [31:0] 	instruction_out;

    // InstructionDecode
    wire RegWr, ALUSrc, RegDst, MemtoReg, MemWr, branch, Jump, ExtOp, rtype;
    wire[2:0] ALUOp;

    // RFile
    // outports wire
    wire[31:0] busA, busB;

    // IDReg
    wire [29:0] 	B_out_ID;
    wire [29:0] 	Jtarg_out_ID;
    wire [5:0]  	func_out;
    wire [15:0] 	imm16_out;
    wire [31:0] 	busA_out;
    wire [31:0] 	busB_out;
    wire [4:0]  	Rt_out;
    wire [4:0]  	Rd_out;
    wire RegWr_out_ID, ALUSrc_out_ID, RegDst_out_ID, MemtoReg_out_ID, MemWr_out_ID, branch_out_ID, Jump_out_ID, ExtOp_out_ID, rtype_out_ID;
    wire [2:0]     ALUOp_out_ID;

    // ExecUnit
    wire [29:0] 	Btarg;
    wire        	Zero;
    wire        	Overflow;
    wire [31:0] 	ALUout;

    // EXReg
    wire [29:0] 	Btarg_out;
    wire [29:0] 	Jtarg_out;
    wire        	Zero_out;
    wire        	Overflow_out;
    wire [31:0] 	Addr_out;
    wire [31:0] 	Di_out;
    wire [4:0]       	Rw_out;
    wire MemWr_out_EX, Branch_out_EX, Jump_out_EX, MemtoReg_out_EX, RegWr_out_EX;

    // MemReg
    wire [31:0] 	MemData_out;
    wire [31:0] 	ALUData_out;
    wire [4:0]      Rw_out_Mem;
    wire        	Overflow_out_Mem;
    wire MemtoReg_out_Mem, RegWr_out_Mem;


    // initial begin
    //     nextAddr = 0;
    // end
    PC u_PC(
           .clk      	( clk       ),
           //.nextAddr 	( (Zero_out && Branch_out_EX || Jump_out_EX)? (Branch_out_EX ? Btarg_out : Jtarg_out) : B ),
           .nextAddr 	( B ),
           .curAddr  	( curAddr   )
       );

    IUnit u_IUnit(
              .PC             (curAddr),
              .B              (B),
              .J              (J),
              .instruction    (instruction)
          );

    IFReg u_IFReg(
              .clk(clk),
              .B(B),
              .J(J),
              .instruction(instruction),
              .B_out(B_out_IF),
              .Jtarg(Jtarg),
              .instruction_out(instruction_out)
          );

    wire[5:0] op = instruction_out[31:26];
    wire[5:0] func = instruction_out[5:0];
    wire[15:0] imm16 = instruction_out[15:0];
    wire[4:0] Rs = instruction_out[25:21];
    wire[4:0] Rt = instruction_out[20:16];
    wire[4:0] Rd = instruction_out[15:11];


    InstructionDecode u_InstructionDecode(
                          .op(op),
                          .RegWr(RegWr),
                          .ALUSrc(ALUSrc),
                          .RegDst(RegDst),
                          .MemtoReg(MemtoReg),
                          .MemWr(MemWr),
                          .branch(branch),
                          .Jump(Jump),
                          .ExtOp(ExtOp),
                          .ALUOp(ALUOp),
                          .rtype(rtype)
                      );

    RFile u_RFile(
              .Ra(Rs),
              .Rb(Rt),
              .Rw(Rw_out_Mem),
              .Di(MemtoReg_out_Mem ? MemData_out : ALUData_out),
              .WE(~Overflow_out_Mem && RegWr_out_Mem),
              .busA(busA),
              .busB(busB),
              .clk(clk)
          );

    IDReg u_IDReg(
              .clk       	( clk           ),
              .B         	( B_out_IF      ),
              .Jtarg     	( Jtarg         ),
              .func      	( func          ),
              .imm16     	( imm16         ),
              .busA      	( busA          ),
              .busB      	( busB          ),
              .Rt        	( Rt            ),
              .Rd        	( Rd            ),
              .B_out     	( B_out_ID      ),
              .Jtarg_out 	( Jtarg_out_ID  ),
              .func_out  	( func_out      ),
              .imm16_out 	( imm16_out     ),
              .busA_out  	( busA_out      ),
              .busB_out  	( busB_out      ),
              .Rt_out    	( Rt_out        ),
              .Rd_out    	( Rd_out        ),
              .RegWr        ( RegWr),
              .ALUSrc       (ALUSrc),
              .RegDst       (RegDst),
              .MemtoReg     (MemtoReg),
              .MemWr        (MemWr),
              .branch       (branch),
              .Jump         (Jump),
              .ExtOp        (ExtOp),
              .rtype        (rtype),
              .ALUOp        (ALUOp),
              .RegWr_out    (RegWr_out_ID),
              .ALUSrc_out   (ALUSrc_out_ID),
              .RegDst_out   ( RegDst_out_ID),
              .MemtoReg_out ( MemtoReg_out_ID),
              .MemWr_out    ( MemWr_out_ID),
              .branch_out   ( branch_out_ID),
              .Jump_out     ( Jump_out_ID),
              .ExtOp_out    ( ExtOp_out_ID),
              .ALUOp_out    ( ALUOp_out_ID),
              .rtype_out    ( rtype_out_ID)
          );


    ExecUnit u_ExecUnit(
                 .B(B_out_ID),
                 .busA(busA_out),
                 .busB(busB_out),
                 .imm16(imm16_out),
                 .func(func_out),
                 .ExtOp(ExtOp_out_ID),
                 .ALUSrc(ALUSrc_out_ID),
                 .ALUop( ALUOp_out_ID),
                 .Rtype( rtype_out_ID),
                 .Btarg(Btarg),
                 .Zero(Zero),
                 .Overflow(Overflow),
                 .ALUout(ALUout)
             );

    EXReg u_EXReg(
              .clk          	( clk           ),
              .Btarg        	( Btarg         ),
              .Jtarg        	( Jtarg_out_ID         ),
              .Zero         	( Zero          ),
              .Overflow     	( Overflow      ),
              .ALUout       	( ALUout        ),
              .DataIn       	( busB_out      ),
              .Rw           	( RegDst_out_ID ? Rd_out : Rt_out ),
              .Btarg_out    	( Btarg_out     ),
              .Jtarg_out    	( Jtarg_out     ),
              .Zero_out     	( Zero_out      ),
              .Overflow_out 	( Overflow_out  ),
              .Addr_out     	( Addr_out      ),
              .Di_out       	( Di_out        ),
              .Rw_out       	( Rw_out        ),
              .MemWr          ( MemWr_out_ID),
              .Branch         ( branch_out_ID),
              .Jump           ( Jump_out_ID),
              .MemtoReg       ( MemtoReg_out_ID),
              .RegWr          ( RegWr_out_ID),
              .MemWr_out      ( MemWr_out_EX),
              .Branch_out     ( Branch_out_EX),
              .Jump_out       ( Jump_out_EX),
              .MemtoReg_out   ( MemtoReg_out_EX),
              .RegWr_out      ( RegWr_out_EX)
          );

    // outports wire
    wire [31:0] 	Do;
    Mem u_Mem(
            .clk  	( clk           ),
            .RA    	( Addr_out     ),
            .WA    	( Addr_out     ),
            .Di    	( Di_out     ),
            .Do    	( Do     ),
            .MemWr 	( MemWr_out_EX     )
        );

    MemReg u_MemReg(
        .clk          	( clk           ),
        .Overflow     	( Overflow_out      ),
        .MemData      	( Do       ),
        .ALUData      	( Addr_out       ),
        .Rw           	( Rw_out            ),
        .MemData_out  	( MemData_out   ),
        .ALUData_out  	( ALUData_out   ),
        .Rw_out       	( Rw_out_Mem        ),
        .Overflow_out 	( Overflow_out_Mem  ),
        .MemtoReg     	( MemtoReg_out_EX),
        .RegWr        	( RegWr_out_EX),
        .MemtoReg_out 	( MemtoReg_out_Mem),
        .RegWr_out    	( RegWr_out_Mem)
    );
endmodule
