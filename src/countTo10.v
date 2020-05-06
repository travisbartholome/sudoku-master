/*
//ECE5367
//Group: Sudoku Master
countTo10
this module outputs a pulse for every 10 input pulses
*/

module countTo10(inputPulse, outputPulse, rst);
	input [0:0] inputPulse,rst;

	output [0:0] outputPulse;
	reg    [0:0] outputPulse;

	reg [4:0] cycleCount;

	always@(inputPulse,rst) begin
		if(rst == 1'b1) begin
			cycleCount = 5'b00000;
			outputPulse = 1'b0;
		end
		else
			if(cycleCount < 2*(2) - 1) begin	//replace 2 with 10
				cycleCount = cycleCount + 5'b00001;
				outputPulse = 1'b0;		
			end
			else begin
				cycleCount = 5'b00000;
				outputPulse = 1'b1;
			end
	end
endmodule
