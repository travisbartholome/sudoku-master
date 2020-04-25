//ECE5440
//Jon Genty 2849
//countTo10
//Module counts the pulses from sigIn and once the count
//reaches 10 outputs a pulse to sigOut

module countTo10(clk,rst,enable,sigIn,sigOut);
	input clk,rst,enable,sigIn;
	output sigOut;
	reg sigOut;
	reg [3:0] count;
	reg [3:0] term;

	always @(posedge clk)
		begin
		term<=10;
		//term<=2;
		if(rst==1'b0)
			begin
			sigOut<=0;
			count<=1;
			end
		else
			begin
			if(enable==0)
				begin
				sigOut<=0;
				count<=1;
				end
			else
				begin
				if(sigIn==1'b1)
					begin
					if(count<(term))//if(count==10)
						begin
						sigOut<=0;
						count<=count+1;
						end
					else if(count==(term))
						begin
						sigOut<=1;
						count<=1;
						end
					end
				else	
					begin
					sigOut<=0;
					end
				end
				
			end	
		end
endmodule