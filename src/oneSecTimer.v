/*
ECE 5440
Nick Treviño - 2389
oneSecTimer
this module is the top level module for the one-second counting part of the game
*/

module oneSecTimer(enableCount,clock,reset,pulseOut10);
	input  [0:0] enableCount,clock,reset;
	output [0:0] pulseOut10;

	wire [0:0] timerOut,pulseOut100;

	one_ms_timer oneMillisecTimer	(enableCount, timerOut, clock, reset);
	countTo100   count_to_100	(timerOut,pulseOut100,reset);
	countTo10    count_to_10	(pulseOut100,pulseOut10,reset);
endmodule

