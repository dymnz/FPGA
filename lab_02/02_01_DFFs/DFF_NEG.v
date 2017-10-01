/*
	D-FF Negative edge
	
	test passed
*/

module DFF_NEG (CLK, D, Q);
	input CLK, D;
	output reg Q;
	
	initial Q = 1'b0;
	
	always @ (negedge CLK) begin
		Q = D;		
	end
endmodule

////////////////////////////////////////

module DFF_NEG_tb();
	reg CLK, D;
	wire Q;
	
	DFF_NEG DUT(
		.CLK(CLK),
		.D(D),
		.Q(Q)
	);
	
	initial begin
		CLK = 0;
		#20 CLK = 1;
		#40 CLK = 0;		
		#30 CLK = 1;		
		#30 CLK = 0;	
	end
	
	initial begin
		D = 0;
		#10 D = 1;
		#20 D = 0;
		#5  D = 1;
		#10 D = 0;
		#20 D = 1;
		#5  D = 0;
		#5  D = 1;
		#5  D = 0;
		#15 D = 1;
		#5  D = 0;
		#5  D = 1;
		#25 D = 0;		
		#99 $finish;
	end
	
	
	
endmodule	