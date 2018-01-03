module Board_Processor (din, RSTn, CLK, RUN_SIG, DONE_SIG, REG0, REG1, bus);
	parameter DATA_WIDTH = 8;
	parameter REG_COUNT = 8;
	parameter REG_COUNT_BIT_WIDTH = 3;	// 2^3 = 8
	parameter INSTRUCTION_LENGTH = 8;
	
	
	input [DATA_WIDTH-1:0] din;
	input RSTn, CLK, RUN_SIG;
	output DONE_SIG;
	
	output [DATA_WIDTH-1:0] REG0, REG1;

//////////////// Control Unit ////////////////
	wire [INSTRUCTION_LENGTH-1:0] instruction;
	wire [1:0] time_step_count;

	wire IR_ENB;

	wire DIN_MUX_SEL, G_MUX_SEL, REG_MUX_SEL;
	wire [REG_COUNT_BIT_WIDTH-1:0] register_mux_sel_list;	// Mux->Bus data sel

	wire ADD_SUB_SIG;
	wire TIME_STEP_CLR;

	wire [REG_COUNT-1:0] register_enable_list;
	wire REG_A_ENB, REG_G_ENB;
//////////////// Add Sub ////////////////
	wire [DATA_WIDTH-1:0] add_sub_data_in_A, 
							add_sub_data_in_B, add_sub_data_out;		

//////////////// Register ////////////////
	wire [DATA_WIDTH-1:0] reg_A_data_in,reg_A_data_out,
							reg_G_data_in, reg_G_data_out;
	wire [DATA_WIDTH-1:0] register_data_in_list[REG_COUNT-1:0],
							register_data_out_list[REG_COUNT-1:0];

	// Flatten to pass
	wire [DATA_WIDTH*REG_COUNT-1:0] f_register_data_out_list;


//////////////// Misc ////////////////
	output [DATA_WIDTH-1:0] bus;

////////////////////////////////////////////////////////////////////////
	
	// For output
	assign REG0 = register_data_out_list[0];
	assign REG1 = register_data_out_list[1];
		
	// Register A/G connection
	assign reg_A_data_in = bus;

	// Register[] connection
	generate
		genvar i;
		for (i = 0; i < REG_COUNT; i = i + 1) begin : register_wire_list
			assign register_data_in_list[i] = bus;
		end
	endgenerate

	// Add/Sub connection
	assign add_sub_data_in_A = reg_A_data_out;
	assign add_sub_data_in_B = bus;
	assign reg_G_data_in = add_sub_data_out;


	// Time step counter
	Up_counter time_step (TIME_STEP_CLR, CLK, time_step_count);
	
	// IR register
	Register_N #(.WIDTH(8)) reg_IR (IR_ENB, CLK, din, instruction);
	
	generate
		for (i = 0; i < REG_COUNT; i = i + 1) begin : register_array
			Register_N #(.WIDTH(DATA_WIDTH)) register_inst (
				register_enable_list[i], 
				CLK, 
				register_data_in_list[i], 
				register_data_out_list[i]);
		end
	endgenerate
	
	Register_N #(.WIDTH(DATA_WIDTH)) register_A (
				REG_A_ENB, 
				CLK, 
				reg_A_data_in, 
				reg_A_data_out);	
	Register_N #(.WIDTH(DATA_WIDTH)) register_G (
				REG_G_ENB, 
				CLK, 
				reg_G_data_in, 
				reg_G_data_out);
				
	LPM_add_sub_8 add_sub_inst (
		ADD_SUB_SIG, 
		add_sub_data_in_A, 
		add_sub_data_in_B, 
		add_sub_data_out);

	generate for (i = 0; i < REG_COUNT; i = i + 1) begin : F_RDO
		assign f_register_data_out_list[DATA_WIDTH*i +: DATA_WIDTH] = 
			register_data_out_list[i]; 
	end endgenerate

	Multiplxer Mux_0 (
		din, 					// Input, data in
		f_register_data_out_list,	// Input, register[] data
		reg_G_data_out,			// Input, register G data

		register_mux_sel_list, // Input, register[] select
		DIN_MUX_SEL, G_MUX_SEL,	REG_MUX_SEL, // Input, Din/G/REG select

		bus						// Output, bus
	);

	Control_Unit CU_0 (
		RSTn, RUN_SIG, 							// Input, misc
		instruction, 							// Input, instruction
		time_step_count, 						// Input, time-step counter

		IR_ENB,									// Output, IR register enable

		DIN_MUX_SEL, G_MUX_SEL, 				// Output, mux
		REG_MUX_SEL,								// Output, reg mux enable
		register_mux_sel_list, 					// Output, mux	

		ADD_SUB_SIG,							// Output, add or sub selection
		TIME_STEP_CLR,							// Output, time-step counter

		register_enable_list,					// Output, register enables
		REG_A_ENB, REG_G_ENB,					// Output, register enables

		DONE_SIG								// Output, misc
		);

endmodule