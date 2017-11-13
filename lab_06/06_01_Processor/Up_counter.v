module Up_counter (CLR, CLK, COUNT);

	input CLR, CLK;
	output reg [1:0] COUNT;
	
	initial COUNT = 2'b0;
	
	always@(posedge CLK) begin
		if (CLR) begin
			COUNT <= 2'b0;
		end else begin
			COUNT <= COUNT + 2'b01;
		end	
	end

endmodule