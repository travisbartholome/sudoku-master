// ECE 5367
// Group: Sudoku Master
// Module: Group checker test bench

`timescale 1ns/100ps

module tb_groupChecker();
  reg [15:0] groupDigits;
  wire groupCorrect;
  reg CLK = 1'b0;
  reg [7:0] cycleCounter = 0;

  groupChecker DUT_groupChecker(CLK, groupDigits, groupCorrect);

  initial begin
    groupDigits = 16'h0000;
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1111; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1231; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1324; // Valid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1221; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h4411; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h0231; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h0024; // Invalid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1423; // Valid
    repeat (2) @(posedge CLK);
    groupDigits = 16'h1433; // Invalid
    repeat (2) @(posedge CLK);
  end
  
  // Test clock (50 MHz)
  always begin
    if (cycleCounter < 50) begin
      #10; CLK <= !CLK;
      cycleCounter <= cycleCounter + 1;
    end
  end
endmodule
