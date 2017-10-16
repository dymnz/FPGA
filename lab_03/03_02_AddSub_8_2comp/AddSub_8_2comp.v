module AddSub_8_2comp (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	input [9:0] SW;
	input [1:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	
	wire [7:0] DFF_A, DFF_B, S, DFF_S, DATA, transformed_B;
	wire DFF_A_enable, DFF_B_enable, 
			RST, CLK, CO, 
			overflow_flag, overflow_DFF,
			to_transform_b;
	
	assign RST = KEY[0];
	assign CLK = ~KEY[1];	
	assign DFF_A_enable = CLK & ~SW[8];
	assign DFF_B_enable = CLK & SW[8];
	assign DATA = SW[7:0];
	assign to_transform_b = SW[9];
	assign LEDR[7:0] = DFF_S;
	assign LEDR[8] = overflow_DFF;
	
	
	// XOR if performing subtraction
	assign transformed_B = {8{to_transform_b}} ^ DFF_B;
		
	// Storage for A
	DFF_N #(.WIDTH(8)) D_A(DFF_A_enable, RST, DATA, DFF_A);	
	
	// Storage for B
	DFF_N #(.WIDTH(8)) D_B(DFF_B_enable, RST, DATA, DFF_B);
	
	// Storage for S
	DFF_N #(.WIDTH(8)) D_S(CLK, RST, S, DFF_S);
	
	// Storage for Overflow
	DFF_N #(.WIDTH(1)) D_O(CLK, RST, overflow_flag, overflow_DFF);
	
	// Hex display A
	Hex_7seg hex_4(DFF_A[3:0], HEX4);	
	Hex_7seg hex_5(DFF_A[7:4], HEX5);
	
	// Hex display B
	Hex_7seg hex_2(DFF_B[3:0], HEX2);
	Hex_7seg hex_3(DFF_B[7:4], HEX3);
	
	// Hex display S
	Hex_7seg hex_0(DFF_S[3:0], HEX0);
	Hex_7seg hex_1(DFF_S[7:4], HEX1);
	
	// Ripple carry adder
	ripple_carry_adder #(.WIDTH(8)) adder (DFF_A, transformed_B, to_transform_b, S, CO);
	
	// Overflow checker
	Overflow_check #(.WIDTH(8)) (DFF_A, transformed_B, S, CO, overflow_flag);
	

endmodule
