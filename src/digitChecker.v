module digitChecker(
  // Digit to be checked
  digit,
  
  // 4-bit binary value where each bit indicates that
  // a number has been found in the relevant group of
  // 4 digits (i.e., row, column, or square)
  groupCorrect);
  
  // 4-bit input digit
  input [3:0] digit;
  
  // TODO: should this be an output? I want it to be defined elsewhere
  output [3:0] groupCorrect;
  reg [3:0] groupCorrect;
  
  always @ (digit) begin
    // Check digit, assign result to groupCorrect
    case (digit)
      1: begin groupCorrect <= groupCorrect | 4'b0001; end
      2: begin groupCorrect <= groupCorrect | 4'b0010; end
      3: begin groupCorrect <= groupCorrect | 4'b0100; end
      4: begin groupCorrect <= groupCorrect | 4'b1000; end
      default: begin groupCorrect <= groupCorrect; end
    endcase
  end
endmodule
