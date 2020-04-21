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
  
  // 24-bit word data read from RAM, represents one game row
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

  // Buffer regs to hold past data retrieved from RAM
  reg [15:0] ramDigits00 = 0'h0000;
  reg [15:0] ramDigits01 = 0'h0000;
  reg [15:0] ramDigits10 = 0'h0000;
  reg [15:0] ramDigits11 = 0'h0000;

  // Row correctness checkers (no extra wires needed, buffer regs already hold the row digits)
  wire rowCorrect00, rowCorrect01, rowCorrect10, rowCorrect11;
  groupChecker rowChecker00(ramDigits00, rowCorrect00);
  groupChecker rowChecker01(ramDigits01, rowCorrect01);
  groupChecker rowChecker10(ramDigits10, rowCorrect10);
  groupChecker rowChecker11(ramDigits11, rowCorrect11);

  // Column wires
  wire [15:0] colDigits00 = {ramDigits00[3:0], ramDigits01[3:0], ramDigits10[3:0], ramDigits11[3:0]};
  wire [15:0] colDigits01 = {ramDigits00[7:4], ramDigits01[7:4], ramDigits10[7:4], ramDigits11[7:4]};
  wire [15:0] colDigits10 = {ramDigits00[11:8], ramDigits01[11:8], ramDigits10[11:8], ramDigits11[11:8]};
  wire [15:0] colDigits11 = {ramDigits00[15:12], ramDigits01[15:12], ramDigits10[15:12], ramDigits11[15:12]};

  // Column correctness checkers
  wire colCorrect00, colCorrect01, colCorrect10, colCorrect11;
  groupChecker colChecker00(colDigits00, colCorrect00);
  groupChecker colChecker01(colDigits01, colCorrect01);
  groupChecker colChecker10(colDigits10, colCorrect10);
  groupChecker colChecker11(colDigits11, colCorrect11);

  // Sub-square wires
  wire [15:0] sqrDigits00 = {ramDigits00[7:0], ramDigits01[7:0]}; // "Top right"
  wire [15:0] sqrDigits01 = {ramDigits00[15:8], ramDigits01[15:8]}; // "Top left"
  wire [15:0] sqrDigits10 = {ramDigits10[7:0], ramDigits11[7:0]}; // "Bottom right"
  wire [15:0] sqrDigits11 = {ramDigits10[15:8], ramDigits11[15:8]}; // "Bottom left"

  // Sub-square correctness checkers
  wire sqrCorrect00, sqrCorrect01, sqrCorrect10, sqrCorrect11;
  groupChecker sqrChecker00(sqrDigits00, sqrCorrect00);
  groupChecker sqrChecker01(sqrDigits01, sqrCorrect01);
  groupChecker sqrChecker10(sqrDigits10, sqrCorrect10);
  groupChecker sqrChecker11(sqrDigits11, sqrCorrect11);

  // TODO: should this be an every-clock-cycle thing? or is that too much?
  always @ (posedge CLK) begin
    // Read the digits out of a word from RAM into the appropriate reg
    case (RamAddr)
      2'b00: begin ramDigits00 = rowDigits; end
      2'b01: begin ramDigits01 = rowDigits; end
      2'b10: begin ramDigits10 = rowDigits; end
      2'b11: begin ramDigits11 = rowDigits; end
      default: begin RamAddr = RamAddr; end
    endcase

    // Increment RamAddr so the next word from RAM is read on the next cycle
    RamAddr = RamAddr + 1;

    // Compute correctness of the game state
    if (rowCorrect00 && rowCorrect01 && rowCorrect10 && rowCorrect11 &&
        colCorrect00 && colCorrect01 && colCorrect10 && colCorrect11 &&
        sqrCorrect00 && sqrCorrect01 && sqrCorrect10 && sqrCorrect11) begin
      gameComplete = 1'b1;
    end
    else begin
      gameComplete = 1'b0;
    end
  end
endmodule
