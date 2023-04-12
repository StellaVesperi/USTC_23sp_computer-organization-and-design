module sig_edge(
    input clk, 
    input insig,  //输入信号
    output sync,  //同步信号
    output outedge  //信号边沿
);
    reg in_reg_0;
    reg in_reg_1;
    reg in_reg_2;
    always @(posedge clk) begin
        in_reg_0 <= insig;
        in_reg_1 <= in_reg_0;
        in_reg_2 <= in_reg_1;
    end
    assign sync = in_reg_1;
    assign outedge = in_reg_1 & ~in_reg_2;
endmodule