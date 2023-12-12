// Hazard detection unit

module hazard_detection (input logic ID_EXMemRead,
								 input logic [4:0] IF_IDRegRn, IF_IDRegRm, ID_EXRegRd,
								 output logic PCWrite, IF_IDWrite, muxControl);
	
	always_comb begin
		PCWrite = 1;
		IF_IDWrite = 1;
		muxControl = 1;
		
		if (ID_EXMemRead &&
			((ID_EXRegRd == IF_IDRegRn) || 
			(ID_EXRegRd == IF_IDRegRm))) begin
				PCWrite = 0;
				IF_IDWrite = 0;
				muxControl = 0;
		end
	end
			
endmodule