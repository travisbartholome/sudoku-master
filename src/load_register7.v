//ECE5440
//Jon Genty 2849
//load_register7
//Module outputs 7-bit input, only on 
//positive clock edge and when load is high.

module load_register7(clk,reset,Load,user_in,user_out);
	input clk,reset,Load;
	input [6:0] user_in;
	output [6:0] user_out;
	reg [6:0] user_out;
	
	always @(posedge clk)
		begin
		if(reset==0)
			begin
			user_out<=7'b1111111;
			end
		else if(Load==1'b1)
			begin
			user_out<=user_in;
			end
		end
endmodule
