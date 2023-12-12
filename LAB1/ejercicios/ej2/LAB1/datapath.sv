// DATAPATH

module datapath #(parameter N = 64)
					(input logic reset, clk,
					input logic reg2loc,									
					input logic AluSrc,
					input logic [3:0] AluControl,
					input logic	Branch,
					input logic memRead,
					input logic memWrite,
					input logic regWrite,	
					input logic memtoReg,
					input logic mov,
					input logic [31:0] IM_readData,
					input logic [N-1:0] DM_readData,
					output logic [N-1:0] IM_addr, DM_addr, DM_writeData,
					output logic DM_writeEnable, DM_readEnable, IF_IDWrite);					
					
	logic PCSrc;
	logic [N-1:0] PCBranch_E, aluResult_E, writeData_E, writeData3; 
	logic [N-1:0] signImm_D, readData1_D, readData2_D;
	logic [4:0] registerRn, registerRm;
	logic [10:0] ID_EXControl;
	logic zero_E;
	logic [95:0] qIF_ID;
	logic [281:0] qID_EX;
	logic [202:0] qEX_MEM;
	logic [134:0] qMEM_WB;
	logic forwardMem, PCWrite, muxControl;
	
	fetch 	#(64) 	FETCH 	(.PCSrc_F(PCSrc),
										.clk(clk),
										.reset(reset),
										.PCWrite(PCWrite),
										.PCBranch_F(qEX_MEM[197:134]),
										.imem_addr_F(IM_addr));								
					
	
	flopr_e 	#(96)		IF_ID 	(.clk(clk),
										.reset(reset), 
										.enable(IF_IDWrite),
										.d({IM_addr, IM_readData}),
										.q(qIF_ID));
										
	
	decode 	#(64) 	DECODE 	(.regWrite_D(qMEM_WB[134]),
										.reg2loc_D(reg2loc), 
										.clk(clk),
										.writeData3_D(writeData3),
										.instr_D(qIF_ID[31:0]), 
										.signImm_D(signImm_D), 
										.readData1_D(readData1_D),
										.readData2_D(readData2_D),
										.wa3_D(qMEM_WB[4:0]),
										.registerRn(registerRn),
										.registerRm(registerRm),
										.ID_EXMemRead(qID_EX[264]),
										.ID_EXRegRd(qID_EX[4:0]),
										.PCWrite(PCWrite),
										.IF_IDWrite(IF_IDWrite),
										.muxControl(muxControl));				
	
	mux2		#(11)	   muxHazard(.d0(11'b0), 
										 .d1({mov, AluSrc, AluControl, Branch, memRead, 
												memWrite, regWrite, memtoReg}), 
										 .s(muxControl),
										 .y(ID_EXControl));
									
	flopr 	#(282)	ID_EX 	(.clk(clk),
										.reset(reset), 
										.d({registerRm, registerRn, ID_EXControl, 
											qIF_ID[95:32], signImm_D, readData1_D, 
											readData2_D, qIF_ID[4:0]}),
										.q(qID_EX));	
	
										
	execute 	#(64) 	EXECUTE 	(.AluSrc(qID_EX[270]),
										.mov(qID_EX[271]),
										.AluControl(qID_EX[269:266]),
										.PC_E(qID_EX[260:197]), 
										.signImm_E(qID_EX[196:133]), 
										.readData1_E(qID_EX[132:69]), 
										.readData2_E(qID_EX[68:5]), 
										.PCBranch_E(PCBranch_E), 
										.aluResult_E(aluResult_E), 
										.writeData_E(writeData_E), 
										.zero_E(zero_E),
										.EX_MEMregWrite(qEX_MEM[199]),
										.MEM_WBregWrite(qMEM_WB[134]),
										.ID_EXRegRn(qID_EX[276:272]), 
										.ID_EXRegRm(qID_EX[281:277]), 
										.EX_MEMRegRd(qEX_MEM[4:0]), 
										.MEM_WBRegRd(qMEM_WB[4:0]),
										.EX_MEMResult(qEX_MEM[132:69]),
										.memoryResult(writeData3));											
											
									
	flopr 	#(203)	EX_MEM 	(.clk(clk),
										.reset(reset), 
										.d({qID_EX[265:261], PCBranch_E, zero_E, aluResult_E, writeData_E, qID_EX[4:0]}),
										.q(qEX_MEM));	

	
	memory				MEMORY	(.Branch_M(qEX_MEM[202]), 
										.zero_M(qEX_MEM[133]), 
										.PCSrc_M(PCSrc));
	
	mem_forwarding 	MEM_FORWARDING (.EX_MEMRegRd(qEX_MEM[4:0]), 
												 .MEM_WBRegRd(qMEM_WB[4:0]),
												 .memToReg(qMEM_WB[133]),
												 .forward(forwardMem));
	
	// Salida de señales a Data Memory
	mux2 mux_mem(qEX_MEM[68:5], writeData3, forwardMem, DM_writeData);
	assign DM_addr = qEX_MEM[132:69];
	
	// Salida de señales de control:
	assign DM_writeEnable = qEX_MEM[200];
	assign DM_readEnable = qEX_MEM[201];
	
	flopr 	#(135)	MEM_WB 	(.clk(clk),
										.reset(reset), 
										.d({qEX_MEM[199:198], qEX_MEM[132:69],	DM_readData, qEX_MEM[4:0]}),
										.q(qMEM_WB));
		
	
	writeback #(64) 	WRITEBACK (.aluResult_W(qMEM_WB[132:69]), 
										.DM_readData_W(qMEM_WB[68:5]), 
										.memtoReg(qMEM_WB[133]), 
										.writeData3_W(writeData3));		
		
endmodule
