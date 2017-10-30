module LPM_RAM_32_4 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
	
	input [9:0] SW;
	input [3:0] KEY;
	output[9:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire WRT_ENB, CLK;
	wire [3:0] data_in, data_out;
	wire [4:0] address;
	
	assign CLK = KEY[0];
	assign WRT_ENB = SW[9];	
	assign data_in = SW[3:0];
	assign address = SW[8:4];
	
	assign LEDR[9] = WRT_ENB;
	
	Hex_7seg hex_0 (data_out, HEX0);
	Hex_7seg hex_1 (data_in, HEX1);
	Hex_7seg hex_2 (address[3:0], HEX2);
	Hex_7seg hex_3 ({3'b0, address[4]}, HEX3);

	LPM_RAM ram_0(address, CLK, data_in, WRT_ENB, data_out);
	
endmodule
	