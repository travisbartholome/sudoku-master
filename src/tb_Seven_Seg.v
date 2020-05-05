//ECE5440
//Jon Genty 2849
//Seven_Seg_tb
//Module tests the Seven_Seg module

`timescale 1ns/1ns
module tb_Seven_Seg();
	reg [3:0] Seg_in;
	wire [6:0] Seg_out;
	Seven_Seg DUT_Seven_Seg(Seg_in, Seg_out);
	initial
		begin
			#5 Seg_in=4'b0000;
			#5 Seg_in=4'b0001;
			#5 Seg_in=4'b0010;
			#5 Seg_in=4'b0011;
			#5 Seg_in=4'b0100;
			#5 Seg_in=4'b0101;
			#5 Seg_in=4'b0110;
			#5 Seg_in=4'b0111;
			#5 Seg_in=4'b1000;
			#5 Seg_in=4'b1001;
			#5 Seg_in=4'b1010;
			#5 Seg_in=4'b1011;
			#5 Seg_in=4'b1100;
			#5 Seg_in=4'b1101;
			#5 Seg_in=4'b1110;
			#5 Seg_in=4'b1111;
		end
endmodule
			