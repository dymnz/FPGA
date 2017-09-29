/*
	If V[3:0] > 10, Z = 1; o.w Z = 0
	
	test passed
*/

module comparator(V, Z);

	input [3:0] V;
	output Z;
	
	assign Z = V[3]&V[2] | V[3]&V[1];
	
endmodule


////////////////////////////////////////

module comparator_tb();

	reg [3:0] V = 4'b0;
	wire Z;
	
	comparator DUT (
		.V(V),
		.Z(Z)		
	);
		
	initial begin		
		for (V = 0; V < 16; V = V + 1) begin
			#10
			if (V < 10 && Z != 0) begin
				$display("Error <10");
			end else if (V >= 10 && Z != 1) begin
				$display("Error >10");
			end
		end	
		$finish;
	end
	
endmodule	
	
	

