// ECE 5367
// Group: Sudoku Master
//
// This module implements the top-level architecture for the Sudoku Master
// game.

module sudokuMasterTop (

	// inputs
	userNum, b_upButton, b_downButton, b_leftButton, b_rightButton, writeSwitch,

	// outputs
	userNumDisp, wpInd, rowDisp, winInd,

	// system clock and reset
	CLK, RST);

	input CLK, RST; // note that reset is positive-logic since we're using a switch


	//-----input declaration-----
	// 4-bit user-entered number
	input [3:0] userNum;

	// navigation buttons
	input b_upButton, b_downButton, b_leftButton, b_rightButton;

	// R/W switch
	input writeSwitch;

	
	//-----output declaration-----
	// 7-seg showing userNum
	output [6:0] userNumDisp;

	// indicator that you're trying to write to a protected spot
	output wpInd;

	// 4 7-segs showing current row
	output [27:0] rowDisp;

	// win indicator
	output winInd;

	//button shaper instats for navigation buttons
	wire upButton,downButton,leftButton,rightButton;
	button_shaper upButtonShaper(
		.clk(CLK),
		.reset(RST),
		.Btt_in(b_upButton),
		.Btt_out(upButton));

	button_shaper downButtonShaper(
		.clk(CLK),
		.reset(RST),
		.Btt_in(b_downButton),
		.Btt_out(downButton));

	button_shaper leftButtonShaper(
		.clk(CLK),
		.reset(RST),
		.Btt_in(b_leftButton),
		.Btt_out(leftButton));

	button_shaper rightButtonShaper(
		.clk(CLK),
		.reset(RST),
		.Btt_in(b_rightButton),
		.Btt_out(rightButton));

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


	// Seven Segment Decoder instats
	Seven_Seg userNumLED (
		.Seg_in(userNum),
		.Seg_out(userNumDisp));

  // Clock instat
  wire [3:0] time_tens, time_ones;
  wire borrow_end1, borrow_end2; // wire to ground
  digitClock_2 gameClock (
    .reconf(winInd),
    .count_default1(0),
    .count_default2(0),
    .borrow_up(borrow_end1),
    .borrow_dn(CLK),
    .noborrow_up(1),
    .noborrow_dn(borrow_end2),
    .count_tens(time_tens),
    .count_ones(time_ones)
  );
		
  //digitBlinker dummy instant
  wire isDigitSelected;
  wire [6:0] digitInfo, digitOutput;
  digitBliker blinker(isDigitSelected,digitInfo,digitOutput,CLK,RST);

	Seven_Seg NumLED1 (
		.Seg_in(rowNums[3:0]),
		.Seg_out(rowDisp[6:0]));

	Seven_Seg NumLED2 (
		.Seg_in(rowNums[7:4]),
		.Seg_out(rowDisp[13:7]));

	Seven_Seg NumLED3 (
		.Seg_in(rowNums[11:8]),
		.Seg_out(rowDisp[20:14]));

	Seven_Seg NumLED4 (
		.Seg_in(rowNums[15:12]),
		.Seg_out(rowDisp[27:21]));
	
	
endmodule
