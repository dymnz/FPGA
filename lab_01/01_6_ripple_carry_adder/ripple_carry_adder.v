/*
	var-length ripple carry adder
*/
module ripple_carry_adder #(parameter WIDTH = 4) (A, B, Ci, S, Co);

	input Ci;
	input [WIDTH-1:0] A, B;
	output Co;
	output [WIDTH-1:0] S;
	
	wire [WIDTH-1:0] Co;

	genvar i;
	generate
		full_adder full_adder_LSB (
		  .A(A[0]),
		  .B(B[0]),
		  .Ci(Ci),
		  .S(S[0]),
		  .Co(Co[0])
		);
		for (i=1; i<WIDTH; i=i+1) begin : full_adder_array // <-- example block name
			full_adder full_adder_inst (
			  .A(A[i]),
			  .B(B[i]),
			  .Ci(Co[i-1]),
			  .S(S[i]),
			  .Co(Co[i])
			);
		end
	endgenerate

endmodule	