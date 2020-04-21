// ECE 5367
// Group: Sudoku Master
// Module: Group checker
// Checks a group of 4 digits to see if each digit is unique and in the range [1,4]

module groupChecker(groupDigits, groupCorrect);
  // 16-bit word of inputs
  // Every 4 bits represents one digit in a group of 4 digits
  // E.g., if we're checking the row with values [1 2 3 4],
  // groupDigits would be 16'h1234
  input [15:0] groupDigits;

  // Output whether or not the group is "correct" (contains
  // exactly one of each number from 1-4 inclusive
  output groupCorrect = 1'b0;
  reg groupCorrect;

  // ~~~~~ Logic ~~~~~
  
  // Break off individual digits
  wire [3:0] digit1 = groupDigits[3:0];
  wire [3:0] digit2 = groupDigits[7:4];
  wire [3:0] digit3 = groupDigits[11:8];
  wire [3:0] digit4 = groupDigits[15:12];

  reg [3:0] groupDecoded = 4'b0000;
  
  wire [3:0] digit1Decoded;
  wire [3:0] digit2Decoded;
  wire [3:0] digit3Decoded;
  wire [3:0] digit4Decoded;
  
  digitDecoder digit1Check(digit1, digit1Decoded);
  digitDecoder digit2Check(digit2, digit2Decoded);
  digitDecoder digit3Check(digit3, digit3Decoded);
  digitDecoder digit4Check(digit4, digit4Decoded);

  always @ (groupDigits) begin
    groupDecoded = digit1Decoded | digit2Decoded | digit3Decoded | digit4Decoded;
    
    // Check if all digits were present
    if (groupDecoded == 4'b1111) begin
      // If so, group is correct
      groupCorrect = 1'b1;
    end
    else begin
      groupCorrect = 1'b0;
    end
  end
endmodule
