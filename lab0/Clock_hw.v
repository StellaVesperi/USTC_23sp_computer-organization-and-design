module Clock (
    input clk,
    input rst, // asynchronous reset, active high
    output [2:0] hour,
    output [3:0] min,
    output [4:0] sec
);  // you should not change code upon this line
    // your code here
    // you may need to add some extra signals

    // think the ports needed and how to connect them
    Sec sec1();
    Min min1();
    Hour hour1();
endmodule

// implement the three modules here