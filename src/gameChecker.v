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
  
  // Bit indicating game completion
  output gameComplete;
  reg gameComplete;
  
  // ~~~~~ Game checker logic ~~~~~

  // TODO: game checker logic
  
  // TODO: should this be an every-clock-cycle thing? or is that too much?
  always @ (posedge CLK) begin
    
  end
endmodule
