module counter #(parameter WIDTH = 4) (CLK, RST, ENB, COUNT);

	input CLK, ENB;				// Counter clock and Counter enable
	input RST;		// Reset of TFF
	output [WIDTH-1:0] COUNT;	// Output of TFF

	// and(ENB[i], Indiviual_enable_list[i-1], ENB)
	wire [WIDTH-1:0] Indiviual_enable_list; 

	assign Indiviual_enable_list[0] = ENB;

	TFF_async TFF_0 (
		.CLK(CLK), 
		.RST(RST), 
		.T(Indiviual_enable_list[0]), 
		.Q(COUNT[0]));
		
	genvar i;
	generate		
		for (i = 1; i < WIDTH; i = i +1) begin : Counter_array 
			and AND_array ( 
				Indiviual_enable_list[i], 
				Indiviual_enable_list[i-1],
				COUNT[i-1]);
			
			TFF_async TFF_array (
				.CLK(CLK),
				.RST(RST),
				.T(Indiviual_enable_list[i]),
				.Q(COUNT[i]));
		end
	endgenerate
endmodule

//////////////////////////////////
module counter_tb #(parameter WIDTH = 16)();
	reg CLK, RST, ENB;
	wire [WIDTH-1:0] COUNT;
	reg [WIDTH-1:0] COUNT_REF;

	reg ERROR = 1'b0;

	counter #(.WIDTH(WIDTH)) DUT (
		.CLK(CLK),
		.RST(RST),
		.ENB(ENB),
		.COUNT(COUNT));

	initial begin
		ENB = 1;
		
	end

	initial begin	
	    $dumpfile("wave.vcd");
    	$dumpvars;
		CLK = 0;
		COUNT_REF = 0;
		RST = 1;

		#10 RST = 0;
		#10 RST = 1;

		repeat (65536) begin
			# 1
			//$display("%h:%h", COUNT_REF, COUNT);
			//$display("%h%h%h%h", COUNT[0], COUNT[1], COUNT[2], COUNT[3]);

			if (COUNT_REF != COUNT) begin
				$display("FUCK %h:%h", COUNT_REF, COUNT);
				ERROR = 1;
			end

			COUNT_REF = COUNT_REF + 1;
			# 1 CLK = ~CLK;
			# 1 CLK = ~CLK;
		end

		if (ERROR) begin
			$display("ERROR");
		end

		$finish;
	end



endmodule

//////////////////////////////////
module counter_top #(parameter WIDTH = 16)();
	reg CLK, RST, ENB;
	wire [WIDTH-1:0] COUNT;
	reg [WIDTH-1:0] COUNT_REF;

	reg ERROR = 1'b0;

	counter #(.WIDTH(WIDTH)) DUT (
		.CLK(CLK),
		.RST(RST),
		.ENB(ENB),
		.COUNT(COUNT));

	initial begin
		ENB = 1;
		
	end

	initial begin	
	    $dumpfile("wave.vcd");
    	$dumpvars;
		CLK = 0;
		COUNT_REF = 0;
		RST = 1;

		#10 RST = 0;
		#10 RST = 1;

		repeat (65536) begin
			# 1
			//$display("%h:%h", COUNT_REF, COUNT);
			//$display("%h%h%h%h", COUNT[0], COUNT[1], COUNT[2], COUNT[3]);

			if (COUNT_REF != COUNT) begin
				$display("FUCK %h:%h", COUNT_REF, COUNT);
				ERROR = 1;
			end

			COUNT_REF = COUNT_REF + 1;
			# 1 CLK = ~CLK;
			# 1 CLK = ~CLK;
		end

		if (ERROR) begin
			$display("ERROR");
		end

		$finish;
	end



endmodule


