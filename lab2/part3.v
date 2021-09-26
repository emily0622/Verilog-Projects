`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part3(SW,HEX0);
    input [9:0] SW;
    output [6:0] HEX0;

	hex0 attempt0(SW[0], SW[1], SW[2], SW[3], HEX0[0]);
	hex1 attempt1(SW[0], SW[1], SW[2], SW[3], HEX0[1]);
	hex2 attempt2(SW[0], SW[1], SW[2], SW[3], HEX0[2]);
	hex3 attempt3(SW[0], SW[1], SW[2], SW[3], HEX0[3]);
	hex4 attempt4(SW[0], SW[1], SW[2], SW[3], HEX0[4]);
	hex5 attempt5(SW[0], SW[1], SW[2], SW[3], HEX0[5]);
	hex6 attempt6(SW[0], SW[1], SW[2], SW[3], HEX0[6]);

	
endmodule

module hex0(input SW0, SW1, SW2, SW3, output h0);

	assign h0 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&SW0);

endmodule


module hex1(input SW0, SW1, SW2, SW3, output h1);

	assign h1 = 
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&!SW0) |
			(SW3&!SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hex2(input SW0, SW1, SW2, SW3, output h2);

	assign h2 = 
			(!SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hex3(input SW0, SW1, SW2, SW3, output h3);

	assign h3 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&!SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hex4(input SW0, SW1, SW2, SW3, output h4);

	assign h4 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&!SW2&!SW1&SW0);

endmodule


module hex5(input SW0, SW1, SW2, SW3, output h5);

	assign h5 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&!SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&SW0);

endmodule


module hex6(input SW0, SW1, SW2, SW3, output h6);

	assign h6 = 
			(!SW3&!SW2&!SW1&!SW0) |
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0);

endmodule


