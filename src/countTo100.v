/*
ECE 5440
Nick Treviño - 2389
countTo100
this module outputs a pulse for every 100 input pulses
*/

module countTo100(inputPulse, outputPulse, rst);
	input [0:0] inputPulse,rst;

	output [0:0] outputPulse;
	reg    [0:0] outputPulse;

	reg [7:0] cycleCount;

	always@(inputPulse,rst) begin
		if(rst == 1'b1) begin
			cycleCount = 8'b00000000;
			outputPulse = 1'b0;
		end
		else
			if(cycleCount < 2*3 - 1) begin	//replace 3 with 100
				cycleCount = cycleCount + 8'b00000001;
				outputPulse = 1'b0;		
			end
			else begin
				cycleCount = 8'b00000000;
				outputPulse = 1'b1;
			end
	end
endmodule
