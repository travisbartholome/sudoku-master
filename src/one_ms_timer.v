/*
ECE 5440
Nick Treviño - 2389
one_ms_timer
this module outputs a pulse every 50,000 clock cycles if enable is 1
*/

module one_ms_timer(enable, one_ms_pulse, clk, rst);
	input [0:0] enable,clk,rst;

	output [0:0] one_ms_pulse;
	reg    [0:0] one_ms_pulse;

	reg [15:0] cycleCount;

	always@(posedge clk) begin
		if(enable == 1'b0 || rst == 1'b1) begin
			cycleCount = 16'b0000000000000000;
			one_ms_pulse = 1'b0;
		end
		else
			if(cycleCount < 4 - 1) begin	//replace 4 with 50000
				cycleCount = cycleCount + 16'b0000000000000001;
				one_ms_pulse = 1'b0;		
			end
			else begin
				cycleCount = 16'b0000000000000000;
				one_ms_pulse = 1'b1;
			end
	end
endmodule
