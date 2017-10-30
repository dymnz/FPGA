/*
	var-length ripple carry adder
	
	test passed
*/
module ripple_carry_adder #(parameter WIDTH = 4) (A, B, Ci, S, Co);

	input Ci;
	input [WIDTH-1:0] A, B;
	output Co;
	output [WIDTH-1:0] S;
	
	wire [WIDTH-1:0] Co_wire;

	assign Co = Co_wire[WIDTH-1];
		
	full_adder full_adder_LSB (
	  .A(A[0]),
	  .B(B[0]),
	  .Ci(Ci),
	  .S(S[0]),
	  .Co(Co_wire[0])
	);
	
	genvar i;
	generate
		for (i=1; i<WIDTH; i=i+1) begin : full_adder_array // <-- example block name
			full_adder full_adder_inst (
			  .A(A[i]),
			  .B(B[i]),
			  .Ci(Co_wire[i-1]),
			  .S(S[i]),
			  .Co(Co_wire[i])
			);#### 200Hz 10mV in
* Signal measured in CH2, not quite accurate in a range of N mV
* Best output DC: 2.3V / Vpp: 4V
* After HPF: DC: 2mV / Vpp: 30mV
* After Inv amp: DC: -13mV / Vpp: 76mV

		end
	endgenerate

endmodule	

//////////////////////////////////
module ripple_carry_adder_tb();

	reg Ci;
	reg [3:0] A, B;
	
	wire Co;
	wire [3:0] S;
	
	ripple_carry_adder #(.WIDTH(4)) DUT (
		.A(A), 
		.B(B), 
		.Ci(Ci), 
		.S(S), 
		.Co(Co)
	);
	
	initial begin
		A = 0;
		B = 0;
		Ci = 0;
	end
	
	initial begin
		repeat (15) begin
			B = 0;
			repeat (15) begin
				Ci = 1'b0;
				#10
				if ({Co, S} != A + B + Ci) begin
					$display("%h + %h + %h != %h:%h", 
						A, B, Ci, S, Co);
				end				
				Ci = 1'b1;
				#10
				if ({Co, S} != A + B + Ci) begin
					$display("%h + %h + %h != %h:%h", 
						A, B, Ci, S, Co);
				end
				B = B + 1;
			end
			A = A + 1;
		end
		$finish;
	end
	

endmodule
