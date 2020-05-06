// ECE 5367
// Group: Sudoku Master
//
// This module implements the top-level architecture for the Sudoku Master
// game.

module sudokuMasterTop (

	// inputs
	userNum, b_upButton, b_downButton, b_leftButton, b_rightButton, writeSwitch,

	// outputs
	userNumDisp, wpInd, rowDisp, winInd,time_onesDisp,time_tensDisp,
	//additional output
	rowNums, currentNum,time_ones,time_tens,
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

	// 2 7-segs showing the timer 
	output [6:0] time_onesDisp,time_tensDisp;

	//-----additional output declaration for debugging purposes//
	output [15:0] rowNums;
	output [3:0] currentNum,time_ones,time_tens;
	//-----end of additional output declaration----------------//

	//button shaper instats for navigation buttons
	// internal signals for the interface controller //

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
       	wire [23:0] controllerRamDatIn;
	wire [23:0] controllerRamDatOut;
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

    wire gameStart,timerPulse,winInd;
    GameBegin GameBeginSignal(CLK,RST,winInd,upButton,downButton,leftButton,rightButton,writeSwitch,gameStart);
    oneSecTimer oneSecPulse(gameStart,CLK,RST,timerPulse);
    // Clock instat
    wire [3:0] time_tens, time_ones;
    wire borrow_end1, borrow_end2; // wire to ground
    digitClock_2 gameClock (
        .reconf(RST),
        .count_default1(0),
        .count_default2(0),
        .borrow_up(borrow_end1),
        .borrow_dn(timerPulse),
        .noborrow_up(1),
        .noborrow_dn(borrow_end2),
        .count_tens(time_tens),
        .count_ones(time_ones)
    );
		
	//digitBlinker instantiations
	wire [27:0] rowDispTemp;	//signal from decoder to blinkers
	digitBlinker blinker1(currentNum[0],rowDispTemp[6:0],rowDisp[6:0],CLK,RST);
	digitBlinker blinker2(currentNum[1],rowDispTemp[13:7],rowDisp[13:7],CLK,RST);
	digitBlinker blinker3(currentNum[2],rowDispTemp[20:14],rowDisp[20:14],CLK,RST);
	digitBlinker blinker4(currentNum[3],rowDispTemp[27:21],rowDisp[27:21],CLK,RST);

	// seven segment decoder instantiations
	Seven_Seg userNumDisp_SS(userNum,userNumDisp);

	Seven_Seg rowDisp1_SS(rowNums[3:0],rowDispTemp[6:0]);
	Seven_Seg rowDisp2_SS(rowNums[7:4],rowDispTemp[13:7]);
	Seven_Seg rowDisp3_SS(rowNums[11:8],rowDispTemp[20:14]);
	Seven_Seg rowDisp4_SS(rowNums[15:12],rowDispTemp[27:21]);

	Seven_Seg onesDisp(time_ones,time_onesDisp);
	Seven_Seg tensDisp(time_tens,time_tensDisp);
endmodule