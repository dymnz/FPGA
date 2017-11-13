module Processor (Din, RST, CLK, RUN_SIG, DONE_SIG, Bus);

	input [7:0] Din;
	input RST, CLK, RUN_SIG;
	output DONE_SIG;
	output [7:0] Bus;
	
	wire [1:0] time_step_count, operation;
	wire [2:0] operand[1:0];
	wire [7:0] instruction;
	
	// Time step counter
	Up_counter time_step (CLR, CLK, time_step_count);
	
	// IR register
	Register_N #(.WIDTH(8)) reg_IR (IR_ENB, CLK, Din, instruction);
	
	// Parsing instruction
	assign operation = instruction[7:6];
	assign operand[1] = instruction[5:3];
	assign operand[0] = instruction[2:0];
	
	// Decoding argument
	module Decode_3_8 (ENB, original, extended);
	Decode_3_8 dec_arg_0 ()

endmodule