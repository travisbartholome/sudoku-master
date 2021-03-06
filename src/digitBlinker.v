//ECE5367
//Group: Sudoku Master
//digitBlinker
//This module facilitates the blinking of the selected digit on the seven segment LED

module digitBlinker(isDigitSelected,digitInfo,digitOutput,clk,rst);
	input isDigitSelected, clk, rst;
	input [6:0] digitInfo;

	output [6:0] digitOutput;

	wire pulse;

	oneSecTimer blinkPulser(1'b1,clk,rst,pulse);
	outputLoadRegister outputBlinker(isDigitSelected,pulse,digitInfo,digitOutput);
endmodule
