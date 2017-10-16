/*
	N-bit paper-and-pencil multiplier with ripple carry adder
*/
module MultN #(parameter WIDTH = 8)(A, B, mult_result);
	
	input [WIDTH-1:0] A, B;
	output [2*WIDTH-1:0] mult_result;
	
	
	wire ZERO;
	assign ZERO = 1'b0;
	
	/*		
		4-bit multiplier		
		4-and-array x4: 
		4-ripple-carry-adder x3
	*/	
	wire [WIDTH-1:0] cat_array_out[WIDTH-1:0];	// Input_a for each adder
																// Concat. of last carry and sum[MSB:LSB+1]
	wire [WIDTH-1:0] and_array_out[WIDTH-1:0];	// Input_b for each adder
	wire [WIDTH-1:0] sum_array_out[WIDTH-1:0];	// Sum for each adder	
	wire carry_array_out[WIDTH-1:0];	// Carry for each adder
	
	genvar i;
		
	// Generate and_array_out	
	generate		
		for (i = 0; i < WIDTH; i = i + 1) begin : and_array
			assign and_array_out[i] = A & {WIDTH{B[i]}};		
		end		
	endgenerate
	
	// Connect and_array_out[0] to sum_array_out[0] for dummy input operation
	assign sum_array_out[0] = and_array_out[0];
	assign carry_array_out[0] = ZERO;
		
	// Generate the rest of sum_array_out with ripple carry adder
	generate		
		for (i = 1; i < WIDTH; i = i + 1) begin : sum_array
			assign cat_array_out[i] = {carry_array_out[i-1], sum_array_out[i-1][WIDTH-1:1]};
			
			ripple_carry_adder #(.WIDTH(WIDTH)) add_inst (
				.A(cat_array_out[i]), 
				.B(and_array_out[i]), 
				.CI(ZERO), 
				.S(sum_array_out[i]), 
				.CO(carry_array_out[i]));
		end		
	endgenerate
	
	/*
		Gather the multiplied result
	*/
	// Lower part [WIDTH-2:0], is the LSB of each sum_array_out
	generate		
		for (i = 0; i < WIDTH - 1; i = i + 1) begin : result_array
			assign mult_result[i] = sum_array_out[i][0];
		end		
	endgenerate	
	
	// Higher part [2*WIDTH-2:WIDTH-1], is sum_array_out[WIDTH-1] 
	assign mult_result[2*WIDTH-2:WIDTH-1] = sum_array_out[WIDTH-1];
	
	// MSB is the carry of the MSB of sum_array_out[WIDTH-1]
	assign mult_result[2*WIDTH-1] = carry_array_out[WIDTH-1];
		
endmodule


module MultN_tb #(parameter WIDTH = 8) ();
	reg [WIDTH-1:0] A, B;
	wire [2*WIDTH-1:0] mult_result;
	
	MultN #(.WIDTH(WIDTH)) DUT(A, B, mult_result);
	
	initial begin
		A = 0;
		B = 0;
		
		repeat (2**WIDTH) begin
			B = 0;
			repeat (2**WIDTH) begin
			#10
			if (mult_result != A * B) begin
				$display("%h * %h != %h", A, B, mult_result);
			end			
			B = B + 1;
			end		
			A = A + 1;
		end
		$finish;
	end
	
endmodule