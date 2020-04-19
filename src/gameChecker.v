// ECE 5367
// Group: Sudoku Master
// Module: Game checker

// This module checks the Sudoku game state to determine
// whether or not the game has been completed correctly.
// It reads the game state from RAM and outputs a bit that
// indicates whether the user has won/completed the game.

module gameChecker(
  // Memory inputs
  RamAddr, RamDat,
  
  // Output
  gameComplete,
  
  // System clock
  CLK);
  
  input CLK;
  
  // RAM 2-bit address, selects game row
  output [1:0] RamAddr;
  reg [1:0] RamAddr;
  
  // 24-bit word data from RAM, represents one game row
  input [23:0] RamDat;
  
  // Split off parts of RAM data
  // Indicates if a digit is blank
  wire [3:0] blankDigits = RamDat[19:16];
  // Indicates if a digit is write-protected
  wire [3:0] writeProtect = RamDat[23:20];
  // Row digits
  wire [15:0] rowDigits = RamDat[15:0];
  
  // Break off individual digits
  wire [3:0] digit1 = rowDigits[3:0];
  wire [3:0] digit2 = rowDigits[7:4];
  wire [3:0] digit3 = rowDigits[11:8];
  wire [3:0] digit4 = rowDigits[15:12];
  
  // Bit indicating game completion
  output gameComplete;
  reg gameComplete;
  
  // ~~~~~ Game checker logic ~~~~~
  
  reg [3:0] rowCorrect;
  
  digitChecker digit1Check(digit1, rowCorrect);
  digitChecker digit2Check(digit2, rowCorrect);
  digitChecker digit3Check(digit3, rowCorrect);
  digitChecker digit4Check(digit4, rowCorrect);
  
  // TODO: game checker logic
  
  // TODO: should this be an every-clock-cycle thing? or is that too much?
  always @ (posedge CLK) begin
    rowCorrect = 4'b0000;
    
    // Check one row
    if (rowCorrect == 4'b1111) begin
      // Row is correct
      // TODO: don't set the final output high after just checking one row
      gameComplete <= 1'b1;
    end
    else begin
      gameComplete <= 1'b0;
    end
  end
endmodule
