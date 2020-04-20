// ECE 5367
// Group: Sudoku Master
// Module: interface controller testbench

`timescale 1ns/100ps

tb_interfaceController;

	// navigation buttons & R/W bit
	reg upButton, downButton, leftButton, rightButton, writeBit;

	// number input
	reg [3:0] userNum;

	// number output
	wire [3:0] currentNum;

	// row output
	wire [15:0] currentRow;

	// write pro output
	wire noWrite;

	// RAM interface
	wire [1:0] RamAddr;
	wire [23:0] RamDatIn;
	wire [23:0] RamDatOut;
	wire RamWriteBit;

	// clock and reset
	reg CLK, RST;

	// instat RAM module
	// for reference the starting sudoku in the .mif is:
	// _ _ 1 _
	// 4 _ _ _
	// _ _ _ 2
	// _ _ 3 _
	sudokuRAM RAM (
		.clock(CLK),
		.address_a(RamAddr),
		.data_a(RamDatOut),
		.wren_a(RamWriteBit),
		.q_a(RamDatIn)
		.address_b(), .data_b(), .wren_b(), .q_b());

	// instat test module
	interfaceController DUT (
		.userNum(userNum),
		.upButton(upButton),
		.downButton(downButton),
		.leftButton(leftButton),
		.rightButton(rightButton),
		.writeBit(writeBit),
		.currentRow(currentRow),
		.currentNum(currentNum),
		.noWrite(noWrite),
		.RamAddr(RamAddr),
		.RamDat(RamDatIn),
		.RamWriteBuf(RamDatOut),
		.RamWriteBit(RamWriteBit)
		.CLK(CLK), .RST(RST));

	// 50 MHz clock
	always begin
		CLK = 0;
		#10;
		CLK = 1;
		#10;
	end
				
	// testing block
	initial begin
		// establish initial values
		upButton = 0;
		downButton = 0;
		leftButton = 0;
		rightButton = 0;
		userNum = 0;
		writeBit = 0;

		// assert reset
		RST = 1;
		repeat (10) @(posedge CLK);
		RST = 0;

		// move col left twice
		@(posedge CLK) leftButton = 1;
		@(posedge CLK) leftButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) leftButton = 1;
		@(posedge CLK) leftButton = 0;
		repeat (10) @(posedge CLK);

		// move col right twice
		@(posedge CLK) rightButton = 1;
		@(posedge CLK) rightButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) rightButton = 1;
		@(posedge CLK) rightButton = 0;
		repeat (10) @(posedge CLK);

		// move row up twice
		@(posedge CLK) upButton = 1;
		@(posedge CLK) upButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) upButton = 1;
		@(posedge CLK) upButton = 0;
		repeat (10) @(posedge CLK);

		// move row down twice
		@(posedge CLK) downButton = 1;
		@(posedge CLK) downButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) downButton = 1;
		@(posedge CLK) downButton = 0;
		repeat (10) @(posedge CLK);


		// write a number
		userNum = 4'h4;
		@(posedge CLK) writeBit = 1;
		@(posedge CLK) writeBit = 0;
		repeat (10) @(posedge CLK);

		// go away, come back, see if it's still there
		@(posedge CLK) rightButton = 1;
		@(posedge CLK) rightButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) leftButton = 1;
		@(posedge CLK) leftButton = 0;
		repeat (10) @(posedge CLK);

		// move to a write-protected location and try to write there
		@(posedge CLK) rightButton = 1;
		@(posedge CLK) rightButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) rightButton = 1;
		@(posedge CLK) rightButton = 0;
		repeat (10) @(posedge CLK);

		@(posedge CLK) writeBit = 1;
		@(posedge CLK) writeBit = 0;
		repeat (10) @(posedge CLK);
	end
endmodule
