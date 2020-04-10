// ECE 5367
// Group: Sudoku Master
// Module: Interface controller
//
// This module acts as an interface controller for the Sudoku game. It
// controls which portion of the Sudoku board is displayed, and interacts with
// the ROM storing initial startup configs and the RAM storing the current
// status of the game, including mediating user writes to the RAM.

module interfaceController (

	// user inputs
	userNum, upButton, dnButton, leftButton, rightButton, writeBit,

	// display output
	currentRow,
	
	// memory interface I/Os
	RomAddr, RomDat, RamAddr, RamDat, RamWriteBit,

	// system clock and reset
	CLK, RST);

	input CLK, RST;


	//-----User inputs-----
	// hex digit to be written into selected location
	input [3:0] userNum;
	// buttons to navigate the board
	input upButton, dnButton, leftButton, rightButton;
	// bit indicating that userNum should be written to selected location
	input writeBit;


	//-----Display output-----
	// current row to be displayed to the user (4 hex digits)
	output [15:0] currentRow;


	//-----Memory interfaces----
	// There are two memories used here, a ROM that stores an initial
	// board config and a RAM that stores the current status of the game.
	//
	// The ROM contains FIXME 20-bit words. Each word defines the initial
	// configuration of one row of the game; the four highest bits define
	// whether each of the following numbers is write-protected (1=yes,
	// e.g. if we have 0100... that means only the second 4-bit number should
	// be write-protected).
	//
	// The RAM contains 4 16-bit words which define the current status of
	// the game. Its values are loaded from the ROM on game start.
	//
	// ROM read address
	output [3:0] RomAddr;
	// Data read from ROM
	input [19:0] RomDat;
	// RAM R/W address
	output [1:0] RamAddr;
	// RAM R/W bit
	output RamWriteBit;
	// Data read from RAM
	input [15:0] RamDat;
	
