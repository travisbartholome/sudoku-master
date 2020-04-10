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
	userNum, upButton, downButton, leftButton, rightButton, writeBit,

	// display output
	currentRow, currentNum, noWrite,
	
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
	// tied to output of RAM
	output [15:0] currentRow;
	// current selected digit in the row (as a bit), tells display decoder which to blink
	output [3:0] currentNum;
	reg [3:0] currentNum;


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

	// ROM read address
	output [3:0] RomAddr;
	reg [3:0] RomAddr;
	// Data read from ROM
	input [19:0] RomDat;
	// write-protect bits from ROM
	wire [3:0] writeProtect = RomDat[19:16];
	// number data from ROM
	wire [15:0] storedConfig = RomDat[15:0];

	// RAM R/W address, selects the game row
	output [1:0] RamAddr;
	reg [1:0] RamAddr;
	// RAM R/W bit
	output RamWriteBit;
	reg RamWriteBit;
	// Data read from RAM
	input [15:0] RamDat;
	// buffer reg because we have to write a whole word back into RAM,
	// but we only want to change 4 bits of the word
	reg [15:0] RamDatReg;

	// instantiate RAM module
	// RAM module is generated from a Quartus IP core
	sudokuRAM RAM (
		.address(RamAddr),
		.clock(CLK),
		.data(RamDatReg), // input data
		.wren(RamWriteBit),
		.q(RamDat)); // output data

	// sequential logic for moving through stored values and writing new ones
	always @(posedge CLK) begin
		// synchronize RamDat buffer reg
		RamDatReg <= RamDat;
		if (RST) begin // positive-logic reset
			RomAddr <= 0;
			RamAddr <= 0;
			currentNum <= 0;
			RamWriteBit <= 0;
		end
		else begin
			// write bit takes priority over move controls, so you
			// can't move around if it's high (even if you're
			// trying to write to a protected location)
			if (writeBit) begin
				// modify relevant bits of buffer reg
				case (currentNum)
					'h0: ramDatReg[3:0] <= userNum;
					'h2: ramDatReg[7:4] <= userNum;
					'h4: ramDatReg[11:8] <= userNum;
					'h8: ramDatReg[15:12] <= userNum;
					default: ramDatReg <= ramDatReg;
				endcase
				// only write if this loc is not write protected
				RamWriteBit <= currentNum & !writeProtect;
			end
			else begin
				RamWriteBit <= 0;
				if (leftButton) begin
					// can't use <</>> because we need rotation
					currentNum <= {currentNum[2:0], currentNum[3]};
				end
				else if (rightButton) begin
					currentNum <= {currentNum[0], currentNum[3:1]};
				end
				// addition & subtraction automatically wrap around
				else if (upButton) begin
					RamAddr <= RamAddr - 1;
				end
				else if (downButton) begin
					RamAddr <= RamAddr + 1;
				end
			end
		end
	end

