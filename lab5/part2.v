`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(SW,CLOCK_50,HEX0);
input [9:0] SW;
input wire CLOCK_50; 
output [6:0] HEX0;

reg clock;
wire counts;
wire enable = 1'b1;
wire clear_b = SW[9];
reg [7:0]Q;
reg count;
reg send;
//0b1001110001000 = 5000
reg[3:0] q;
wire [3:0] d;


always @ (posedge CLOCK_50)
	begin
	if (count == 9'b000000000)
		count <= 9'b111110100;
	else
		count <= count -1; 
	end
//assign clocks[0] = (count == 13'b0000000000001)? 1:0;

assign counts = count;

always @ (*)
begin
	if (SW[1:0] == 2'b00)
		clock = CLOCK_50;
	if (SW[1:0] == 2'b01)
		begin
		case (counts)
			9'b000000001: clock = 1'b1;
			default: clock = 1'b0;
		endcase
		end
	if (SW[1:0] == 2'b10)
		begin
		case (counts)
			9'b000000001: clock = 1'b1;
			9'b011111011: clock = 1'b1;
			default: clock = 1'b0;
		endcase
		end
	if (SW[1:0] == 2'b11)
		begin
		case (counts)
			9'b000000001: clock = 1'b1;
			9'b001111110: clock = 1'b1;
			9'b000000001: clock = 1'b1;
			9'b101111000: clock = 1'b1;
			default: clock = 1'b0;
		endcase
		end
end



always @ (posedge clock)
	begin
		if (clear_b == 1'b1)
		  q<=0;
		else if(enable == 1'b1) 
		q <= d;
		else if (q == 4'b1111)
		q <= 0;
		else if (enable == 1'b1)
		q <= q + 1;
end

	
hexing___outs showup(q[0],q[1],q[2],q[3],HEX0);

endmodule


//Hex Stuff
module hexing___outs(in0,in1,in2,in3,HEX);
    input in0, in1, in2, in3;
    output [6:0] HEX;

	h___x0 attempt0(in0, in1, in2, in3, HEX[0]);
	h___x1 attempt1(in0, in1, in2, in3, HEX[1]);
	h___x2 attempt2(in0, in1, in2, in3, HEX[2]);
	h___x3 attempt3(in0, in1, in2, in3, HEX[3]);
	h___x4 attempt4(in0, in1, in2, in3, HEX[4]);
	h___x5 attempt5(in0, in1, in2, in3, HEX[5]);
	h___x6 attempt6(in0, in1, in2, in3, HEX[6]);
endmodule

module h___x0(input SW0, SW1, SW2, SW3, output h0);

	assign h0 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&SW0);

endmodule


module h___x1(input SW0, SW1, SW2, SW3, output h1);

	assign h1 = 
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&!SW0) |
			(SW3&!SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h___x2(input SW0, SW1, SW2, SW3, output h2);

	assign h2 = 
			(!SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h___x3(input SW0, SW1, SW2, SW3, output h3);

	assign h3 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&SW1&SW0) |
			//(SW3&!SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module h___x4(input SW0, SW1, SW2, SW3, output h4);

	assign h4 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&!SW2&!SW1&SW0);

endmodule


module h___x5(input SW0, SW1, SW2, SW3, output h5);

	assign h5 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&!SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&SW0);

endmodule


module h___x6(input SW0, SW1, SW2, SW3, output h6);

	assign h6 = 
			(!SW3&!SW2&!SW1&!SW0) |
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0);

endmodule
