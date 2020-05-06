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

	initial
		begin
		CLK<=0;
		RST<=1;
		userNum<=4'b0000;
		upButton<=1'b0;
		downButton<=1'b0;
		leftButton<=1'b0;
		rightButton<=1'b0;
		writeSwitch<=1'b0;
		end

	always
		begin
		#10 CLK<=0;
		#10 CLK<=1;
		end

	initial
		begin
		#25 RST<=0;
		#40
		#20 userNum<=4'b0100;          
		#20 writeSwitch<=1'b1;
		#20 writeSwitch<=1'b0;
		#40
		#20 downButton<=1;		    
		#20 downButton<=0;
		#40
		#20 userNum<=4'b0011;
		#20 writeSwitch<=1'b1;			
		#20 writeSwitch<=1'b0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 userNum<=4'b0010;
		#20 writeSwitch<=1'b1;
		#20 writeSwitch<=1'b0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 userNum<=4'b0001;
		#20 writeSwitch<=1'b1;
		#20 writeSwitch<=1'b0;
		#40
		#20 upButton<=1;
		#20 upButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0010;          
		#20 writeSwitch<=1'b0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0011;          
		#20 writeSwitch<=1'b0;
		#40
		#20 downButton<=1;
		#20 downButton<=0;
		#40
		#20 downButton<=1;
		#20 downButton<=0;
		#40
		#20 userNum<=4'b0001;          
		#20 writeSwitch<=1'b1;
		#20 writeSwitch<=1'b0;
		#40
		#20 downButton<=1;
		#20 downButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0010;          
		#20 writeSwitch<=1'b0;
		#40
		#20 rightButton<=1;
		#20 rightButton<=0;
		#40
		#20 rightButton<=1;
		#20 rightButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0100;          
		#20 writeSwitch<=1'b0;
		#40
		#20 rightButton<=1;
		#20 rightButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0001;          
		#20 writeSwitch<=1'b0;
		#40
		#20 upButton<=1;
		#20 upButton<=0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0011;          
		#20 writeSwitch<=1'b0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 writeSwitch<=1'b1;
		#20 userNum<=4'b0100;          
		#20 writeSwitch<=1'b0;
		end

endmodule
