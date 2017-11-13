module Processor (Din, RST, CLK, RUN_SIG, DONE_SIG, Bus);
	parameter DATA_WIDTH = 8;
	parameter REG_COUNT = 8;
	
	input [DATA_WIDTH-1:0] Din;
	input RST, CLK, RUN_SIG;
	output DONE_SIG;
	output [DATA_WIDTH-1:0] Bus;

////////////////////////////////////////////////////////////////////////	
	
	wire [1:0] time_step_count, operation;
	wire [2:0] operand[1:0];
	wire [7:0] instruction, operand_reg[1:0];
		
	// Register[7:0]
	wire [REG_COUNT-1:0] register_enable_list;
	wire [DATA_WIDTH-1:0] register_data_list[REG_COUNT-1:0];
	
	// Register A and G
	wire regA_ENB, regG_ENB;
	wire [DATA_WIDTH-1:0] regA_data_in, regA_data_out,
								 regG_data_in, regG_data_out;
								 
	// Add-Sub
	wire ADD_SUB_SIG;
	wire [DATA_WIDTH-1:0] add_sub_A, add_sub_B, add_sub_out;								 
////////////////////////////////////////////////////////////////////////


				
	
	// Time step counter
	Up_counter time_step (CLR, CLK, time_step_count);
	
	// IR register
	Register_N #(.WIDTH(8)) reg_IR (IR_ENB, CLK, Din, instruction);
	
	// Parsing instruction
	assign operation = instruction[7:6];
	assign operand[1] = instruction[5:3];
	assign operand[0] = instruction[2:0];
	
	// Decoding argument
	Decode_3_8 dec_arg_0 (1'b1, operand[0], operand_reg[0]);
	Decode_3_8 dec_arg_1 (1'b1, operand[1], operand_reg[1]);
	
	// Generate register[7:0]
	generate
	genvar i;
		for (i = 0; i < REG_COUNT; i = i + 1) begin : register_array
			Register_N #(.WIDTH(DATA_COUNT)) register_inst (
				register_enable_list[i], 
				CLK, 
				Bus, 
				register_data_list[i]);
		end
	endgenerate
	
	// Register A and G
	Register_N #(.WIDTH(DATA_COUNT)) register_A (
				regA_ENB, 
				CLK, 
				regA_data_in, 
				regA_data_out);	
	Register_N #(.WIDTH(DATA_COUNT)) register_G (
				regG_ENB, 
				CLK, 
				regG_data_in, 
				regG_data_out);	
				
	// Add-Sub
	LPM_add_sub_8 add_sub_inst (
		ADD_SUB_SIG, 
		add_sub_A, 
		add_sub_B, 
		add_sub_out);
		
////////////////////////////////////////////////////////////////////////		
	always@(time_step_count, operand_reg[0], operand_reg[1]) begin
		
		
	end


endmodule