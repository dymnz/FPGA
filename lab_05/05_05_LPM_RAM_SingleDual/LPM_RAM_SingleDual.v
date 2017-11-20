module LPM_RAM_SingleDual (CLOCK_50, SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
	
	input CLOCK_50;
	input [9:0] SW;
	input [3:0] KEY;
	output[9:0] LEDR;
	output[6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire WRT_ENB, SEL_ADDR, CLK_1, RAM_CLK, RST;
	wire DFF_ADDR_ENB, DFF_DATA_ENB;
	
	reg RAM_WRT_ENB;
	reg [4:0] ram_address;
	
	wire [7:0] sw_data_in,		// Input from SW[7:0]
					ram_data_in, 	// For writing, from DFF_DATA
					data_out;		// From ram
	wire [4:0] sw_address, 	 // Input from SW[4:0]
					wr_address,  // For writing, from DFF_ADDR
					rd_address;  // For read interation
					//ram_address; // Prepared for ram
	
	// IN
	assign RST = KEY[0];
	assign WRT_ENB = SW[9];	
	assign sw_data_in = SW[7:0];
	assign RAM_CLK = CLOCK_50;	
	assign SEL_ADDR = SW[8];
	assign sw_address = SW[4:0];
	
	// OUT
	assign LEDR[0] = WRT_ENB;
	assign LEDR[9:5] = wr_address;
	
	// OTHER
	assign DFF_ADDR_ENB = RAM_CLK & SEL_ADDR;
	assign DFF_DATA_ENB = RAM_CLK & ~SEL_ADDR;	
	
	One_hertz_module one_hertz (CLOCK_50, RST, CLK_1);
	Count_32 count_0 (CLK_1, RST, rd_address);
	
	// DATA storage, enable when SEL_ADDR = 0
	DFF_N #(.WIDTH(8)) DFF_data (DFF_DATA_ENB, RST, sw_data_in, ram_data_in);
	
	// ADDR storage, enable when SEL_ADDR = 1
	DFF_N #(.WIDTH(5)) DFF_addr (DFF_ADDR_ENB, RST, sw_address, wr_address);
	
	
	Hex_7seg hex_0 (data_out[3:0], HEX0);
	Hex_7seg hex_1 (data_out[7:4], HEX1);
	Hex_7seg hex_2 (ram_address[3:0], HEX2);
	Hex_7seg hex_3 ({3'b0, ram_address[4]}, HEX3);
	
	
	reg [3:0] current_state, next_state;
	
	// State table
	parameter 
		A = 4'b0000,
		B = 4'b0001,		
		C = 4'b0010,
		D = 4'b0011;
	
	initial current_state = A;
	initial next_state = A;
	
	always @(WRT_ENB, current_state) begin
		case (current_state)
		A: 
			if (WRT_ENB) begin
				next_state = B;
			end else begin
				next_state = A;
			end	
		B: 
			if (WRT_ENB) begin
				next_state = C;
			end else begin
				next_state = A;
			end	
		C: 
			if (WRT_ENB) begin
				next_state = C;
			end else begin
				next_state = D;
			end		
		D: 
			if (WRT_ENB) begin
				next_state = C;
			end else begin
				next_state = A;
			end
		default:
			next_state = A;
		endcase	
	end
		
	always @(posedge RAM_CLK) begin
		current_state = next_state;	
	end
	
	always @(posedge RAM_CLK) begin
		case (current_state)
		A: begin
			ram_address <= rd_address;
			RAM_WRT_ENB <= 1'b0;
			end
		B: begin
			ram_address <= wr_address;
			RAM_WRT_ENB <= 1'b0;
			end
		C: begin
			ram_address <= wr_address;
			RAM_WRT_ENB <= 1'b1;
			end
		D: begin
			ram_address <= wr_address;
			RAM_WRT_ENB <= 1'b0;
			end
		default: begin
			ram_address <= rd_address;
			RAM_WRT_ENB <= 1'b0;
			end
		endcase	
	end
	
	LPM_Single ram_0(ram_address, RAM_CLK, ram_data_in, RAM_WRT_ENB, data_out);
	
endmodule