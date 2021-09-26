`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part2(SW,LEDR);
    input [9:0] SW;
	// input [9:7] SW;
    output [9:0] LEDR;
	 wire c1, c2, c3;
	 fulladder x0(.a(SW[0]),.b(SW[4]),.c(SW[8]),.S(LEDR[0]),.C(c1));
	 fulladder x1(.a(SW[1]),.b(SW[5]),.c(c1),.S(LEDR[1]),.C(c2));
	 fulladder x2(.a(SW[2]),.b(SW[6]),.c(c2),.S(LEDR[2]),.C(c3));
	 fulladder x3(.a(SW[3]),.b(SW[7]),.c(c3),.S(LEDR[3]),.C(LEDR[9]));

	 endmodule

module fulladder(input a,b,c, output S,C);

	assign S = (!a*!b*c+a*!b*!c+!a*b*!c+a*b*c); 
	assign C = (a*!b*c+!a*b*c+a*b*!c+a*b*c);
endmodule 
