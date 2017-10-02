/*
	Comprehensive test
	
	test passed
*/
module DFFs (CLK, D, Q);
	input CLK, D;
	output [2:0] Q;
	
	DFF_ENB DFF_0(
		.ENB(CLK),
		.D(D),
		.Q(Q[0])
	);
	
	DFF_POS DFF_1(
		.CLK(CLK),
		.D(D),
		.Q(Q[1])
	);
	
	DFF_NEG DFF_2(
		.CLK(CLK),
		.D(D),
		.Q(Q[2])
	);

endmodule


module DFFs_tb();

	reg CLK, D;
	wire [2:0] Q;

	DFFs DUT (
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
	    $dumpfile("wave.vcd");
    	$dumpvars;
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