module Mult8 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);

	input [3:0] KEY;
	input [9:0] SW;
	
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire CLK, RST, WRITE_ENB, SEL_AB, SEL_A, SEL_PROD, carry;
	wire [7:0] DATA, A, B, C, D;
	wire [15:0] mult_AB, mult_CD, PROD;
	
	assign LEDR[9] = carry;
	assign RST = KEY[0];
	assign CLK = KEY[1];
	assign SEL_A = KEY[2];
	assign SEL_PROD = KEY[3];
	assign WRITE_ENB = SW[9];
	assign SEL_AB = SW[8];
	assign DATA = SW[7:0];
	
	Storage storage_inst
		(CLK, RST, WRITE_ENB, SEL_AB, SEL_A, 
		DATA, A, B, C, D);

	View view_inst
		(SEL_PROD, SEL_AB, A, B, C, D, PROD,
		HEX0, HEX1, HEX2, HEX3);
	
	LPM_mult8 mult_0 (A, B, mult_AB);
	LPM_mult8 mult_1 (C, D, mult_CD);
	
	LPM_add16 add_0 (mult_AB, mult_CD, carry, PROD);
		
endmodule