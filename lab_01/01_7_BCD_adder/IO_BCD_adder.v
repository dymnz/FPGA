/*
	BCD adder using all the IOs
	
	not tested
*/
module IO_BCD_adder(SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input [8:0] SW;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [3:0] A, B, Sum;
	wire [1:0] AB_over10;
	wire Cin;
	
	assign B = SW[3:0];
	assign A = SW[7:4];
	assign Cin = SW[8];
		
	// Light up LEDRs 
	assign LEDR[3:0] = B;
	assign LEDR[7:4] = A;
	
	// Show B on HEX10
	two_digit_7seg segB (
		.SW(B),
		.HEX0(HEX0), 
		.HEX1(HEX1));
		
	// Show A on HEX32
	two_digit_7seg segA (
		.SW(A),
		.HEX0(HEX3), 
		.HEX1(HEX2));	
	
	// Show >10 error
	comparator compB (
		.IN(B),
		.OUT(AB_over10[0])
	);
	comparator compA (
		.IN(A),
		.OUT(AB_over10[1])
	);
	assign LEDR[9] = AB_over10[1] | AB_over10[0];

	// Add A and B
	BCD_adder BCD (
		.A(A), 
		.B(B), 
		.Ci(Ci), 
		.Sum(Sum),
		.Co(Co));
	
	// Show the results		
	hex_decoder SegSum (
		.SW(Sum), 
		.HEX(HEX4));
		
	circuit_B SegCarry (
		.ENB(Co),
		.HEX(HEX5));	
		
endmodule

