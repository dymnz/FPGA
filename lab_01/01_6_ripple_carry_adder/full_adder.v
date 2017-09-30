/*
	one-bit full adder
	
	test passed
*/

module full_adder(A, B, Ci, S, Co);
	input A, B, Ci;
	output S, Co;
	
	wire AxB = (A^B);
	
	assign S = AxB^Ci;
	assign Co = (AxB&Ci) | (A&B);
	
endmodule

//////////////////////////////////////////

module full_adder_tb();
	reg [2:0] ABCi;
	wire S, Co;
	
	full_adder DUT (
		.A(ABCi[2]),
		.B(ABCi[1]),
		.Ci(ABCi[0]),
		.S(S),
		.Co(Co)
	);
	
	initial begin
		ABCi = 0;
		repeat (7) begin
			#10
			if ( {Co, S} != ABCi[2] + ABCi[1] + ABCi[0]) begin
				$display("Error %h", ABCi);
			end
			ABCi = ABCi + 1;
		end
		$finish;
	end

endmodule	
	
	