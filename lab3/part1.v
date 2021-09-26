`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part1(SW,LEDR);
    input [9:0] SW;
	// input [9:7] SW;
    output [9:0] LEDR;
	 
	 reg Out;
	 always @(*) begin
		//case(MuxSelect[2:0])
		case(SW[9:7])
		3'b000: Out = SW[0];
		3'b001: Out = SW[1];
		3'b010: Out = SW[2];
		3'b011: Out = SW[3];
		3'b100: Out = SW[4];
		3'b101: Out = SW[5];
		3'b110: Out = SW[6];
		default: Out = 0;
		endcase
	end
	 
	 assign LEDR[0] = Out;
	
endmodule 

