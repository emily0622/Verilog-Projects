`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part3(SW,KEY,LEDR,CLOCK_50);
input wire CLOCK_50;
input [9:0] SW;
input [3:0] KEY;
output [7:0] LEDR; 

assign LEDR[7:0] = 8'b00000000;

endmodule
