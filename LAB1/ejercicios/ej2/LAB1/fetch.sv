// FETCH

module fetch #(parameter N = 64)
				 (input logic PCSrc_F,
				  input logic clk,
				  input logic reset,
				  input logic PCWrite,
				  input logic [63:0] PCBranch_F,
				  output logic [63:0] imem_addr_F);
	
	logic [63:0] y, z;
	
	initial begin
		imem_addr_F = 0;
	end
		
	adder add(imem_addr_F, 64'd_4, y);
	mux2 muux(y, PCBranch_F, PCSrc_F, z);
	flopr_e flop_e(clk, reset, PCWrite, z, imem_addr_F);

			
endmodule	