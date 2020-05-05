// ECE 5367
// Group: Sudoku Master
//
// This module simulates the top-level module for the Sudoku Master
// game.
`timescale 1ns/1ns
module tb_sudokuMasterTop ();
	reg CLK, RST;	

	reg [3:0] userNum;

	reg upButton, downButton, leftButton, rightButton;

	reg writeSwitch;
	
	wire [6:0] userNumDisp;

	wire wpInd;

	wire [27:0] rowDisp;

	wire winInd;

	wire [6:0] time_onesDisp,time_tensDisp;	

	wire [15:0] rowNums;
	wire [3:0] currentNum,time_ones,time_tens;

	sudokuMasterTop DUT_sudokuMasterTop(userNum,upButton,downButton,leftButton,rightButton,writeSwitch,userNumDisp,wpInd,rowDisp,winInd,time_onesDisp,time_tensDisp,rowNums,currentNum,time_ones,time_tens,CLK,RST);


endmodule
