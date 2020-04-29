//ECE5440
//Jon Genty 2849
//button_shaper_tb
//Module tests the button_shaper module

`timescale 1ns/1ns
module tb_button_shaper();
	reg clk,rst,Btt_in;
	wire Btt_out;
	button_shaper DUT_button_shaper_1(clk,rst,Btt_in,Btt_out);
	initial begin
		clk=0;
		rst=1;
		Btt_in=0;
	end
	always begin
		#10 clk=1;
		#10 clk=0;
	end
	initial begin
		//Begins in Initial State
		#15 Btt_in=1;//Pushes to the Pulse State
		#40 // Pushes to Wait State
		#40 Btt_in=0;//Pushes to Initial State
		#80 Btt_in=1;//Pushes to the Pulse State
		#120 Btt_in=0;
	end
endmodule