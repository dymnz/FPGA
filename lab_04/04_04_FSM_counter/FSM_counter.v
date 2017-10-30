module FSM_counter (SW, KEY, HEX0);
	
	input [9:0] SW;
	input [3:0] KEY;
	output[6:0] HEX0;

	wire RST, CLK, OUT;
	wire [1:0] W;
	reg [3:0] current_state, next_state;
	
	assign RST = SW[0];	
	assign CLK = KEY[0];
	
	assign W = SW[1:0];
		
	// State table
	parameter 
		S0 = 9'b0000,
		S1 = 9'b0001,		
		S2 = 9'b0010,
		S3 = 9'b0011,
		S4 = 9'b0100,
		S5 = 9'b0101,
		S6 = 9'b0110,
		S7 = 9'b0111,
		S8 = 9'b1000,
		S9 = 9'b1001;	
	
	Hex_7seg h0 (current_state, HEX0);
	
	always @(W, current_state) begin
		case (current_state)
		 S0:
					if (~W[1] & ~W[0]) begin
							  next_state = S0;
					end else if (~W[1] & W[0]) begin
							  next_state = S1;
					end else if (W[1] & ~W[0]) begin
							  next_state = S2;
					end else if (W[1] & W[0]) begin
							  next_state = S9;
					end
		 S1:
					if (~W[1] & ~W[0]) begin
							  next_state = S1;
					end else if (~W[1] & W[0]) begin
							  next_state = S2;
					end else if (W[1] & ~W[0]) begin
							  next_state = S3;
					end else if (W[1] & W[0]) begin
							  next_state = S0;
					end
		 S2:
					if (~W[1] & ~W[0]) begin
							  next_state = S2;
					end else if (~W[1] & W[0]) begin
							  next_state = S3;
					end else if (W[1] & ~W[0]) begin
							  next_state = S4;
					end else if (W[1] & W[0]) begin
							  next_state = S1;
					end
		 S3:
					if (~W[1] & ~W[0]) begin
							  next_state = S3;
					end else if (~W[1] & W[0]) begin
							  next_state = S4;
					end else if (W[1] & ~W[0]) begin
							  next_state = S5;
					end else if (W[1] & W[0]) begin
							  next_state = S2;
					end
		 S4:
					if (~W[1] & ~W[0]) begin
							  next_state = S4;
					end else if (~W[1] & W[0]) begin
							  next_state = S5;
					end else if (W[1] & ~W[0]) begin
							  next_state = S6;
					end else if (W[1] & W[0]) begin
							  next_state = S3;
					end
		 S5:
					if (~W[1] & ~W[0]) begin
							  next_state = S5;
					end else if (~W[1] & W[0]) begin
							  next_state = S6;
					end else if (W[1] & ~W[0]) begin
							  next_state = S7;
					end else if (W[1] & W[0]) begin
							  next_state = S4;
					end
		 S6:
					if (~W[1] & ~W[0]) begin
							  next_state = S6;
					end else if (~W[1] & W[0]) begin
							  next_state = S7;
					end else if (W[1] & ~W[0]) begin
							  next_state = S8;
					end else if (W[1] & W[0]) begin
							  next_state = S5;
					end
		 S7:
					if (~W[1] & ~W[0]) begin
							  next_state = S7;
					end else if (~W[1] & W[0]) begin
							  next_state = S8;
					end else if (W[1] & ~W[0]) begin
							  next_state = S9;
					end else if (W[1] & W[0]) begin
							  next_state = S6;
					end
		 S8:
					if (~W[1] & ~W[0]) begin
							  next_state = S8;
					end else if (~W[1] & W[0]) begin
							  next_state = S9;
					end else if (W[1] & ~W[0]) begin
							  next_state = S0;
					end else if (W[1] & W[0]) begin
							  next_state = S7;
					end
		 S9:
					if (~W[1] & ~W[0]) begin
							  next_state = S9;
					end else if (~W[1] & W[0]) begin
							  next_state = S0;
					end else if (W[1] & ~W[0]) begin
							  next_state = S1;
					end else if (W[1] & W[0]) begin
							  next_state = S8;
					end
		default:
			next_state = 4'bxxxx;
		endcase
	
	end
		
	always @(posedge CLK) begin
		if (~RST) begin
			current_state = S0;
		end else begin
			current_state = next_state;
		end		
	end
		
		
endmodule