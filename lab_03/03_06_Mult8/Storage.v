module Storage 
	#(parameter WIDTH = 8)
	(CLK, RST, WRITE_ENB, SEL_AB, SEL_A, 
		DATA, A, B, C, D);
	
	input CLK, RST, WRITE_ENB, SEL_AB, SEL_A;
	input [WIDTH-1:0] DATA;
	output [WIDTH-1:0] A, B, C, D;
	
	wire enable_list [3:0]; // Enable for ABCD, respectively
	
	assign enable_list[0] = WRITE_ENB	&	~SEL_AB	&	~SEL_A; 	// A
	assign enable_list[1] = WRITE_ENB	&	~SEL_AB	&	SEL_A;	// B
	assign enable_list[2] = WRITE_ENB	&	SEL_AB	&	~SEL_A;	// C
	assign enable_list[3] = WRITE_ENB	&	SEL_AB	&	SEL_A;	// D
	
	DFF_N #(.WIDTH(WIDTH)) DFF_A (enable_list[0], RST, DATA, A);
	DFF_N #(.WIDTH(WIDTH)) DFF_B (enable_list[1], RST, DATA, B);
	DFF_N #(.WIDTH(WIDTH)) DFF_C (enable_list[2], RST, DATA, C);
	DFF_N #(.WIDTH(WIDTH)) DFF_D (enable_list[3], RST, DATA, D);
	
endmodule
	
	
		