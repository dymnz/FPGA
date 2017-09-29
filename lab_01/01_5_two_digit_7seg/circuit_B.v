/*
	Modified 7seg decoder. 
		Show 0 when ENB = 0
		Show 1 when ENB = 1
		
	test passed	
*/
module circuit_B(ENB, HEX);
	input	ENB;
	output [6:0] HEX;
	
	wire [3:0] V;

	assign V = 4'b0 | ENB;

	wire A = V[0];
	wire B = V[1];
	wire C = V[2];
	wire D = V[3];

	wire common = D&B | D&C;

	
	assign HEX[0] = common | C&~B&~A | ~D&~C&~B&A;
	assign HEX[1] = common | C&~B&A | C&B&~A;
	assign HEX[2] = common | ~C&B&~A;
	assign HEX[3] = common | C&~B&~A | C&B&A | ~D&~C&~B&A;
	assign HEX[4] = common | A | C&~B;
	assign HEX[5] = common | B&A | ~D&~C&A | ~C&B&~A;
	assign HEX[6] = common | ~D&~C&~B | C&B&A;

endmodule

//////////////////////////////////////////////////////////////////////


module circuit_B_tb();
 
	reg ENB;
	wire [6:0] HEX0;

	reg [6:0] t_HEX [0:16];
	
	initial begin 
		t_HEX[0] = 7'b1000000;
		t_HEX[1] = 7'b1111001;
	end
 
	circuit_B DUT(
		.ENB(ENB),
		.HEX(HEX0)
	);
		
	initial begin
		ENB = 1'b0;		
		#10
		if (HEX0 != t_HEX[ENB])
			$display("!!!! Test %d error %h:%h \n", ENB, HEX0, t_HEX[ENB]);		
		ENB = 1'b1;
		#10
		if (HEX0 != t_HEX[ENB])
			$display("!!!! Test %d error %h:%h \n", ENB, HEX0, t_HEX[ENB]);
	
		$finish;
	end	

	
endmodule
