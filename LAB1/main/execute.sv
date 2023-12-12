// EXECUTE

module execute #(parameter N = 64)
					(input logic AluSrc,
					 input logic mov, EX_MEMregWrite, MEM_WBregWrite,
					 input logic [4:0] ID_EXRegRn, ID_EXRegRm, EX_MEMRegRd, MEM_WBRegRd,
					 input logic [3:0] AluControl,
					 input logic [N-1:0] EX_MEMResult, memoryResult,
					 input logic [N-1:0] PC_E,
					 input logic [N-1:0] signImm_E,
					 input logic [N-1:0] readData1_E,
					 input logic [N-1:0] readData2_E,
					 output logic [N-1:0] PCBranch_E,
					 output logic [N-1:0] aluResult_E,
					 output logic [N-1:0] writeData_E,
					 output logic zero_E);
	
	logic [1:0] forwardA, forwardB;
	logic [N-1:0] sht, muxe, muxi, muxfA, muxfB; 
	
	sl2 shift(signImm_E, sht);
	adder add(PC_E, sht, PCBranch_E);
	
	// Forwarding 
	forwarding fw(ID_EXRegRn, ID_EXRegRm, EX_MEMRegRd, MEM_WBRegRd,
					  EX_MEMregWrite, MEM_WBregWrite,
					  forwardA, forwardB);
	
	mux4 mxfA(readData1_E, memoryResult, EX_MEMResult, 64'b0, forwardA, muxfA);
	mux4 mxfB(readData2_E, memoryResult, EX_MEMResult, 64'b0, forwardB, muxfB);
	
	mux2 mxi(muxfA, signImm_E, mov, muxi);
	mux2 mx(muxfB, signImm_E, AluSrc, muxe);
	alu al(muxi, muxe, AluControl, aluResult_E, zero_E);
	
	assign writeData_E = muxfB;
	
					 
endmodule