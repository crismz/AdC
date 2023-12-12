// mem_forwarding

module mem_forwarding (input logic [4:0] EX_MEMRegRd, MEM_WBRegRd,
							 input logic memToReg,
							 output logic forward);
	
	always_comb begin
		forward = 0;

		if (memToReg && (MEM_WBRegRd != 31)
			 && (MEM_WBRegRd == EX_MEMRegRd))
			 forward = 1;
	end
						 
endmodule