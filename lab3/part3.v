`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part3(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0] SW;
input [2:0] KEY;
output [7:0] LEDR; 
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;

//complete adder = somehting
// out <=somehting

//reg bit[7:0] = completeadder(SW, LEDR);
//
//input [9:0] SW;
//    output [9:0] LEDR;

	hexingB activateB(SW, HEX0);
	hexingA activateA(SW, HEX2);

	hexingALUout Hex1(0,0,0,0,HEX1);
	hexingALUout Hex3(0,0,0,0,HEX3);

	 wire c1, c2, c3;
	 wire s1, s2, s3, s4, c4;
	 adder x0(.a(SW[0]),.b(SW[4]),.c(0),.S(s1),.C(c1));
	 adder x1(.a(SW[1]),.b(SW[5]),.c(c1),.S(s2),.C(c2));
	 adder x2(.a(SW[2]),.b(SW[6]),.c(c2),.S(s3),.C(c3));
	 adder x3(.a(SW[3]),.b(SW[7]),.c(c3),.S(s4),.C(c4));
	 
	
	 
reg Out = 0;
reg [7:0] ALU;
	 always @(*) begin
		case(KEY[2:0])
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
		
		3'b110: ALU[7:0] = (SW[7:4] + SW[3:0]);
		3'b101:
		if(SW[3]==0)
		ALU = {4'b000,SW[3:0]};
		else
		ALU = {4'b1111,SW[3:0]};
		3'b100: 
		if((SW[7:4] | SW[3:0]) > 0)
		ALU = 8'b00000001; 
		else
		ALU = 0; 
		3'b011:
		if((SW[7:4] & SW[3:0]) == 4'b1111)
		ALU = 8'b00000001; 
		else
		ALU = 0; //might also be wrong
		3'b010: ALU = SW; //concatenation of A and B
		default: ALU = 0;
		endcase
    end
	 
	 
	 
	hexingALUout Hex4(ALU[0],ALU[1],ALU[2],ALU[3],HEX4);
	hexingALUout Hex5(ALU[4],ALU[5],ALU[6],ALU[7],HEX5);
	 
	 assign LEDR[7:0] = ALU[7:0];
	 //stage1 meep(SW,KEY,LEDR);
	 
	// completeadder attempting(SW, LEDR);//any other case will change it
//
//	 always @(*) begin
//	 if(KEY[2:0]>3'b101)
//		LEDR = 0;
//    end
//	 
	 //assign LEDR[0] = Out;
endmodule

//
//module stage1(SW, KEY, LEDR);
//input [9:0] SW;
//input [2:0] KEY;
//output reg [7:0] LEDR;
//
//reg Out = 0;
//	 always @(*) begin
//		case(KEY[2:0])
//		3'b000: Out = 1;
//		//; //Out = 0; //do nothinngg
//		//3'b000: LEDR = bit;
//		3'b001: LEDR = (SW[7:4] + SW[3:0]);
//		3'b010:
//		if(SW[3]==0)
//		LEDR = {4'b000,SW[3:0]};
//		else
//		LEDR = {4'b1111,SW[3:0]};
//		3'b011: 
//		if((SW[7:4] | SW[3:0]) > 0)
//		LEDR = 8'b00000001; //probably not allowed
//		else
//		LEDR = 0; //might also be wrong
//		3'b100:
//		if((SW[7:4] & SW[3:0]) == 4'b1111)
//		LEDR = 8'b00000001; //probably not allowed
//		else
//		LEDR = 0; //might also be wrong
//		3'b101: LEDR = SW; //concatenation of A and B
//		default: LEDR = 0;
//		endcase
//    end
//endmodule
	 
	 
//	 
//module completeadder(SW, LEDR);
//	input [9:0] SW;
//    output [9:0] LEDR;
//	 wire c1, c2, c3;
//	 adder x0(.a(SW[0]),.b(SW[4]),.c(SW[8]),.S(LEDR[0]),.C(c1));
//	 adder x1(.a(SW[1]),.b(SW[5]),.c(c1),.S(LEDR[1]),.C(c2));
//	 adder x2(.a(SW[2]),.b(SW[6]),.c(c2),.S(LEDR[2]),.C(c3));
//	 adder x3(.a(SW[3]),.b(SW[7]),.c(c3),.S(LEDR[3]),.C(LEDR[9]));
//endmodule

	 
module adder(input a,b,c, output S,C);
	assign S = (!a*!b*c+a*!b*!c+!a*b*!c+a*b*c); 
	assign C = (a*!b*c+!a*b*c+a*b*!c+a*b*c);
endmodule 



module hexingB(SW,HEX);
    input [9:0] SW;
    output [6:0] HEX;

	hex0 attempt0(SW[0], SW[1], SW[2], SW[3], HEX[0]);
	hex1 attempt1(SW[0], SW[1], SW[2], SW[3], HEX[1]);
	hex2 attempt2(SW[0], SW[1], SW[2], SW[3], HEX[2]);
	hex3 attempt3(SW[0], SW[1], SW[2], SW[3], HEX[3]);
	hex4 attempt4(SW[0], SW[1], SW[2], SW[3], HEX[4]);
	hex5 attempt5(SW[0], SW[1], SW[2], SW[3], HEX[5]);
	hex6 attempt6(SW[0], SW[1], SW[2], SW[3], HEX[6]);
endmodule


module hexingA(SW,HEX);
    input [9:0] SW;
    output [6:0] HEX;

	hex0 attempt0(SW[4], SW[5], SW[6], SW[7], HEX[0]);
	hex1 attempt1(SW[4], SW[5], SW[6], SW[7], HEX[1]);
	hex2 attempt2(SW[4], SW[5], SW[6], SW[7], HEX[2]);
	hex3 attempt3(SW[4], SW[5], SW[6], SW[7], HEX[3]);
	hex4 attempt4(SW[4], SW[5], SW[6], SW[7], HEX[4]);
	hex5 attempt5(SW[4], SW[5], SW[6], SW[7], HEX[5]);
	hex6 attempt6(SW[4], SW[5], SW[6], SW[7], HEX[6]);
endmodule

module hexingALUout(in0,in1,in2,in3,HEX);
    input in0, in1, in2, in3;
    output [6:0] HEX;

	hex0 attempt0(in0, in1, in2, in3, HEX[0]);
	hex1 attempt1(in0, in1, in2, in3, HEX[1]);
	hex2 attempt2(in0, in1, in2, in3, HEX[2]);
	hex3 attempt3(in0, in1, in2, in3, HEX[3]);
	hex4 attempt4(in0, in1, in2, in3, HEX[4]);
	hex5 attempt5(in0, in1, in2, in3, HEX[5]);
	hex6 attempt6(in0, in1, in2, in3, HEX[6]);
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
			//(SW3&!SW2&!SW1&SW0) |
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

