/*
	50MHz clock to 1Hz clock
	
	not tested
*/
module One_hertz_module(CLK_50M, RST, CLK_1);

	input CLK_50M, RST;
	output reg CLK_1;
	
	reg [27:0] counter;
	
	initial counter <= 0;

	always@(posedge CLK_50M or negedge RST) begin
		if (~RST) begin
			counter <= 0;
			CLK_1 <= 0;
		end else begin
			counter <= counter + 1;
			if (counter == 25_000_000) begin
				counter <= 0;
				CLK_1 <= ~CLK_1;
			end
		end		
	end
	
endmodule