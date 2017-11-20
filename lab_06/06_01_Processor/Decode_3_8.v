module Decode_3_8 (ENB, original, extended);

	input ENB;
	input [2:0] original;
	output reg [7:0] extended;	// [0:7] on instruction?
	
	always@(ENB or original) begin
		if (ENB == 1'b1) begin
			extended	= 8'b00000001 << original;
		end else begin
			extended = 8'b00000000;
		end		
	end

endmodule