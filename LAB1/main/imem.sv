// IMEM

module imem #(parameter N = 32)
				(input logic [6:0] addr,
				 output logic [N-1:0] q);
	logic [N-1:0] ROM [0:127];
	
	initial begin
		ROM ='{32'hf8000001,
				32'hf8008002,
				32'hf8000203,
				32'h8b050083,
				32'hf8018003,
				32'hcb050083,
				32'hf8020003,
				32'hcb0a03e4,
				32'hf8028004,
				32'h8b040064,
				32'hf8030004,
				32'hcb030025,
				32'hf8038005,
				32'h8a1f0145,
				32'hf8040005,
				32'h8a030145,
				32'hf8048005,
				32'h8a140294,
				32'hf8050014,
				32'hd2b579aa,
				32'hf80d000a,
				32'haa1f0166,
				32'hf8058006,
				32'haa030166,
				32'hf8060006,
				32'hd2d7d7ca,
				32'hf80d800a,
				32'hf840000c,
				32'h8b1f0187,
				32'hf8068007,
				32'hf807000c,
				32'h8b0e01bf,
				32'hf807801f,
				32'hb40000a0,
				32'h8b1f03fd,
				32'h8b1f03fd,
				32'h8b1f03fd,
				32'hf8080015,
				32'hf8088015,
				32'h8b0103e2,
				32'hcb010042,
				32'h8b0103f8,
				32'hf8090018,
				32'h8b080000,
				32'hb4ffff82,
				32'h8b1f03fd,
				32'h8b1f03fd,
				32'h8b1f03fd,
				32'hf809001e,
				32'h8b1e03de,
				32'hcb1503f5,
				32'h8b1403de,
				32'hf85f83d9,
				32'h8b1e03de,
				32'h8b1003de,
				32'hf81f83d9,
				32'hd29fffea,
				32'hf80a000a,
				32'hd2b95fca,
				32'hf80a800a,
				32'hd2d8194a,
				32'hf80b000a,
				32'hd2e0000a,
				32'hf80b800a,
				32'hb400001f,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0};
	end

	assign q = ROM[addr];
	
endmodule