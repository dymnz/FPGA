/*
	FLAG = 1 if A + B = S + CO is overflowed
*/
module Overflow_check #(parameter WIDTH = 8) (A, B, S, CO, FLAG);
	
	input CO;
	input [WIDTH-1:0] A, B, S;
	output FLAG;
	
	assign FLAG = 
				(A[WIDTH-1] & B[WIDTH-1] & ~S[WIDTH-1]) |		// NEG + NEG = POS
				(~A[WIDTH-1] & ~B[WIDTH-1] & S[WIDTH-1]) |	// POS + POS = NEG
				CO;	// Carry = Overflow
endmodule


module Overflow_check_tb();
	reg CO;
	reg [3:0] A, B, S;
	wire FLAG;
	
	Overflow_check #(.WIDTH(4)) DUT (A, B, S, CO, FLAG);
	
	initial begin
	CO = 0;
	A = 0;
	B = 0; 
	S = 0;
	end
	
	initial begin		
		repeat (16) begin
			repeat (16) begin
				{CO, S} = A + B;
				#10
				B = B + 1;
			end
			A = A + 1;
		end
	end

endmodule