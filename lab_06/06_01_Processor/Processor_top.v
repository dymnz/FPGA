module Processor_top (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire RUN_SIG, DONE_SIG, RSTn, M_CLK, P_CLK;
	wire [7:0] din, REG0, REG1, bus;
	
	wire [4:0] address;
		
	assign RUN_SIG = SW[9];
	assign RSTn = KEY[0];
	assign M_CLK = KEY[1];
	assign P_CLK = KEY[2];
	
	assign LEDR[9] = DONE_SIG;
	assign LEDR[7:0] = bus;
	
	
	
	Board_Processor BP_0 (din, RSTn, P_CLK, RUN_SIG, DONE_SIG, REG0, REG1, bus);
	
	Count_32 count_0 (M_CLK, RSTn, address);
	
	LPM_ROM_8 ROM_0(address, M_CLK, din);
	
	Hex_7seg HEX_0 (REG0[3:0], HEX0);
	Hex_7seg HEX_1 (REG0[7:4], HEX1);
	
	Hex_7seg HEX_2 (REG1[3:0], HEX2);
	Hex_7seg HEX_3 (REG1[7:4], HEX3);
	
	Hex_7seg HEX_4 (din[3:0], HEX4);
	Hex_7seg HEX_5 (din[7:4], HEX5);
	
endmodule