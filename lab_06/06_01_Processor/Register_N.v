module Register_N #(parameter WIDTH = 8) (ENB, CLK, data_in, data_out);
	
	input ENB, CLK;
	input [WIDTH-1:0] data_in;	
	output reg [WIDTH-1:0] data_out;
	
	always@(posedge CLK)	begin
		if (ENB) begin
			data_out <= data_in;
		end
	end
	
endmodule