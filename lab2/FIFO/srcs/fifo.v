module fifo(
    input clk,   
    input rst,  
    input enq,    
    input [3:0] in,     
    input deq,    
    output [3:0] out,   
    output full,   
    output emp,   
    output [2:0] an,     
    output [3:0] seg    
);

    wire enq_edge;
    wire deq_edge;
    wire we;
    wire [2:0] ra0, ra1, wa;
    wire [3:0] rd0, rd1, wd;
    wire [7:0] valid;
  
    reg_file RF(
        .clk(clk),
        .ra0(ra0),
        .ra1(ra1),
        .we(we),
        .wa(wa),
        .wd(wd),
        .rd0(rd0),
        .rd1(rd1)
    );

    sig_edge SEDG_enq(
        .clk(clk),
        .insig(enq),
        .outedge(enq_edge)
    );
    sig_edge SEDG_deq(
        .clk(clk),
        .insig(deq),
        .outedge(deq_edge)
    );

    list_control_unit LCU(
        .clk(clk),
        .rst(rst),
        .in(in),
        .enq(enq_edge),
        .deq(deq_edge),
        .rd(rd0),
        .full(full),
        .emp(emp),
        .out(out),
        .ra(ra0),
        .we(we),
        .wa(wa),
        .wd(wd),
        .valid(valid)
    );

    segplay_unit SDU(
        .clk_100mhz(clk),
        .data(rd1),
        .valid(valid),
        .addr(ra1),
        .segplay_an(an),
        .segplay_data(seg)
    );
endmodule