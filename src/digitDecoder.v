module digitDecoder(digit, decodedValue);
  // 4-bit input number, which should be between decimal 1-4 inclusive
  input [3:0] digit;
  
  // 4-bit binary value, decoded result
  output [3:0] decodedValue;
  reg [3:0] decodedValue;
  
  always @ (digit) begin
    // Decode input digit, assign result to decodedValue
    case (digit)
      4'h1: begin decodedValue = 4'b0001; end
      4'h2: begin decodedValue = 4'b0010; end
      4'h3: begin decodedValue = 4'b0100; end
      4'h4: begin decodedValue = 4'b1000; end
      default: begin decodedValue = 4'b0000; end
    endcase
  end
endmodule
