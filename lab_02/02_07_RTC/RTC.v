module RTC(SW, CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	input CLOCK_50;
	input [9:0] SW;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire [3:0] HEX_input [5:0];
	
	wire set_hour, rst;
	wire hour_rst, min_rst;
	wire clk_1hz;
	wire [3:0] BCD_0, BCD_1;
	wire [5:0] count_set;
	wire [5:0] hour_count, min_count, sec_count;
	
	wire sec_carry, min_carry;
	
	assign BCD_0 = SW[3:0];
	assign BCD_1 = SW[7:4];
	assign rst = SW[8];
	assign set_hour = SW[9];
	
	assign hour_rst = set_hour & rst;
	assign min_rst = ~set_hour & rst;
	
	assign count_set = BCD_1 * 10 + BCD_0;
	
	One_hertz_module One_hertz(CLOCK_50, rst, clk_1hz);
	
	Second_module S_m(clk_1hz, rst, sec_count, sec_carry);
	Minute_module M_m(sec_carry, count_set, min_rst, min_count, min_carry);
	Hour_module H_m(min_carry, count_set, hour_rst, hour_count);
	
	Bin2BCD S_BCD(sec_count, HEX_input[0], HEX_input[1]);
	Bin2BCD M_BCD(min_count, HEX_input[2], HEX_input[3]);
	Bin2BCD H_BCD(hour_count, HEX_input[4], HEX_input[5]);
	
	hex_decoder_top h_0(HEX_input[0], HEX0);
	hex_decoder_top h_1(HEX_input[1], HEX1);
	hex_decoder_top h_2(HEX_input[2], HEX2);
	hex_decoder_top h_3(HEX_input[3], HEX3);
	hex_decoder_top h_4(HEX_input[4], HEX4);
	hex_decoder_top h_5(HEX_input[5], HEX5);

endmodule


module RTC_tb();

	reg CLOCK_50;
	reg [9:0] SW;
	wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
	wire [3:0] BCD_0, BCD_1;
	wire [5:0] count_set;
	wire [5:0] hour_count, min_count, sec_count;
	
	RTC DUT(SW, CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	initial begin	
		CLOCK_50 = 0;
		SW = 10'b0000000000;
		// Set min to 11
		#10	SW = 10'b0000010001;
		#10	SW[9] = 0;
		#10	SW[8] = 1;
		#10	SW[8] = 0;
		
		// Set hr to 22
		#10	SW = 10'b000100010;
		#10	SW[9] = 1;
		#10	SW[8] = 1;
		#10	SW[8] = 0;
		
		forever begin
			#5	CLOCK_50 = ~CLOCK_50;
		end
		#1000	$finish;
	end
	

	
endmodule