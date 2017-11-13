/*
	N-bit D-FF posedge clk, negedge rst
*/

module DFF_N #(parameter WIDTH = 8) (CLK, RST, D, Q);

	input CLK, RST;
	input [WIDTH-1:0] D;
	output reg [WIDTH-1:0] Q;
	
	initial Q = 0;
		
	always @ (posedge CLK, negedge RST) begin
		if (~RST) begin
			Q <= 0;
		end else begin
			Q <= D;
		end			
	end
	
endmodule