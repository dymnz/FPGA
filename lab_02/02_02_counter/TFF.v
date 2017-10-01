/*
	T-FF Positive edge
	
	test passed
*/
module TFF_async (CLK, RST, T, Q);
	input CLK, T, RST;
	output reg Q;
	
	initial Q = 1'b0;
	
	always @(posedge CLK or negedge RST) begin
		if (~RST) begin
			Q <= 1'b0;
		end else if (T) begin
			Q <= ~Q;
		end
	end
	
endmodule


//////////////////////////////////

module TFF_async_tb ();
	reg CLK, RST, T;
	wire Q;
	
	TFF_async DUT (
		.CLK(CLK),
		.RST(RST),
		.T(T),
		.Q(Q)
	);
		
	initial begin	
		CLK = 0;
		forever begin
			# 20 CLK = ~CLK;
		end
	end
	
	initial begin 
		RST = 1;
		#40 RST = 0;
		#45 RST = 1;
		#10 RST = 0;
		#20  RST = 1;
	end 
	initial begin
		T = 0;
		#10 T = 1;
		#20 T = 0;
		#5  T = 1;
		#10 T = 0;
		#5  T = 1;
		#5  T = 0;
		#5  T = 1;
		#5  T = 0;
		#15 T = 1;
		#5  T = 0;
		#5  T = 1;
		#25 T = 0;		
		#99 $finish;
	end

endmodule