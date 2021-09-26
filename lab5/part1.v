`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part1(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR; 
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;

wire clock = KEY[0];
wire enable = SW[1];
wire clear_b = SW[0];
reg [7:0]Q;

always @ (posedge clock, negedge clear_b)
	begin
		if (clear_b == 1'b0)
		  Q[7:0] <= 0;
		else if(enable == 1'b1) begin
		Q[0] <= !Q[0];
			if (Q[0] & enable)
				Q[1] <= !Q[1];
			if (Q[1] & Q[0])
				Q[2] <= !Q[2];
			if (Q[2] & Q[1] & Q[0])
				Q[3] <= !Q[3];
			if (Q[3] & Q[2] & Q[1] & Q[0])
				Q[4] <= !Q[4];
			if (Q[4] & Q[3] & Q[2] & Q[1] & Q[0])
				Q[5] <= !Q[5];
			if (Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0])
				Q[6] <= !Q[6];
			if (Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0])
				Q[7] <= !Q[7];
		end
end

	
hexinggouts showup1(Q[0],Q[1],Q[2],Q[3],HEX0);
hexinggouts showup2(Q[4],Q[5],Q[6],Q[7],HEX1);


endmodule




//Hex Stuff
module hexinggouts(in0,in1,in2,in3,HEX);
    input in0, in1, in2, in3;
    output [6:0] HEX;

	h_x0 attempt0(in0, in1, in2, in3, HEX[0]);
	h_x1 attempt1(in0, in1, in2, in3, HEX[1]);
	h_x2 attempt2(in0, in1, in2, in3, HEX[2]);
	h_x3 attempt3(in0, in1, in2, in3, HEX[3]);
	h_x4 attempt4(in0, in1, in2, in3, HEX[4]);
	h_x5 attempt5(in0, in1, in2, in3, HEX[5]);
	h_x6 attempt6(in0, in1, in2, in3, HEX[6]);
endmodule

module h_x0(input SW0, SW1, SW2, SW3, output h0);

	assign h0 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&SW0);

endmodule


module h_x1(input SW0, SW1, SW2, SW3, output h1);

	assign h1 = 
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&!SW0) |
			(SW3&!SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h_x2(input SW0, SW1, SW2, SW3, output h2);

	assign h2 = 
			(!SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h_x3(input SW0, SW1, SW2, SW3, output h3);

	assign h3 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&SW1&SW0) |
			//(SW3&!SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h_x4(input SW0, SW1, SW2, SW3, output h4);

	assign h4 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&!SW2&!SW1&SW0);

endmodule


module h_x5(input SW0, SW1, SW2, SW3, output h5);

	assign h5 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&!SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&SW0);

endmodule


module h_x6(input SW0, SW1, SW2, SW3, output h6);

	assign h6 = 
			(!SW3&!SW2&!SW1&!SW0) |
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0);

endmodule
