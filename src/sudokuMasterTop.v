// ECE 5367
// Group: Sudoku Master
//
// This module implements the top-level architecture for the Sudoku Master
// game.

module sudokuMasterTop (

	// inputs
	userNum, upButton, downButton, leftButton, rightButton, writeSwitch,

	// outputs
	userNumDisp, wpInd, rowDisp, winInd,

	// system clock and reset
	CLK, RST);

	input CLK, RST; // note that reset is positive-logic since we're using a switch


	//-----input declaration-----
	// 4-bit user-entered number
	input [3:0] userNum;

	// navigation buttons
	input upButton, downButton, leftButton, rightButton;

	// R/W switch
	input writeSwitch;

	
	//-----output declaration-----
	// 7-seg showing userNum
	output [6:0] userNumDisp;

	// indicator that you're trying to write to a protected spot
	output wpInd;

	// 4 7-segs showing current row
	output [23:0] rowDisp;

	// win indicator
	output winInd;


	// interface controller instat
	// hex inputs to 7-seg decoders
	wire [15:0] rowNums; 
	wire [3:0] currentNum;
	// RAM connections for interface controller
	wire [1:0] controllerRamAddr;
       	wire [19:0] controllerRamDatIn;
	wire [19:0] controllerRamDatOut;
	wire controllerRamWriteBit;	
	interfaceController controller (
		.userNum(userNum),
		.upButton(upButton),
		.downButton(downButton),
		.leftButton(leftButton),
		.rightButton(rightButton),
		.writeBit(writeSwitch),
		.currentRow(rowNums),
		.currentNum(currentNum),
		.noWrite(wpInd),
		.RamAddr(controllerRamAddr),
		.RamDat(controllerRamDatIn),
		.RamWriteBuf(controllerRamDatOut),
		.RamWriteBit(controllerRamWriteBit),
		.CLK(CLK), .RST(RST));

	// Game checker instat
	wire [1:0] checkerRamAddr;
	wire [23:0] checkerRamDat;
	gameChecker checker (
		.RamAddr(checkerRamAddr),
		.RamDat(checkerRamDat),
		.gameComplete(winInd),
		.CLK(CLK),
		.RST(RST));
	
	// RAM instat
	sudokuRAM gameRAM (
		.clock(CLK),
		// controller RAM connections
		.address_a(controllerRamAddr),
		.data_a(controllerRamDatOut),
		.wren_a(controllerRamWriteBit),
		.q_a(controllerRamDatIn),
		// checker RAM connections
		.wren_b(1'b0), // assuming checker doesn't need to write to RAM
		.address_b(checkerRamAddr),
		.data_b(), // leave this unconnected unless you're writing to RAM
		.q_b(checkerRamDat));


endmodule
