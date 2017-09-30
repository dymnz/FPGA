/*
	Two input Mux with variable data width
*/
module mux_2  #(parameter DATA_WIDTH = 2) (SW, IN_L, IN_H, OUT);
	input SW;
	input [DATA_WIDTH-1:0] IN_L, IN_H;
	output [DATA_WIDTH-1:0] OUT;

	assign OUT = ({DATA_WIDTH{SW}}&IN_H) 
						| ({DATA_WIDTH{~SW}}&IN_L);

endmodule
////////////////////////////////////////////

module mux_2_tb();

	reg SW;
	reg [3:0] IN_L, IN_H;
	wire [3:0] OUT;
	
	mux_2 #(.DATA_WIDTH(4)) DUT (
		.SW(SW),
		.IN_L(IN_L),
		.IN_H(IN_H),
		.OUT(OUT)
	);
	
	initial begin
		SW = 1'b0;
		IN_L = 4'b1010;
		IN_H = 4'b1011;
		#10
		if (OUT != IN_L) begin
			$display("error");
		end 
		
		SW = 1'b0;
		IN_L = 4'b0110;
		IN_H = 4'b1011;
		#10	
		if (OUT != IN_L) begin
			$display("error");
		end 		
		
		SW = 1'b1;
		IN_L = 4'b1010;
		IN_H = 4'b1011;
		#10	
		if (OUT != IN_H) begin
			$display("error");
		end 		
				
		SW = 1'b1;
		IN_L = 4'b1010;
		IN_H = 4'b1101;
		#10	
		if (OUT != IN_H) begin
			$display("error");
		end 	
		
		$finish;
	end
	
	
endmodule	
	
