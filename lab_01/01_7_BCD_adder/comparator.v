/*
	If IN[3:0] > 10, OUT = 1; o.w OUT = 0
	
	test passed
*/

module comparator(IN, OUT);

	input [3:0] IN;
	output OUT;
	
	assign OUT = IN[3]&IN[2] | IN[3]&IN[1];
	
endmodule


////////////////////////////////////////

module comparator_tb();

	reg [3:0] IN = 4'b0;
	wire OUT;
	
	comparator DUT (
		.IN(IN),
		.OUT(OUT)		
	);
		
	initial begin		
		repeat (16) begin
			#10
			if (IN < 10 && OUT != 0) begin
				$display("Error <10");
			end else if (IN >= 10 && OUT != 1) begin
				$display("Error >10");
			end
			IN = IN + 1;
		end	
		$finish;
	end
	
endmodule	
	
	

