// Sign extended

module signext (input logic [31:0] a,
					 output logic [63:0] y);
					 
	always_comb 
		casez(a[31:21])
			11'b111_1100_0010: y = {{55{a[20]}}, a[20:12]};
			11'b111_1100_0000: y = {{55{a[20]}}, a[20:12]};
			11'b101_1010_0???: y = {{45{a[23]}}, a[23:5]};
			11'b110_1001_01??: casez(a[22:21])
										2'b00: y = {48'd0, a[20:5]};
										2'b01: y = {32'd0, a[20:5], 16'd0};
										2'b10: y = {16'd0, a[20:5], 32'd0};
										2'b11: y = {a[20:5], 48'd0};
									 endcase
			default: y = {64{1'b0}};
		endcase
	
endmodule