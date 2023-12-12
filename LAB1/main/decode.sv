// Etapa: DECODE

module decode #(parameter N = 64)
					(input logic regWrite_D, reg2loc_D, clk, ID_EXMemRead,
					input logic [N-1:0] writeData3_D,
					input logic [31:0] instr_D,
					input logic [4:0] wa3_D, ID_EXRegRd,
					output logic [N-1:0] signImm_D, readData1_D, readData2_D, 
					output logic [4:0] registerRn, registerRm,
					output logic PCWrite, IF_IDWrite, muxControl);
					
	logic [4:0] ra2;			
	
	mux2 	#(5) 	ra2mux	(.d0(instr_D[20:16]), .d1(instr_D[4:0]), .s(reg2loc_D), .y(ra2));
	
	regfile 		registers(.clk(clk), .we3(regWrite_D), .ra1(instr_D[9:5]), .ra2(ra2), .wa3(wa3_D), 
								 .wd3(writeData3_D), .rd1(readData1_D), .rd2(readData2_D));
									
	signext 		ext		(.a(instr_D), .y(signImm_D));	
	
	assign registerRn = instr_D[9:5];
	assign registerRm = ra2;
	
	hazard_detection hazard (.ID_EXMemRead(ID_EXMemRead), .IF_IDRegRn(registerRn), 
									 .IF_IDRegRm(registerRm), .ID_EXRegRd(ID_EXRegRd), 
									 .PCWrite(PCWrite), .IF_IDWrite(IF_IDWrite), .muxControl(muxControl));
	
endmodule
