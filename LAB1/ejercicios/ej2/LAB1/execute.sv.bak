// EXECUTE

module execute #(parameter N = 64)
					(input logic AluSrc,
					 input logic mov,
					 input logic [3:0] AluControl,
					 input logic [N-1:0] PC_E,
					 input logic [N-1:0] signImm_E,
					 input logic [N-1:0] readData1_E,
					 input logic [N-1:0] readData2_E,
					 output logic [N-1:0] PCBranch_E,
					 output logic [N-1:0] aluResult_E,
					 output logic [N-1:0] writeData_E,
					 output logic zero_E);
	
	logic [N-1:0] sht, muxe, muxi; 
	
	sl2 shift(signImm_E, sht);
	adder add(PC_E, sht, PCBranch_E);
	
	mux2 mxi(readData1_E, signImm_E, mov, muxi);
	mux2 mx(readData2_E, signImm_E, AluSrc, muxe);
	alu al(muxi, muxe, AluControl, aluResult_E, zero_E);
	
	assign writeData_E = readData2_E;
					 
					 
endmodule