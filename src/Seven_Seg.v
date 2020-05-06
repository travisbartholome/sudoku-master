//ECE5367
//Group: Sudoku Master
//Seven_Seg
//Module converts a 4-bit binary input (Seg_in) 
//into a 7-bit binary output (Seg_out) on a 
//seven segment display
module Seven_Seg (Seg_in, Seg_out);
	input[3:0] Seg_in;
	//input authRed,authGreen;
	output[6:0] Seg_out;
	reg[6:0] Seg_out;

	always @ (Seg_in)
		begin
			case(Seg_in)
			4'b0000:begin Seg_out=7'b1000000;end
			4'b0001:begin Seg_out=7'b1111001;end
			4'b0010:begin Seg_out=7'b0100100;end
			4'b0011:begin Seg_out=7'b0110000;end
			4'b0100:begin Seg_out=7'b0011001;end
			4'b0101:begin Seg_out=7'b0010010;end
			4'b0110:begin Seg_out=7'b0000010;end
			4'b0111:begin Seg_out=7'b1011000;end
			4'b1000:begin Seg_out=7'b0000000;end
			4'b1001:begin Seg_out=7'b0010000;end
			4'b1010:begin Seg_out=7'b0001000;end
			4'b1011:begin Seg_out=7'b0000011;end
			4'b1100:begin Seg_out=7'b1000110;end
			4'b1101:begin Seg_out=7'b0100001;end
			4'b1110:begin Seg_out=7'b0000110;end
			4'b1111:begin Seg_out=7'b0001110;end
			default:begin Seg_out=7'b1111111;end
			endcase
		end
endmodule

