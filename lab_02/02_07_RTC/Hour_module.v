/*
	CLK: CARRY of Minute_module
	RST: posedge reset
	COUNT_SET: COUNT to change to when resetting
	COUNT: 0 ~ 23

	not tested
*/
module Hour_module (CLK, COUNT_SET, RST, COUNT);

	input CLK, RST;
	input [5:0] COUNT_SET;
	output reg [5:0] COUNT;
	
	initial COUNT = 0;
	
	always @ (posedge CLK or posedge RST) begin
		if (RST) begin
			COUNT <= COUNT_SET;
		end else if (COUNT < 24) begin
			COUNT <= COUNT + 1;
		end else if (COUNT == 24) begin
			COUNT <= 0;
		end		
	end
endmodule
