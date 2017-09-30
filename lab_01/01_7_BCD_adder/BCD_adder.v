/*
	BCD adder
	
	test passed
*/
module BCD_adder(A, B, Ci, Sum, Co);
	
	input Ci;
	input [3:0] A, B;
	output Co;
	output [3:0] Sum;
	
	wire [3:0] Sum_1, Sum_2, Carry_adder_input;
	wire Ci, Co_1, Co_2, Sum_over10, Carry_adder_enable;
	
	// Add A and B
	ripple_carry_adder #(.WIDTH(4)) Adder1 (
		.A(A), 
		.B(B),
		.Ci(Ci), 
		.S(Sum_1), 
		.Co(Co_1));
	
	// Check if Sum_1 > 10
	comparator compSum (
		.IN(Sum_1),
		.OUT(Sum_over10)
	);
	
	assign Carry_adder_enable = Co_1 | Sum_over10;
	assign Carry_adder_input[0] = 1'b0;
	assign Carry_adder_input[1] = Carry_adder_enable;
	assign Carry_adder_input[2] = Carry_adder_enable;
	assign Carry_adder_input[3] = 1'b0;
	
	// Carry over adder
	ripple_carry_adder #(.WIDTH(4)) Adder2(
		// Expand Carry_adder_enable to 4'b0000 or 4'b0110
		.A(Carry_adder_input), 
		.B(Sum_1),
		.Ci(0), 
		.S(Sum_2), 
		.Co(Co_2));

	// Results
	assign Co = Carry_adder_enable;
	assign Sum = Sum_2;
		
endmodule

////////////////////////////////////////////////

module BCD_adder_tb();

	reg Ci;
	reg [3:0] A, B;
	wire Co;
	wire [3:0] Sum;
	
	BCD_adder DUT (
	.A(A), 
	.B(B), 
	.Ci(Ci), 
	.Sum(Sum), 
	.Co(Co));
	
	initial begin 
		A = 0;
		repeat (10) begin 
			B = 0;
			repeat (10) begin
				Ci = 0;
				repeat (2) begin
					#10
					if ( Co*10 + Sum != A + B + Ci ) begin
						$display("%h + %h + %h != %h : %h",
							A, B, Ci, Co, Sum);
					end
					Ci = Ci + 1;
				end			
				B = B + 1;
			end
			A = A + 1;
		end	
		$finish;
	end

endmodule