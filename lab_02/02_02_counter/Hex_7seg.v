module Hex_7seg (SW, HEX);
	input [3:0] SW;
	output [6:0] HEX;

	reg [6:0] wHEX;

	assign HEX = wHEX;

	always @ (SW) begin
		case (SW)
			0 : wHEX = 7'b1000000;
			1 : wHEX = 7'b1111001;
			2 : wHEX = 7'b0100100;
			3 : wHEX = 7'b0110000;
			4 : wHEX = 7'b0011001;
			5 : wHEX = 7'b0010010;
			6 : wHEX = 7'b0000010;
			7 : wHEX = 7'b1111000;
			8 : wHEX = 7'b0000000;
			9 : wHEX = 7'b0010000;
			10: wHEX = 7'b0001000;
			11: wHEX = 7'b0000000;
			12: wHEX = 7'b1000110;
			13: wHEX = 7'b1000000;
			14: wHEX = 7'b0000110;
			15: wHEX = 7'b0001110;
			default : wHEX = 7'b1111111;
		endcase
	end
endmodule
