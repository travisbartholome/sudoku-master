// ECE 5367
// Group: Sudoku Master
// Module: Game checker test bench

`timescale 1ns/100ps

module tb_gameChecker();
  wire [1:0] RamAddr;
  wire [23:0] RamDat;
  wire gameComplete;
  reg CLK, RST = 1'b0;
  reg [31:0] cycleCounter = 0;

  // Testbench memory manipulation I/O
  reg [23:0] ramInA = 24'h000000;
  wire [23:0] ramOutA;
  reg ramWrenA = 1'b1;
  reg [1:0] ramAddrA = 2'b00;

  gameChecker DUT_gameChecker(
    .RamAddr(RamAddr),
    .RamDat(RamDat),
    .gameComplete(gameComplete),
    .CLK(CLK),
    .RST(RST)
  );

  sudokuRAM RAM(
    .clock(CLK),
    // Memory port used by game checker (read-only)
    .address_b(RamAddr),
    .q_b(RamDat),
    .wren_b(1'b0),
    .data_b(),
    // Mock out memory port used by interface controller
    // Use to alter memory during testing
    .address_a(ramAddrA),
    .data_a(ramInA),
    .wren_a(ramWrenA),
    .q_a(ramOutA)
  );

  // Test logic
  initial begin
    CLK = 0;
    
    // Note: RAM starts in state determined by sudoku4x4.mif
    
    // Delay start to let checker load game state from RAM
		repeat (10) @(posedge CLK);
    // Expect gameComplete == 0 after loading

    // Write new game state to RAM (not a valid complete state, but close)
    // Format isn't technically correct but only the lowest 16 bits matter for the checker
    // 1 _ 3 4
    // 4 3 2 1
    // 3 4 1 2
    // 2 1 4 3
    @(posedge CLK) ramAddrA = 2'b00;
    @(posedge CLK) ramInA = 24'h001034;
    @(posedge CLK) ramAddrA = 2'b01;
    @(posedge CLK) ramInA = 24'h004321;
    @(posedge CLK) ramAddrA = 2'b10;
    @(posedge CLK) ramInA = 24'h003412;
    @(posedge CLK) ramAddrA = 2'b11;
    @(posedge CLK) ramInA = 24'h002143;
    // Delay to let checker read game state, at end expect gameComplete == 0
		repeat (10) @(posedge CLK);

    // Fill in the last blank in row 00, completing the game
    @(posedge CLK) ramAddrA = 2'b00;
    @(posedge CLK) ramInA = 24'h001234;
    // Delay for game checker, at end expect gameComplete == 1
		repeat (10) @(posedge CLK);

    // Mess up a couple of numbers
    @(posedge CLK) ramAddrA = 2'b01;
    @(posedge CLK) ramInA = 24'h004322;
    @(posedge CLK) ramAddrA = 2'b11;
    @(posedge CLK) ramInA = 24'h001143;
    // Delay for game checker, at end expect gameComplete == 0
		repeat (10) @(posedge CLK);
    
    // Test a second, different correct game state
    // This time it's a solution of the state from the MIF file
    // 3 2 1 4
    // 4 1 2 3
    // 1 4 3 2
    // 2 3 4 1
    @(posedge CLK) ramAddrA = 2'b00;
    @(posedge CLK) ramInA = 24'h003214;
    @(posedge CLK) ramAddrA = 2'b01;
    @(posedge CLK) ramInA = 24'h004123;
    @(posedge CLK) ramAddrA = 2'b10;
    @(posedge CLK) ramInA = 24'h001432;
    @(posedge CLK) ramAddrA = 2'b11;
    @(posedge CLK) ramInA = 24'h002341;
    // Delay for game checker, at end expect gameComplete == 1
		repeat (10) @(posedge CLK);

    // Assert game checker reset
    RST = 1;
    repeat (2) @(posedge CLK);
    RST = 0;
    repeat (10) @(posedge CLK);
  end
  
  // Test clock (50 MHz)
  always begin
    if (cycleCounter < 170) begin
      #10; CLK <= !CLK;
      cycleCounter <= cycleCounter + 1;
    end
  end
endmodule
