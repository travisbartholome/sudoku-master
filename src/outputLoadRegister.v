module outputLoadRegister(load,blinkPulse,in,out);
	input load, blinkPulse;
	input [6:0] in;

	output [6:0] out;
	reg [6:0] out;

	always@(load,blinkPulse,in) begin
		if(load == 1'b0)			//if digit is not selected, output the data normally
			out = in;
		else begin				//if digit is selected, make it blink
			if(blinkPulse == 1'b1) begin		//if pulse is high, toggle output between blank and normal
				if(out == in)
					out = 7'b1111111;
				else
					out = in;
			end
		end
	end
endmodule
