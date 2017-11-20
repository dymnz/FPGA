module Multiplxer (
	din, 					// Input, data in
	f_register_data_out_list,	// Input, flattened register[] data
	reg_G_data_out,			// Input, register G data

	register_mux_sel_list, // Input, register[] select
	DIN_MUX_SEL, G_MUX_SEL,	REG_MUX_SEL, // Input, Din/G/REG select

	bus						// Output, bus
	);

	parameter DATA_WIDTH = 8;
	parameter REG_COUNT = 8;
	parameter REG_COUNT_BIT_WIDTH = 3;	// 2^3 = 8

	input [DATA_WIDTH-1:0] din;
	input [DATA_WIDTH*REG_COUNT-1:0] f_register_data_out_list;	
	input [REG_COUNT_BIT_WIDTH-1:0] reg_G_data_out;

	input [REG_COUNT-1:0] register_mux_sel_list;
	input DIN_MUX_SEL, G_MUX_SEL, REG_MUX_SEL;

	output reg [DATA_WIDTH-1:0] bus;

	reg [DATA_WIDTH-1:0] register_data_out_list[REG_COUNT-1:0];
	
	integer i;
	always @* begin
	for (i = 0; i < REG_COUNT; i = i + 1)
		register_data_out_list[i] = f_register_data_out_list[DATA_WIDTH*i +: DATA_WIDTH];
	end

	always @(
			register_mux_sel_list, 
			DIN_MUX_SEL, 
			G_MUX_SEL,
			REG_MUX_SEL, 
			din, reg_G_data_out) begin
		if (REG_MUX_SEL) begin
			bus = register_data_out_list[register_mux_sel_list];
		end else if (DIN_MUX_SEL) begin
			bus = din;				
		end else if (G_MUX_SEL) begin
			bus = reg_G_data_out;
		end else begin
			bus = din;
		end
	end
endmodule