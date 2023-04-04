module decoder(
    input en,
    input [1:0] sel,
    output ea, eb, ef
);
    assign ea = en & (sel == 2'b00); // 按照ppt上所示的表格分配功能
    assign eb = en & (sel == 2'b01);
    assign ef = en & (sel == 2'b10);
endmodule
