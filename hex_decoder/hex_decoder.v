module hex_decoder(SW, HEX);
input	[3:0]	SW;
output [6:0] HEX;

wire a = SW[0];
wire b = SW[1];
wire c = SW[2];
wire d = SW[3];

assign HEX[0] = ~d&b | ~d&c&~b&a | ~c&~b&~a;
assign HEX[1] = ~d&~c | ~a&~c | ~d&~b&~a | ~d&b&a;
assign HEX[2] = ~c&~b | ~d&~b | ~d&a | ~d&c;
assign HEX[3] = ~c&~b&~a | ~d&c&~b&a | ~d&~c&b | ~d&b&~a;
assign HEX[4] = ~c&~b&~a | ~d&~b&~a;
assign HEX[5] = ~c&~b&~a | ~d&c&~b | ~d&c&~a;
assign HEX[6] = d&~c&~b | ~d&c&~b | ~d&~c&b | ~d&b&~a;

endmodule
