module hex_decoder(SW, HEX0);
input	[3:0]	SW;
output [6:0] HEX0;

wire a = SW[0];
wire b = SW[1];
wire c = SW[2];
wire d = SW[3];

assign HEX0[0] = ~(~d&b | ~c&~b&~a | d&~c&~b | ~d&c&a);
assign HEX0[1] = ~(~d&~b | ~c&~b&~a | ~d&c&~a | d&~c&~b);
assign HEX0[2] = ~(~c&~b | ~d&~b | ~d&a | ~d&c);
assign HEX0[3] = ~(~c&~b&~a | ~d&c&~b&a | ~d&~c&b | ~d&b&~a);
assign HEX0[4] = ~(~c&~b&~a | ~d&b&~a);
assign HEX0[5] = ~(d&~c&~b | ~d&c&~b | ~d&~b&~a | ~d&c&~a);
assign HEX0[6] = ~(d&~c&~b | ~d&c&~b | ~d&~c&b | ~d&b&~a);

endmodule
