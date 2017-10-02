module IO_counter_16 #(parameter WIDTH = 16)(SW, HEX0, HEX1, HEX2, HEX3);

	input [8:0] SW;
	output [6:0] HEX0, HEX1, HEX2, HEX3;

	wire [WIDTH-1:0] COUNT;
	wire RST = SW[0];
	wire ENB = SW[1];

	counter #(.WIDTH(WIDTH)) DUT (
		.CLK(CLK),
		.RST(RST),
		.ENB(ENB),
		.COUNT(COUNT));

	Hex_7seg SEG_0 (COUNT[3:0], HEX0);
	Hex_7seg SEG_1 (COUNT[7:4], HEX1);
	Hex_7seg SEG_2 (COUNT[11:8], HEX2);
	Hex_7seg SEG_3 (COUNT[15:12], HEX3);

endmodule