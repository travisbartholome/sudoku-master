//ECE5440
//Jon Genty 2849
//hundred_msTimer
//Module waits 100 ms and then outputs a single pulse ever 100 ms
module hundred_msTimer(clk,rst,enable,hundred_msTimeOut);
	input clk,rst,enable;
	output hundred_msTimeOut;
	wire one_msTimeOut,hundred_msTimeOut;

	countTo100 countTo100_1(clk,rst,enable,one_msTimeOut,hundred_msTimeOut);
	one_msTimer one_msTimer_1(clk,rst,enable,one_msTimeOut);
endmodule
