/*
	CLK: CARRY of Second_module
	RST: posedge reset
	COUNT_SET: COUNT to change to when resetting
	COUNT: 0 ~ 59
	CARRY: 0 -> 1 when COUNT 59 -> 0

	not tested
*/
module Minute_module (CLK, COUNT_SET, RST, COUNT, CARRY);

	input CLK, RST;
	input [5:0] COUNT_SET;
	output reg CARRY;
	output reg [5:0] COUNT;
	
	initial CARRY = 0;
	initial COUNT = 0;
	
	always @ (posedge CLK or posedge RST) begin
		if (RST) begin
			COUNT <= COUNT_SET;
		end else if (COUNT == 0) begin
			COUNT <= COUNT + 1;
			CARRY <= 0;
		end else if (COUNT < 59) begin
			COUNT <= COUNT + 1;
		end else if (COUNT == 59) begin
			COUNT <= 0;
			CARRY <= 1;
		end		
	end
endmodule