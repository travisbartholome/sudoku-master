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
	RamAddr, RamDat, RamWriteBit, RamWriteBuf,

	// system clock and reset
	CLK, RST);

	input CLK, RST;


	//-----User inputs-----
	// hex digit to be written into selected location
	input [3:0] userNum;
	// buttons to navigate the board
	input upButton, downButton, leftButton, rightButton;
	// bit indicating that userNum should be written to selected location
	input writeBit;


	//-----Display output-----
	// current row to be displayed to the user (4 hex digits)
	output [15:0] currentRow;
	// current selected digit in the row (as a bit), tells display decoder which to blink
	output [3:0] currentNum;
	reg [3:0] currentNum;
	// indicator that the current position cannot be written to
	output noWrite;
	reg noWrite;


	//-----Memory interface----
	// The current status of the game is stored in a RAM with 4 24-bit words.
	// Each word represents one row of the board. The uppermost 4 bits indicate
	// whether each following number is write-protected (i.e. 0100 indicates that
	// the number in the second column of the row is write-protected). The next 4 bits
	// indicate whether an entry is blank (1=blank). The remaining
	// 16 bits represent four 4-bit hex numbers (0=blank) in each column of the row.
	//
	// example: word 0x431200 represents row 1 2 _ _, where the 1 is user-entered and the 
	// 2 was present on game start and is write-protected, and the other two columns are blank.

	// RAM R/W address, selects the game row
	output [1:0] RamAddr;
	reg [1:0] RamAddr;
	// RAM R/W bit
	output RamWriteBit;
	reg RamWriteBit;
	// Data read from RAM
	input [23:0] RamDat;
	// split out write protect bits and blank indicators from data
	wire [3:0] writeProtect = RamDat[23:20];
	wire [3:0] blankInd = RamDat[19:16];
	assign currentRow = RamDat[15:0];
	// RAM write buffer because we have to write a whole word back into RAM,
	// but we only want to change 4 bits of the word
	output [23:0] RamWriteBuf;
	reg [23:0] RamWriteBuf;


	// sequential logic for moving through stored values and writing new ones
	always @(posedge CLK) begin
		// synchronize RamDat buffer reg
		RamWriteBuf <= RamDat;
		if (RST) begin // positive-logic reset
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
					'h1: RamWriteBuf[3:0] <= userNum;
					'h2: RamWriteBuf[7:4] <= userNum;
					'h4: RamWriteBuf[11:8] <= userNum;
					'h8: RamWriteBuf[15:12] <= userNum;
					default: RamWriteBuf <= RamWriteBuf;
				endcase
				// only write if current loc is not write protected
				if (currentNum != writeProtect) begin
					RamWriteBit <= 1;
					noWrite <= 0;
					RamWriteBuf[19:16] <= blankInd & ~currentNum;
				end
				else begin
					noWrite <= 1;
					RamWriteBit <= 0;
				end
			end
			else begin
				RamWriteBit <= 0;
				noWrite <= 0;
				if (leftButton) begin
					if(currentNum==4'b0000) begin
						currentNum<=4'b0001;
					end
					else begin
						// can't use <</>> because we need rotation
						currentNum <= {currentNum[2:0], currentNum[3]};
					end
				end
				else if (rightButton) begin
					if(currentNum==4'b0000) begin
						currentNum<=4'b0001;
					end
					else begin
						currentNum <= {currentNum[0], currentNum[3:1]};
					end
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
endmodule