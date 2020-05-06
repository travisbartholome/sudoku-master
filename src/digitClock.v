//ECE5367
//Group: Sudoku Master
// Module: digitClock
// Description: scalable digit timer for the FPGA game.
//  timer talks to adjacent digits to determine next value

/*  Visual showing how the timer chains together.
    Connect the larger-value digit to the left, lesser to the right.
                     _____
    borrow_up   <---|     |<--- borrow_dn
                    | d_T |
    noborrow_up --->|_____|---> noborrow_dn
*/
// the timer counts down via a pulse from its borrow_dn wire connected to either a 
// less significant digit timer or a 1s clock cycle.

// borrow == "i want to borrow"
// noborrow == "you cannot borrow"

module digitClock (
    reconf, count_default,
    borrow_up, borrow_dn,
    noborrow_up, noborrow_dn,
    count
    );

    input borrow_dn, noborrow_up, reconf;
    input [3:0] count_default;
    output borrow_up, noborrow_dn;
    output [3:0] count;

    reg borrow_up, noborrow_dn;
    reg [3:0] count;

    always @ (posedge borrow_dn, posedge reconf) begin
        if (reconf == 1'b1)
        begin
            if(count_default > 9)
            begin
                count <= 4'b0000;
                noborrow_dn <= 1'b0;
            end
            else begin
                count <= count_default;
                if(count_default == 0)
                begin
                    noborrow_dn <= 1'b1;
                end
                else begin
                    noborrow_dn <= 1'b0;
                end
            end
            borrow_up <= 1'b1;
        end
        else begin
            if (count == 4'b1001)
            begin
                if (noborrow_up == 1'b0)
                begin
                    // back up to 0, signal to slave digit
                    count <= 4'b0000;
                    borrow_up <= 1'b1;
                    noborrow_dn <= 1'b0;
                end
                else begin
                    borrow_up <= 1'b1;
                    noborrow_dn <= 1'b1;
                end
            end
            else begin
                // no edge cases here, subtract when asked by child timer (borrow_dn pulse)
                count <= count + 4'b0001;
                borrow_up <= 1'b0;
                noborrow_dn <= 1'b0;
            end
        end
    end
endmodule