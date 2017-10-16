module Adder_8_LPM (A, B, SUM, OVER_FLAG);

	input [7:0] A, B;
	output OVER_FLAG;
	output [7:0] SUM;
	
	LPM_Add8 add_1 (A, B, OVER_FLAG, SUM);
endmodule

