`timescale 1ns / 1ps
module testbench();
    reg clk;
    reg we;
    reg [3:0]a;
    reg [7:0]d;    
    wire [7:0]spo;
    wire [7:0]douta0;
    wire [7:0]douta1;
    wire [7:0]douta2;
parameter PERIOD = 10;
ram test(
    .clk(clk),
    .we(we),
    .a(a),
    .d(d),
    .spo(spo),
    .douta0(douta0),
    .douta1(douta1),
    .douta2(douta2)
);
always #1 clk = ~clk;
initial begin
    clk = 0;
end
initial begin
    we = 1'b1;
    a = 4'ha;
    d = 8'h23;
    #PERIOD 
    we = 1'b1;
    a = 4'hb;
    d = 8'hf1;
    #PERIOD
    we = 1'b1;
    a = 4'hc;
    d = 8'h90;
    #PERIOD
    we = 1'b0;
    a = 4'h4;
    d = 8'h53;
    #PERIOD
    we = 1'b0;
    a = 4'h5;
    d = 8'h24;
    #PERIOD
    we = 1'b0;
    a = 4'h6;
    d = 8'h01;
    #PERIOD
    $finish;
end
endmodule