`timescale 10ns/100ps

module groupChecker_tb();
  reg [15:0] groupDigits;
  wire groupCorrect;

  groupChecker DUT_groupChecker(groupDigits, groupCorrect);

  initial begin
    groupDigits = 16'h0000;
    #100;
    groupDigits = 16'h1111; // Invalid
    #100;
    groupDigits = 16'h1231; // Invalid
    #100;
    groupDigits = 16'h1324; // Valid
    #100;
    groupDigits = 16'h1221; // Invalid
    #100;
    groupDigits = 16'h4411; // Invalid
    #100;
    groupDigits = 16'h0231; // Invalid
    #100;
    groupDigits = 16'h0024; // Invalid
    #100;
    groupDigits = 16'h1423; // Valid
    #100;
    groupDigits = 16'h1433; // Invalid
    #100;
  end
endmodule
