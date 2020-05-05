// ECE 5367
// Group: Sudoku Master
//
// This module simulates the top-level module for the Sudoku Master
// game.

module tb_sudokuMasterTop ();
	reg CLK, RST;	

	reg [3:0] userNum;

	reg upButton, downButton, leftButton, rightButton;

	reg writeSwitch;
	
	wire [6:0] userNumDisp;

	wire wpInd;

	wire [27:0] rowDisp;

	wire winInd;

	wire [15:0] rowNums;
	wire [3:0] currentNum;

	sudokuMasterTop DUT_sudokuMasterTop(userNum,upButton,downButton,leftButton,rightButton,writeSwitch,userNumDisp,wpInd,rowDisp,winInd,rowNums,currentNum,CLK,RST);
endmodule
