/*
	one-bit full adder
	
	test passed
*/

module full_adder(A, B, CI, S, CO);
	input A, B, CI;
	output S, CO;
	
	wire AxB = (A^B);
	
	assign S = AxB^CI;
	assign CO = (AxB&CI) | (A&B);
	
endmodule

//////////////////////////////////////////

module full_adder_tb();
	reg [2:0] ABCI;
	wire S, CO;
	
	full_adder DUT (
		.A(ABCI[2]),
		.B(ABCI[1]),
		.CI(ABCI[0]),
		.S(S),
		.CO(CO)
	);
	
	initial begin
		ABCI = 0;
		repeat (7) begin
			#10
			if ( {CO, S} != ABCI[2] + ABCI[1] + ABCI[0]) begin
				$display("Error %h", ABCI);
			end
			ABCI = ABCI + 1;
		end
		$finish;
	end

endmodule	
	
	