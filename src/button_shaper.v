//ECE5440
//Jon Genty 2849
//button_shaper
//Module uses a finite state machine to convert a long button press
//to a single pulse.
module button_shaper(clk,reset,Btt_in,Btt_out);
	input clk,reset,Btt_in;
	output Btt_out;
	reg Btt_out;

	reg [1:0] State,StateNext;
	
	parameter Initial=2'b00;
	parameter Pulse=2'b01;
	parameter Wait=2'b10;

	always @(State,Btt_in)
		begin 	
		case(State)
		Initial:begin
			Btt_out<=1'b0;
			if(Btt_in==1'b0)
				begin
				StateNext<=Pulse;
				//Btt_out<=1'b1;
				end
			else if(Btt_in==1'b1)
				begin
				StateNext<=Initial;
				//Btt_out<=1'b0;
				end
			end
		Pulse:begin
				Btt_out<=1'b1;
				StateNext<=Wait;
				//Btt_out<=1'b0;
			end	
		Wait:begin
			Btt_out<=1'b0;
			if(Btt_in==1'b1)
				begin
				StateNext<=Initial;
				//Btt_out<=1'b0;
				end
			else if(Btt_in==1'b0)
				begin
				StateNext<=Wait;
				//Btt_out<=1'b0;
				end
			end
		default:begin
			Btt_out<=1'b0;
			StateNext<=Initial;
			end
		endcase
		end
	always @(posedge clk)
		begin
		if(reset==0)
			begin
			State<=Initial;
			//Btt_out<=1'b0;	
			end
		else
			begin
			State<=StateNext;
			end
		end
endmodule