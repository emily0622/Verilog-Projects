`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR; 
output [6:0] HEX0;
output [6:0] HEX1;
output [6:0] HEX2;
output [6:0] HEX3;
output [6:0] HEX4;
output [6:0] HEX5;

reg [7:0] QV, Count;

wire PLoad = KEY[1];
wire Enable = !SW[9]; //reset
wire ShiftR = KEY[2];
wire Clock = KEY[0];
wire ASRight = KEY[3];

reg Lin;
reg Rin;


always @(posedge Clock)
begin
	if (!Enable) QV <= 0;
	else begin
	
	if (ASRight) 
	begin
		Lin <= QV[7];
		Rin <= QV[0];
	end
else
	begin
		Lin <= QV[0];
		Rin <= QV[7];
	end
	
	if(PLoad)
		QV<= SW[7:0];
	else if(Enable & !ShiftR)
		begin
			QV[7] <= Lin;
			QV[6] <= QV[7];
			QV[5] <= QV[6];
			QV[4] <= QV[5];
			QV[3] <= QV[4];
			QV[2] <= QV[3];
			QV[1] <= QV[2];
			QV[0] <= QV[1];
		end
	else if(Enable)
		begin
			QV[7] <= QV[6];
			QV[6] <= QV[5];
			QV[5] <= QV[4];
			QV[4] <= QV[3];
			QV[3] <= QV[2];
			QV[2] <= QV[1];
			QV[1] <= QV[0];
			QV[0] <= Rin;
		end
	end
	end
	
	assign LEDR[7:0] = QV[7:0];
endmodule


//wire ASRight = !KEY[3];
//wire rotation = !KEY[2];
//wire parallel_loadn = !KEY[1];
//wire clock = !KEY[0];
//wire reset = SW[9];
//wire right0 =0;
//wire left0 = 0;




