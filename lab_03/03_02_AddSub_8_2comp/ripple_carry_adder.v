/*
	var-length ripple carry adder
	
	test passed
*/
module ripple_carry_adder #(parameter WIDTH = 8) (A, B, CI, S, CO);

	input CI;
	input [WIDTH-1:0] A, B;
	output CO;
	output [WIDTH-1:0] S;
	
	wire [WIDTH-1:0] CO_wire;

	assign CO = CO_wire[WIDTH-1];
		
	full_adder full_adder_LSB (
	  .A(A[0]),
	  .B(B[0]),
	  .CI(CI),
	  .S(S[0]),
	  .CO(CO_wire[0])
	);
	
	genvar i;
	generate
		for (i=1; i<WIDTH; i=i+1) begin : full_adder_array // <-- example block name
			full_adder full_adder_inst (
			  .A(A[i]),
			  .B(B[i]),
			  .CI(CO_wire[i-1]),
			  .S(S[i]),
			  .CO(CO_wire[i])
			);
		end
	endgenerate

endmodule	

//////////////////////////////////
module ripple_carry_adder_tb();

	reg CI;
	reg [3:0] A, B;
	
	wire CO;
	wire [3:0] S;
	
	ripple_carry_adder #(.WIDTH(4)) DUT (
		.A(A), 
		.B(B), 
		.CI(CI), 
		.S(S), 
		.CO(CO)
	);
	
	initial begin
		A = 0;
		B = 0;
		CI = 0;
	end
	
	initial begin
		repeat (15) begin
			B = 0;
			repeat (15) begin
				CI = 1'b0;
				#10
				if ({CO, S} != A + B + CI) begin
					$display("%h + %h + %h != %h:%h", 
						A, B, CI, S, CO);
				end				
				CI = 1'b1;
				#10
				if ({CO, S} != A + B + CI) begin
					$display("%h + %h + %h != %h:%h", 
						A, B, CI, S, CO);
				end
				B = B + 1;
			end
			A = A + 1;
		end
		$finish;
	end
	

endmodule
