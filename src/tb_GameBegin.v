// ECE 5367
// Group: Sudoku Master
// Module: Game Begin test bench

`timescale 1ns/1ns

module tb_GameBegin();
	reg CLK,RST,WinSig,upButton,downButton,leftButton,rightButton,writeSwitch;
	wire gameStart;

	GameBegin DUT_GameBegin(CLK,RST,WinSig,upButton,downButton,leftButton,rightButton,writeSwitch,gameStart);

	initial
		begin
		CLK<=0;
		RST<=1;
		WinSig<=0;
		upButton<=0;
		downButton<=0;
		leftButton<=0;
		rightButton<=0;
		writeSwitch<=0;
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
		#20 upButton<=1;
		#20 upButton<=0;
		#40
		#20 WinSig<=1;
		#20 WinSig<=0;
		#40
		#20 downButton<=1;
		#20 downButton<=0;
		#40
		#20 WinSig<=1;
		#20 WinSig<=0;
		#40
		#20 leftButton<=1;
		#20 leftButton<=0;
		#40
		#20 WinSig<=1;
		#20 WinSig<=0;
		#40
		#20 rightButton<=1;
		#20 rightButton<=0;
		#40
		#20 WinSig<=1;
		#20 WinSig<=0;
		#40
		#20 writeSwitch<=1;
		#20 writeSwitch<=0;
		#40
		#20 WinSig<=1;
		#20 WinSig<=0;
		end
endmodule