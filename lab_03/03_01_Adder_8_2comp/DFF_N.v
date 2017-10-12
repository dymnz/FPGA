/*
	N-bit D-FF posedge clk, negedge rst
*/

module DFF_N module counter #(parameter WIDTH = 8) (CLK, RST, D, Q)

	input CLK, RST;
	input [WIDTH-1:0] D;
	output [WIDTH-1:0] Q;
	
	always @ (posedge CLK, negedge RST) begin
		if (~RST) begin
			Q <= 0;
		end else begin
			Q <= D;
		end			
	end
	
endmodule