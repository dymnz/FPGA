module counter #(parameter WIDTH = 4) (CLK, RST, ENB, COUNT);

	input CLK, ENB;				// Counter clock and Counter enable
	input RST;		// Reset of TFF
	output [WIDTH-1:0] COUNT;	// Output of TFF

	// and(ENB[i], COUNT[i-1], ENB)
	// index 0 is not used
	wire [WIDTH-1:0] Indiviual_enable_list; 

	TFF_async TFF_0 (
		.CLK(CLK), 
		.RST(RST), 
		.T(ENB), 
		.Q(COUNT[0]));

	generate
		genvar i;
		for (i = 1; i < WIDTH; i = i +1) begin
			and And_array (Indiviual_enable_list[i], )
		end

		
	endgenerate


endmodule