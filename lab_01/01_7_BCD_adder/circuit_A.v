 /*
	Control the dataflow to the lower digit 7seg

	input: 
		V - Lower 3 bit of the SW[3:0] (i.e. SW[2:0])
	output:
		M - Lower 3 bit of the input_1 of Mux(2:0)
		
	test passed
*/

module circuit_A(V, M);

	input [2:0] V;
	output [2:0] M;
	
	assign M[0] = V[0];
	assign M[1] = V[2]&~V[1];
	assign M[2] = V[2]&V[1];
	
endmodule	

//////////////////////////////////////////

module circuit_A_tb();

	reg [2:0] V;
	wire [2:0] M;
	
	circuit_A DUT(
		.V(V),
		.M(M)
	);
	
	
	initial begin
		V = 3'b010;
		#10
		if (M != 3'b000) begin
			$display("3'b010 error");
		end		
		
		V = 3'b011;
		#10
		if (M != 3'b001) begin
			$display("3'b011 error");
		end		
		
		V = 3'b100;
		#10
		if (M != 3'b010) begin
			$display("3'b100 error");
		end		
		
		V = 3'b101;
		#10
		if (M != 3'b011) begin
			$display("3'b101 error");
		end		
		
		V = 3'b110;
		#10
		if (M != 3'b100) begin
			$display("3'b110 error");
		end		
		
		V = 3'b111;
		#10
		if (M != 3'b101) begin
			$display("3'b111 error");
		end		

		$finish;
	end
	
endmodule

