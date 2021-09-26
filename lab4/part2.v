`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part2(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR; 
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;



	hexing0_3 activateA(SW, HEX0);
	hexingALUouts Hex1(0,0,0,0,HEX1);
	hexingALUouts Hex2(0,0,0,0,HEX2);
	hexingALUouts Hex3(0,0,0,0,HEX3);
	 
//so if q isn't assigned anything it will automatically be = 0
reg [7:0] q;



	//q[7],q[6],q[5],q[4],q[3],q[2],q[1],q[0] = 0;

	 
	 
//Note: this adder works for SW0-7 but we are currently only inputting 0-3
	 wire c1, c2, c3;
	 wire s1, s2, s3, s4, c4;
	 adders x0(.a(SW[0]),.b(q[0]),.c(0),.S(s1),.C(c1));
	 adders x1(.a(SW[1]),.b(q[1]),.c(c1),.S(s2),.C(c2));
	 adders x2(.a(SW[2]),.b(q[2]),.c(c2),.S(s3),.C(c3));
	 adders x3(.a(SW[3]),.b(q[3]),.c(c3),.S(s4),.C(c4));
	 
	
	 
reg Out = 0;
reg [7:0] ALU;



	 always @(*) begin
		case(KEY[3:1])
		3'b111: begin
			ALU[0] = s1;
			ALU[1] = s2;
			ALU[2] = s3;
			ALU[3] = s4;
			ALU[4] = c4;
			ALU[5] = 0;
			ALU[6] = 0;
			ALU[7] = 0;
			end
		
		3'b110: ALU[7:0] = (q[3:0] + SW[3:0]);
		3'b101:
		if(q[3]==0)
		ALU = {4'b0000,q[3:0]};
		else
		ALU = {4'b1111,q[3:0]};
		3'b100: 
		if((q[3:0] | SW[3:0]) > 0)
		ALU = 8'b00000001; 
		else
		ALU = 0; 
		3'b011:
		if((q[3:0] & SW[3:0]) == 4'b1111)
		ALU = 8'b00000001; 
		else
		ALU = 0; //might also be wrong
		3'b010: begin
		//ALU = {4'b0000,SW[3:0]}; 
		//ALU << q[3:0];
		//ALU << 1;                    //could do cases!
		ALU = (SW[3:0] << q[3:0]);
		end
		3'b001: ALU[7:0] = (q[3:0]*SW[3:0]); //might not be right
		3'b000: ALU[7:0] = q[7:0];
		default: ALU = 0;
		endcase
    end
	 
	 //define clock
//reg Clock = KEY[0];                       ///probably not the best practice

//define reset
//reg Reset_b = SW[9];
	 
	 
	 	//assign q 
	always @(negedge KEY[0])            //SHOULD I ALSO ACTIVATE FOR NEG/POS EDGE RESET?????
	begin
		if(SW[9] == 1'b0)
		q[7:0]<=0;
		else
		q[7:0]<=ALU[7:0];
	end
	
	 
	 
	 
	hexingALUouts Hex4(q[0],q[1],q[2],q[3],HEX4);
	hexingALUouts Hex5(q[4],q[5],q[6],q[7],HEX5);
	 
	 assign LEDR[7:0] = q[7:0];

endmodule



	 
module adders(input a,b,c, output S,C);
	assign S = (!a*!b*c+a*!b*!c+!a*b*!c+a*b*c); 
	assign C = (a*!b*c+!a*b*c+a*b*!c+a*b*c);
endmodule 



module hexing0_3(SW,HEX);
    input [9:0] SW;
    output [6:0] HEX;

	hx0 attempt0(SW[0], SW[1], SW[2], SW[3], HEX[0]);
	hx1 attempt1(SW[0], SW[1], SW[2], SW[3], HEX[1]);
	hx2 attempt2(SW[0], SW[1], SW[2], SW[3], HEX[2]);
	hx3 attempt3(SW[0], SW[1], SW[2], SW[3], HEX[3]);
	hx4 attempt4(SW[0], SW[1], SW[2], SW[3], HEX[4]);
	hx5 attempt5(SW[0], SW[1], SW[2], SW[3], HEX[5]);
	hx6 attempt6(SW[0], SW[1], SW[2], SW[3], HEX[6]);
endmodule


module hexing4_7(SW,HEX);
    input [9:0] SW;
    output [6:0] HEX;

	hx0 attempt0(SW[4], SW[5], SW[6], SW[7], HEX[0]);
	hx1 attempt1(SW[4], SW[5], SW[6], SW[7], HEX[1]);
	hx2 attempt2(SW[4], SW[5], SW[6], SW[7], HEX[2]);
	hx3 attempt3(SW[4], SW[5], SW[6], SW[7], HEX[3]);
	hx4 attempt4(SW[4], SW[5], SW[6], SW[7], HEX[4]);
	hx5 attempt5(SW[4], SW[5], SW[6], SW[7], HEX[5]);
	hx6 attempt6(SW[4], SW[5], SW[6], SW[7], HEX[6]);
endmodule

module hexingALUouts(in0,in1,in2,in3,HEX);
    input in0, in1, in2, in3;
    output [6:0] HEX;

	hx0 attempt0(in0, in1, in2, in3, HEX[0]);
	hx1 attempt1(in0, in1, in2, in3, HEX[1]);
	hx2 attempt2(in0, in1, in2, in3, HEX[2]);
	hx3 attempt3(in0, in1, in2, in3, HEX[3]);
	hx4 attempt4(in0, in1, in2, in3, HEX[4]);
	hx5 attempt5(in0, in1, in2, in3, HEX[5]);
	hx6 attempt6(in0, in1, in2, in3, HEX[6]);
endmodule

module hx0(input SW0, SW1, SW2, SW3, output h0);

	assign h0 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&SW0);

endmodule


module hx1(input SW0, SW1, SW2, SW3, output h1);

	assign h1 = 
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&!SW0) |
			(SW3&!SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hx2(input SW0, SW1, SW2, SW3, output h2);

	assign h2 = 
			(!SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&!SW1&!SW0) |
			(SW3&SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hx3(input SW0, SW1, SW2, SW3, output h3);

	assign h3 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&SW1&SW0) |
			//(SW3&!SW2&!SW1&SW0) |
			(SW3&!SW2&SW1&!SW0) |
			(SW3&SW2&SW1&SW0);

endmodule


module hx4(input SW0, SW1, SW2, SW3, output h4);

	assign h4 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&!SW1&!SW0) |
			(!SW3&SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&!SW2&!SW1&SW0);

endmodule


module hx5(input SW0, SW1, SW2, SW3, output h5);

	assign h5 = 
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&!SW2&SW1&!SW0) |
			(!SW3&!SW2&SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&SW0);

endmodule


module hx6(input SW0, SW1, SW2, SW3, output h6);

	assign h6 = 
			(!SW3&!SW2&!SW1&!SW0) |
			(!SW3&!SW2&!SW1&SW0) |
			(!SW3&SW2&SW1&SW0) |
			(SW3&SW2&!SW1&!SW0);

endmodule

