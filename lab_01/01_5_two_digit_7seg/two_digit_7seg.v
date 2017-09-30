module two_digit_7seg(SW, HEX0, HEX1);

	input [3:0] SW;
	output [6:0] HEX0, HEX1;
	
	wire [3:0] V, MUX_IN_H, MUX_IN_L, MUX_OUT;	
	wire Z;
	
	assign V = SW;
	assign MUX_IN_L = V;
	assign MUX_IN_H[3] = 1'b0;
	
	comparator comp(
		.V(V),
		.Z(Z)
	);

	circuit_A cA(
		.V(V[2:0]),
		.M(MUX_IN_H[2:0])
	);
	
	mux_2 #(.DATA_WIDTH(4)) mux (
		.SW(Z),
		.IN_L(MUX_IN_L),
		.IN_H(MUX_IN_H),
		.OUT(MUX_OUT)
	);
	
	circuit_B cB(
		.ENB(Z),
		.HEX(HEX1)
	);
	
	hex_decoder hex_dec(
		.SW(MUX_OUT),
		.HEX(HEX0)
	);
	
endmodule	

////////////////////////////////////////

module two_digit_7seg_tb();

	reg [3:0] V;
	wire [6:0] HEX0, HEX1;
	reg [6:0] t_HEX [0:15];
	
	initial begin 	
		t_HEX[0] = 7'b1000000;
		t_HEX[1] = 7'b1111001;
		t_HEX[2] = 7'b0100100;
		t_HEX[3] = 7'b0110000;
		t_HEX[4] = 7'b0011001;
		t_HEX[5] = 7'b0010010;
		t_HEX[6] = 7'b0000010;
		t_HEX[7] = 7'b1111000;
		t_HEX[8] = 7'b0000000;
		t_HEX[9] = 7'b0010000;
		t_HEX[10] = 7'b1111111;
		t_HEX[11] = 7'b1111111;
		t_HEX[12] = 7'b1111111;
		t_HEX[13] = 7'b1111111;
		t_HEX[14] = 7'b1111111;
		t_HEX[15] = 7'b1111111;
	end
	
	two_digit_7seg DUT (
		.SW(V),
		.HEX0(HEX0),
		.HEX1(HEX1)
	);
		
	
	initial begin
		V = 0;
		repeat (16) begin
			#10
			if (HEX0 != t_HEX[V%10]) begin
				$display("!!!! HEX0 Test %d error\n", V);
			end
			if (V >= 10 && HEX1 != t_HEX[1]) begin
				$display("!!!! HEX1 >=10 Test %d error\n", V);
			end 
			else if (V < 10 && HEX1 != t_HEX[0]) begin
				$display("!!!! HEX1 <10 Test %d error\n", V);
			end
			
			V = V + 1;
		end
		$finish;
	end
	
endmodule	

