`timescale 1ns/100ps

module gameChecker_tb();
  wire [1:0] RamAddr;
  reg [23:0] RamDat;
  wire gameComplete;
  reg CLK = 1'b0;
  reg [31:0] cycleCounter = 0;

  gameChecker DUT_gameChecker(
    .RamAddr(RamAddr),
    .RamDat(RamDat),
    .gameComplete(gameComplete),
    .CLK(CLK)
  );

  initial begin
    CLK <= 0;
    RamDat <= 24'h000000;
    #100;
    RamDat <= 24'h001111; // Invalid
    #100;
    RamDat <= 24'h001231; // Invalid
    #100;
    RamDat <= 24'h001324; // Should be valid
    #100;
    RamDat <= 24'h001221; // Invalid
    #100;
  end
  
  // Test clock
  // TODO: is this an okay way to handle CLK in a test bench?
  always @* begin
    if (cycleCounter < 125) begin
      #5; CLK <= !CLK;
      cycleCounter <= cycleCounter + 1;
    end
  end
endmodule
