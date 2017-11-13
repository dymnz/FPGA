module Count_32 (CLK, RST, COUNT);

	input CLK, RST;
	output reg [4:0] COUNT;
	
	initial COUNT = 0;
	
	always @ (posedge CLK or posedge RST) begin
		if (RST) begin
			COUNT <= 0;
		end else if (COUNT < 32) begin
			COUNT <= COUNT + 1;
		end else if (COUNT == 32) begin
			COUNT <= 0;
		end		
	end
endmodule
