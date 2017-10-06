/*
	CLK: posedge increment
	RST: posedge reset
	COUNT: 0 ~ 23
	CARRY: 0 -> 1 when COUNT 59 -> 0

	Can be used in second or minute part of the RTC

	test passed 
*/
module Hour_module (CLK, RST, COUNT, CARRY);

	input CLK, RST;
	output reg CARRY;
	output reg [5:0] COUNT;
	
	initial CARRY = 0;
	initial COUNT = 0;
	
	always @ (posedge CLK or posedge RST) begin
		if (RST) begin
			COUNT <= 0;
		end else if (COUNT == 0) begin
			COUNT <= COUNT + 1;
			CARRY <= 0;
		end else if (COUNT < 23) begin
			COUNT <= COUNT + 1;
		end else if (COUNT == 23) begin
			COUNT <= 0;
			CARRY <= 1;
		end		
	end
endmodule

////////////////////////////////////////////////

module Hour_module_tb ();
	reg CLK, RST;
	wire CARRY;
	wire [5:0] COUNT;
	
	Hour_module DUT (
		.CLK(CLK), 
		.RST(RST), 
		.COUNT(COUNT), 
		.CARRY(CARRY));
	
	initial begin	
		CLK = 0;
		forever begin
			#5	CLK = ~CLK;
		end
		#1000	$finish;
	end
	
	initial begin
		RST = 0;
		#100	RST = 1;
		#5 	RST = 0;
	end
	
	initial begin
		#1000	$finish;
	end
	
endmodule
	