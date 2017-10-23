module FSM8 (SW, KEY, LEDR);

	input [9:0] SW;
	input [3:0] KEY;
	output[9:0] LEDR;

	wire RST, CLK, IN, OUT, ONE;
	wire [8:0] state; // State = oDFF
	wire [8:0] iDFF_list;	// Input of DFF
	
	assign ONE = 1'b1;
	assign RST = SW[0];	
	assign CLK = KEY[0];
	
	assign IN = SW[1];
	assign LEDR[9] = OUT;
	assign LEDR[8:0] = state;
		
	// State table
	parameter 
		A = 9'b000000001,
		B = 9'b000000010,		
		C = 9'b000000100,
		D = 9'b000001000,
		E = 9'b000010000,
		F = 9'b000100000,
		G = 9'b001000000,
		H = 9'b010000000,
		I = 9'b100000000;			
		
	assign OUT = (state==E) | (state==I);
			
	// RST = 0, reset to state A
	assign iDFF_list[0] = ~RST;
	
	// IN == 0, BCDE
	assign iDFF_list[1] = RST & ~IN & 							
		((state==A)|(state==F)|(state==G)|(state==H)|(state==I));	// B	
	assign iDFF_list[2] = RST & ~IN & (state==B); 			// C	
	assign iDFF_list[3] = RST & ~IN & (state==C);			// D
	assign iDFF_list[4] = RST & ~IN & 							
		((state==D)|(state==E)); 									// E
	
	// IN == 1, FGHI
	assign iDFF_list[5] = RST & IN &  							
		((state==A)|(state==B)|(state==C)|(state==D)|(state==E));	// F	
	assign iDFF_list[6] = RST & IN & (state==F); 			// G
	assign iDFF_list[7] = RST & IN & (state==G); 			// H
	assign iDFF_list[8] = RST & IN & 							
		((state==H)|(state==I));									// I
	
	
	genvar i;
	generate
		for (i = 0; i < 9; i = i + 1) begin : DFF_list
			DFF_N #(.WIDTH(1)) DFF1 (CLK, ONE, iDFF_list[i], state[i]);
		end
	endgenerate
	
	
		
endmodule		