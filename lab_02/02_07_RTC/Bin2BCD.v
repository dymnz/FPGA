/*
	Binary to two digit BCD
*/
module Bin2BCD(BIN, BCD_0, BCD_1);
	input [5:0] BIN;
	output [3:0] BCD_0, BCD_1;
	
	assign BCD_0 = BIN % 10;
	assign BCD_1 = BIN / 10;

endmodule




module Bin2BCD_tb();
	reg [5:0] BIN;
	wire [3:0] BCD_0, BCD_1; 
	
	Bin2BCD DUT (BIN, BCD_0, BCD_1);
	
	initial begin
	#10
		BIN = 11;
	#10
		BIN = 33;
	#10 
		BIN = 59;
	#10 
		$finish;
	end

endmodule