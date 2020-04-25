//ECE5440
//Jon Genty 2849
//one_msTimer
//Module waits 1 ms when the enable is high and then 
//outputs a singe pulse 1 ms

module one_msTimer(clk,rst,enable,timeOut);
	input clk,rst,enable;
	output timeOut;
	reg timeOut;
	reg [15:0] count;
	reg [15:0] term;
	always @(posedge clk)
		begin
		term<=50000;
		if(rst==0)
			begin
			timeOut<=0;
			count<=1;
			end
		else
			begin
			if(enable==0)
				begin
				timeOut<=0;
				count<=1;
				end
			else
				begin
				if(count<(term))
					begin
					timeOut<=0;
					count<=count+1;
					end
				else if(count==(term))
					begin
					timeOut<=1;
					count<=1;
					end
				end
			end
		end
endmodule
