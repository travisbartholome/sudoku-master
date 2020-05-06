//ECE5367
//Group: Sudoku Master
// Module: digitClock_2
// Description: two-digit timer for use in an FPGA game.
/*  Visual showing how the timers chain together.
    Larger-value digit from the left, lower from right.
                     _____                  _____
      borrow_up <---|     |<-borrow_mid----|     |<--- borrow_dn
                    | ten |                | one |
    noborrow_up --->|_____|--noborrow_mid->|_____|---> noborrow_dn
*/
module digitClock_2(
    reconf, count_default1, count_default2,
    borrow_up, borrow_dn,
    noborrow_up, noborrow_dn,
    count_tens, count_ones
    );

    input reconf, borrow_dn, noborrow_up;
    input [3:0] count_default1, count_default2;
    //connect the two digitClocks together
    wire borrow_mid, noborrow_mid;
    output borrow_up, noborrow_dn;
    output [3:0] count_tens, count_ones;

    digitClock tens(
        reconf, count_default1,
        borrow_up, borrow_mid,
        noborrow_up, noborrow_mid,
        count_tens
    );
    digitClock ones(
        reconf, count_default2,
        borrow_mid, borrow_dn,
        noborrow_mid, noborrow_dn,
        count_ones
    );
endmodule
