module hex_decoder_tb();
 
	reg [3:0] SW;
	wire [6:0] HEX0;
	
 
  hex_decoder DUT(
    .SW(SW),
    .HEX0(HEX0)
  );
   
  initial begin
    SW = 4'b0000;
    #20
    SW = 4'b0001;
    #20
    $finish;
  end
   
endmodule