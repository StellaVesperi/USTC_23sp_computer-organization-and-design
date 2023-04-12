module ram(
    input clk,
    input we,
    input [3:0]a,
    input [7:0]d,
    output [7:0]spo,
    output [7:0]douta0,
    output [7:0]douta1,
    output [7:0]douta2
);
dist_mem_gen_0 distram(
    .clk(clk), .we(we), .a(a), .d(d), .spo(spo));
blk_mem_gen_0 blkram0(
    .clka(clk), .wea(we),.addra(a), .dina(d), .douta(douta0));
blk_mem_gen_1 blkram1(
    .clka(clk), .wea(we),.addra(a), .dina(d), .douta(douta1));
blk_mem_gen_2 blkram2(
    .clka(clk), .wea(we),.addra(a), .dina(d), .douta(douta2));
endmodule