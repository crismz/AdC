// MAINDEC

module maindec (input logic [10:0] Op,
					 output logic Reg2Loc,
					 output logic ALUSrc,
					 output logic MemtoReg,
					 output logic RegWrite,
					 output logic MemRead,
					 output logic MemWrite,
					 output logic Branch,
					 output logic [1:0] ALUOp,
					 output logic mov);
					 
		always_comb 
		casez(Op)
				11'b111_1100_0010: begin	// LDUR
					Reg2Loc = 0; ALUSrc = 1; MemtoReg = 1;
					RegWrite= 1; MemRead = 1; MemWrite = 0;
					Branch = 0; ALUOp = 2'b00; mov = 0;
				end
				11'b111_1100_0000: begin	// STUR
					Reg2Loc = 1; ALUSrc = 1; MemtoReg = 0;
					RegWrite= 0; MemRead = 0; MemWrite = 1;
					Branch = 0; ALUOp = 2'b00; mov = 0;
				end
				11'b101_1010_0???: begin	// CBZ
					Reg2Loc = 1; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 0; MemRead = 0; MemWrite = 0;
					Branch = 1; ALUOp = 2'b01; mov = 0;
				end
				11'b100_0101_1000: begin	// ADD
					Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 1; MemRead = 0; MemWrite = 0;
					Branch = 0; ALUOp = 2'b10; mov = 0;
				end
				11'b110_0101_1000: begin	// SUB
					Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 1; MemRead = 0; MemWrite = 0;
					Branch = 0; ALUOp = 2'b10; mov = 0;
				end
				11'b100_0101_0000: begin	// AND
					Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 1; MemRead = 0; MemWrite = 0;
					Branch = 0; ALUOp = 2'b10; mov = 0;
				end
				11'b101_0101_0000: begin	// ORR
					Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 1; MemRead = 0; MemWrite = 0;
					Branch = 0; ALUOp = 2'b10; mov = 0;
				end
				11'b110_1001_01??: begin	//MOVZ
					Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
					RegWrite= 1; MemRead = 0; MemWrite = 0;
					Branch = 0; ALUOp = 2'b11; mov = 1;
				end
			default: begin
				Reg2Loc = 0; ALUSrc = 0; MemtoReg = 0;
				RegWrite= 0; MemRead = 0; MemWrite = 0;
				Branch = 0; ALUOp = 2'b00; mov = 0;
			end
		endcase
endmodule