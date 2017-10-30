module LPM_RAM_Dual (CLOCK_50, SW, KEY, LEDR, HEX0, HEX2, HEX3);
	
	input CLOCK_50;
	input [9:0] SW;
	input [3:0] KEY;
	output[9:0] LEDR;
	output[6:0] HEX0, HEX2, HEX3;
	
	wire WRT_ENB, CLK_1, RAM_CLK, RST;
	wire [3:0] data_in, data_out;
	wire [4:0] wr_address, rd_address;
	
	assign RST = ~KEY[0];
	assign WRT_ENB = SW[9];	
	assign data_in = SW[7:4];
	assign wr_address = {SW[8], SW[3:0]};
	
	assign LEDR[9] = WRT_ENB;
	assign RAM_CLK = CLOCK_50;
	
	One_hertz_module one_hertz (CLOCK_50, RST, CLK_1);
	Count_32 count_0 (CLK_1, RST, rd_address);
	
	Hex_7seg hex_0 (data_out, HEX0);
	Hex_7seg hex_2 (rd_address[3:0], HEX2);
	Hex_7seg hex_3 ({3'b0, rd_address[4]}, HEX3);
	
	LPM_RAM ram_0 (RAM_CLK, data_in, rd_address, wr_address, WRT_ENB, data_out);

endmodule
	