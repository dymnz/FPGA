module FSM_case (SW, KEY, LEDR);
	
	input [9:0] SW;
	input [3:0] KEY;
	output[9:0] LEDR;

	wire RST, CLK, IN, OUT;
	reg [3:0] current_state, next_state;
	
	assign RST = SW[0];	
	assign CLK = KEY[0];
	
	assign IN = SW[1];
	assign LEDR[9] = OUT;
	assign LEDR[3:0] = current_state;
		
	// State table
	parameter 
		A = 9'b0000,
		B = 9'b0001,		
		C = 9'b0010,
		D = 9'b0011,
		E = 9'b0100,
		F = 9'b0101,
		G = 9'b0110,
		H = 9'b0111,
		I = 9'b1000;	
	
	assign OUT = (current_state == E) | (current_state == I);		
	
	always @(IN, current_state) begin
		case (current_state)
		A: 
			if (~IN) begin
				next_state = B;
			end else begin
				next_state = F;
			end	
		B: 
			if (~IN) begin
				next_state = C;
			end else begin
				next_state = F;
			end	
		C: 
			if (~IN) begin
				next_state = D;
			end else begin
				next_state = F;
			end			
		D: 
			if (~IN) begin
				next_state = E;
			end else begin
				next_state = F;
			end		
		E: 
			if (~IN) begin
				next_state = E;
			end else begin
				next_state = F;
			end		

		F: 
			if (~IN) begin
				next_state = B;
			end else begin
				next_state = G;
			end	
		G: 
			if (~IN) begin
				next_state = B;
			end else begin
				next_state = H;
			end			
		H: 
			if (~IN) begin
				next_state = B;
			end else begin
				next_state = I;
			end		
		I: 
			if (~IN) begin
				next_state = B;
			end else begin
				next_state = I;
			end		
			
		default:
			next_state = 4'bxxxx;
		endcase
	
	end
		
	always @(posedge CLK) begin
		if (~RST) begin
			current_state = A;
		end else begin
			current_state = next_state;
		end		
	end
		
		
endmodule