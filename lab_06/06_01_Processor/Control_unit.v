module Control_Unit (
	RSTn, RUN_SIG, 							// Input, misc
	instruction, 							// Input, instruction
	time_step_count, 						// Input, time-step counter

	IR_ENB,									// Output, IR register enable

	DIN_MUX_SEL, G_MUX_SEL, 				// Output, mux
	REG_MUX_SEL,								// Output, reg mux enable
	register_mux_sel_list, 					// Output, reg mux select

	ADD_SUB_SIG,							// Output, add or sub selection
	TIME_STEP_CLR,							// Output, time-step counter

	register_enable_list,					// Output, register enables
	REG_A_ENB, REG_G_ENB,					// Output, register enables

	DONE_SIG								// Output, misc
	);
	
	parameter DATA_WIDTH = 8;
	parameter REG_COUNT = 8;
	parameter REG_COUNT_BIT_WIDTH = 3;	// 2^3 = 8
	parameter INSTRUCTION_LENGTH = 8;

		
	input RSTn, RUN_SIG;
	input [INSTRUCTION_LENGTH-1:0] instruction;
	input [1:0] time_step_count;

	output reg IR_ENB;

	output reg DIN_MUX_SEL, G_MUX_SEL, REG_MUX_SEL;
	output reg [REG_COUNT_BIT_WIDTH-1:0] register_mux_sel_list;	// Mux->Bus data sel

	output reg ADD_SUB_SIG;
	output reg TIME_STEP_CLR;

	output reg [REG_COUNT-1:0] register_enable_list;
	output reg REG_A_ENB, REG_G_ENB;

	output reg DONE_SIG;
////////////////////////////////////////////////////////////////////////	
	
	wire [1:0] operation;
	wire [REG_COUNT_BIT_WIDTH-1:0] operand[1:0];
	wire [REG_COUNT-1:0] operand_enable[1:0];
		
////////////////////////////////////////////////////////////////////////

	parameter 
		MOV = 2'b00,
		MOVI = 2'b01,
		ADD = 2'b10,
		SUB = 2'b11;

	// PPPXXXYYY
	assign operation = instruction[7:6];	// PPP
	assign operand[1] = instruction[5:3];	// XXX
	assign operand[0] = instruction[2:0];	// YYY

	Decode_3_8 dec_arg_0 (1'b1, operand[0], operand_enable[0]);
	Decode_3_8 dec_arg_1 (1'b1, operand[1], operand_enable[1]);

	initial begin
		IR_ENB = 0;
		DIN_MUX_SEL = 0;
		G_MUX_SEL = 0;
		register_mux_sel_list = 0;
		ADD_SUB_SIG = 1;
		register_enable_list = 0;
		REG_A_ENB = 0;
		REG_G_ENB = 0;
		DONE_SIG = 0;
		TIME_STEP_CLR = 0;
	end

	always @(
			RSTn, RUN_SIG,			
			time_step_count, 
			instruction, 
			operand) begin
	if (~RSTn) begin
		TIME_STEP_CLR = 1;
	end else if (RUN_SIG) begin
		TIME_STEP_CLR = 0;
	end else begin	
		IR_ENB = 0;
		DIN_MUX_SEL = 0;
		G_MUX_SEL = 0;
		register_mux_sel_list = 0;
		ADD_SUB_SIG = 1;
		register_enable_list = 0;
		REG_A_ENB = 0;
		REG_G_ENB = 0;
		TIME_STEP_CLR = 0;
		DONE_SIG = 0;	

		case (time_step_count)
		2'b00: begin
			IR_ENB = 1;
		end
		2'b01: begin
			case (operation)
			MOV: begin
				REG_MUX_SEL = 1;
				register_mux_sel_list = operand[0];
				register_enable_list = operand_enable[1];

				DONE_SIG = 1;
				TIME_STEP_CLR = 1;
			end
			MOVI: begin
				DIN_MUX_SEL = 1;
				register_enable_list = operand_enable[1];

				DONE_SIG = 1;
				TIME_STEP_CLR = 1;
			end
			ADD: begin
				REG_MUX_SEL = 1;
				register_mux_sel_list = operand[1];
				REG_A_ENB = 1;
			end
			SUB: begin
				REG_MUX_SEL = 1;
				register_mux_sel_list = operand[1];
				REG_A_ENB = 1;
			end
			endcase
		end

		2'b10: begin
			case (operation)
			ADD: begin
				REG_MUX_SEL = 1;
				register_mux_sel_list = operand[0];
				REG_G_ENB = 1;				
			end
			SUB: begin
				REG_MUX_SEL = 1;
				register_mux_sel_list = operand[1];
				REG_G_ENB = 1;
				ADD_SUB_SIG = 0;
			end
			default: begin
				;
			end
			endcase
		end

		2'b11: begin
			case (operation)
			ADD: begin
				G_MUX_SEL = 1;
				register_enable_list = operand_enable[1];				
			end
			SUB: begin
				G_MUX_SEL = 1;
				register_enable_list = operand_enable[1];
			end
			default: begin
				;
			end
			endcase
		end
		endcase
	end
	end


endmodule