// Forwarding Unit

module forwarding (input logic [4:0] ID_EXRegRn, ID_EXRegRm, EX_MEMRegRd, MEM_WBRegRd,
						 input logic EX_MEMregWrite, MEM_WBregWrite,
						 output logic [1:0] forwardA, forwardB);
	
	always_comb begin
		forwardA = 2'b00;
		forwardB = 2'b00;
	
		// EX hazard
		if (EX_MEMregWrite && (EX_MEMRegRd != 31)
			 && (EX_MEMRegRd == ID_EXRegRn))
			 forwardA = 2'b10;
			 
		if (EX_MEMregWrite && (EX_MEMRegRd != 31)
			 && (EX_MEMRegRd == ID_EXRegRm))
			 forwardB = 2'b10;
			 
		// MEM hazard
		if (MEM_WBregWrite && (MEM_WBRegRd != 31)
			 && (EX_MEMregWrite == 0 || ((EX_MEMRegRd != 31)
					&& (EX_MEMRegRd != ID_EXRegRn)))
			 && (MEM_WBRegRd == ID_EXRegRn))
			 forwardA = 2'b01;
		
		if (MEM_WBregWrite && (MEM_WBRegRd != 31)
			 && (EX_MEMregWrite == 0 || ((EX_MEMRegRd != 31)
					&& (EX_MEMRegRd != ID_EXRegRm)))
		 && (MEM_WBRegRd == ID_EXRegRm))
			forwardB = 2'b01;
	end
						 
endmodule