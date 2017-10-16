module IO_Mult4
	(SW, HEX0, HEX1, HEX4, HEX5);

	input [9:0] SW;
	output [6:0] HEX0, HEX1, HEX4, HEX5;
	
	wire [3:0] A, B;
	wire [7:0] mult_result;
	
	assign A = SW[7:4];
	assign B = SW[3:0];
	
	// Display A/B
	Hex_7seg hex_5(A, HEX5);
	Hex_7seg hex_4(B, HEX4);
	
	// Display mult_result
	Hex_7seg hex_1(mult_result[7:4], HEX1);
	Hex_7seg hex_0(mult_result[3:0], HEX0);
	
	// Multiplier
	MultN #(.WIDTH(4)) mult (A, B, mult_result);
endmodule	
	
	