module View 
	#(parameter WIDTH = 8)
	(SEL_PROD, SEL_AB, A, B, C, D, PROD,
		HEX0, HEX1, HEX2, HEX3);
		
	input SEL_PROD, SEL_AB;			// Select product or ABCD / Select AB or CD
	input [WIDTH-1:0]	A, B, C, D;
	input [2*WIDTH-1:0] PROD;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire [3:0] hex_input_list [4];	// Control these to control display
	
	assign hex_input_list[0] = 
		{4{SEL_PROD}}	&	PROD[3:0] |
		{4{~SEL_PROD}}	&	({4{~SEL_AB}}&B[3:0] | {4{SEL_AB}}&D[3:0]);
	assign hex_input_list[1] = 
		{4{SEL_PROD}}	&	PROD[7:4] |
		{4{~SEL_PROD}}	&	({4{~SEL_AB}}&B[7:4] | {4{SEL_AB}}&D[7:4]);		
	assign hex_input_list[2] = 
		{4{SEL_PROD}}	&	PROD[11:8] |
		{4{~SEL_PROD}}	&	({4{~SEL_AB}}&A[3:0] | {4{SEL_AB}}&C[3:0]);				
	assign hex_input_list[3] = 
		{4{SEL_PROD}}	&	PROD[15:12] |
		{4{~SEL_PROD}}	&	({4{~SEL_AB}}&A[7:4] | {4{SEL_AB}}&C[7:4]);	
	
	Hex_7seg hex0(hex_input_list[0], HEX0);
	Hex_7seg hex1(hex_input_list[1], HEX1);
	Hex_7seg hex2(hex_input_list[2], HEX2);
	Hex_7seg hex3(hex_input_list[3], HEX3);
	
								
endmodule