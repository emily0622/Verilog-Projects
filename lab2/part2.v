`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module part2(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
	
	
	 multiplexerp1 testingmpp1(
	 .x(SW[0]),.y(SW[1]),.s(SW[9]), .m(LEDR[0]));

	 
//    v7432 testing_v7432(
//        .pin1(SW[0]),
//		  .pin3(SW[1]),
//		  .pin5(SW[2]),
//		  .pin9(SW[3]),
//		  .pin11(SW[4]),
//		  .pin13(SW[5]),
//        .pin2(LEDR[0]),
//        .pin4(LEDR[1]),
//        .pin6(LEDR[2]),
//        .pin8(LEDR[3]),
//        .pin10(LEDR[4]),
//        .pin12(LEDR[5])

//			.pin1(SW[0]),
//			.pin2(SW[1]),
//			.pin4(SW[2]),
//			.pin5(SW[3]),
//			.pin9(SW[4]),
//			.pin10(SW[5]),
//			.pin12(SW[6]),
//			.pin13(SW[7]),
//			.pin3(LEDR[0]),
//			.pin6(LEDR[1]),
//			.pin8(LEDR[2]),
//			.pin11(LEDR[3]),
//        );
endmodule

module multiplexerp1(input x, y, s,
							output m);
		wire w1, w2, w3;
		v7404 NOT(.pin1(s), .pin2(w1));
		v7408 AND(.pin1(x),.pin2(w1),.pin3(w2),.pin4(s),.pin5(y),.pin6(w3));
		v7432 OR(.pin1(w2),.pin2(w3),.pin3(m));
endmodule


module v7404(input pin1, pin3, pin5, pin9, pin11, pin13,
				output pin2, pin4, pin6, pin8, pin10, pin12);

  
    //assign output = ~input;

    assign pin2 = !pin1;
	 assign pin4 = !pin3;
	 assign pin6 = !pin5;
	 assign pin8 = !pin9;
	 assign pin10 = !pin11;
	 assign pin12 = !pin13;

endmodule

module v7408(input pin1, pin2, pin4, pin5,
				pin9, pin10, pin12, pin13,
				output pin3, pin6, pin8, pin11);

  
    //assign output = input1 & input2;

    assign pin3 = pin1 & pin2;
	 assign pin6 = pin4 & pin5;
	 assign pin8 = pin9 & pin10;
	 assign pin11 = pin12 & pin13;

endmodule


module v7432(input pin1, pin2, pin4, pin5, pin9, pin10, pin12, pin13,
				output pin3, pin6, pin8, pin11);

  
    //assign output = input1 | input2;

    assign pin3 = pin1 | pin2;
	 assign pin6 = pin4 | pin5;
	 assign pin8 = pin9 | pin10;
	 assign pin11 = pin12 | pin13;

endmodule


