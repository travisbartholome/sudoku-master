//ECE5367
//Group: Sudoku Master
// GameBegin
//This module indicates the timer when to begin timing and when to end.

module GameBegin(CLK,RST,WinSig,upButton,downButton,leftButton,rightButton,writeSwitch,gameStart);
	input CLK,RST,WinSig,upButton,downButton,leftButton,rightButton,writeSwitch;
	output gameStart;
	reg gameStart;

	always @ (CLK,upButton,downButton,leftButton,rightButton,writeSwitch)
		begin
		if(RST==1'b1)
			begin
			gameStart<=0;
			end
		else
			begin
			if(WinSig==1'b1)
				begin
				gameStart<=1'b0;
				end
			else
				begin
				gameStart<=1'b1;
				end
			end
		end
endmodule
