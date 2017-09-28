module hex_decoder(SW, HEX0);
	input	[3:0]	SW;
	output [6:0] HEX0;

	wire A = SW[0];
	wire B = SW[1];
	wire C = SW[2];
	wire D = SW[3];

	wire common = D&B | D&C;

	assign HEX0[0] = common | C&~B&~A | ~D&~C&~B&A;
	assign HEX0[1] = common | C&~B&A | C&B&~A;
	assign HEX0[2] = common | ~C&B&~A;
	assign HEX0[3] = common | C&~B&~A | C&B&A | ~D&~C&~B&A;
	assign HEX0[4] = common | A | C&~B;
	assign HEX0[5] = common | B&A | ~D&~C&A | ~C&B&~A;
	assign HEX0[6] = common | ~D&~C&~B | C&B&A;

endmodule

//////////////////////////////////////////////////////////////////////


module hex_decoder_tb();
 
	reg [3:0] SW;
	wire [6:0] HEX0;

	reg [6:0] t_HEX [0:16];
	
	initial begin 
		t_HEX[0] = 7'b1111111;
		t_HEX[1] = 7'b1000000;
		t_HEX[2] = 7'b1111001;
		t_HEX[3] = 7'b0100100;
		t_HEX[4] = 7'b0110000;
		t_HEX[5] = 7'b0011001;
		t_HEX[6] = 7'b0010010;
		t_HEX[7] = 7'b0000010;
		t_HEX[8] = 7'b1111000;
		t_HEX[9] = 7'b0000000;
		t_HEX[10] = 7'b0010000;
		t_HEX[11] = 7'b1111111;
		t_HEX[12] = 7'b1111111;
		t_HEX[13] = 7'b1111111;
		t_HEX[14] = 7'b1111111;
		t_HEX[15] = 7'b1111111;
		t_HEX[16] = 7'b1111111;
	end
 
	hex_decoder DUT(
		.SW(SW),
		.HEX0(HEX0)
	);
		
	initial begin
		for (SW=1; SW<17; SW=SW+1) begin
			if (HEX0 != t_HEX[SW])
				$display("!!!! Test %d error %h:%h \n", SW-1, HEX0, t_HEX[SW]);
			else
				$display("Passed Test %d\n", SW);
			#1;
		end
		$finish;
	end	

	
endmodule
