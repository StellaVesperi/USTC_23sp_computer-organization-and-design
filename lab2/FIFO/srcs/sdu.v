module segplay_unit(
    input clk_100mhz,
    input [3:0] data,
    input [7:0] valid,
    output reg [2:0] addr,
    output [2:0] segplay_an,
    output [3:0] segplay_data
);
    //给时钟降速
    wire clk_400hz;
    reg [17:0] clk_cnt;
    assign clk_400hz = ~(|clk_cnt); //clk_400hz = (clk_cnt == 0)
    always @(posedge clk_100mhz) begin
        if (clk_cnt >= 18'h3D08F) begin //clk_cnt >= 249999
            clk_cnt <= 18'h00000;
            addr <= addr + 3'b001;
        end else
            clk_cnt <= clk_cnt + 18'h00001; 
    end
    //显示输出
    reg [2:0] segplay_an_reg;
    reg [3:0] segplay_data_reg;
    always @(posedge clk_100mhz) begin
        if (clk_400hz && valid[addr]) begin
            segplay_an_reg <= addr;
            segplay_data_reg <= data;
        end
    end
    assign segplay_data = (|valid) ? segplay_data_reg : 4'h0;
    assign segplay_an = (|valid) ? segplay_an_reg : 3'h0;
endmodule