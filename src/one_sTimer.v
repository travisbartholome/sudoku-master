//ECE5440
//Jon Genty 2849
//one_sTimer
//Module waits 1 s when the enable input is high and then
//outputs a single pulse

module one_sTimer(clk,rst,enable,one_sTimeOut);
	input clk,rst,enable;
	output one_sTimeOut;
	wire one_sTimeOut,hundred_msTimeOut;

	countTo10 countTo10_1(clk,rst,enable,hundred_msTimeOut,one_sTimeOut);
	hundred_msTimer hundred_msTimer_1(clk,rst,enable,hundred_msTimeOut);	
endmodule
