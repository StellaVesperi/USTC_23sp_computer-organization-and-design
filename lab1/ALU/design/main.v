module main #(parameter WIDTH = 6)
(
    input clk,
    input en,
    input [1:0] sel,
    input [WIDTH - 1:0] x,
    output reg [WIDTH - 1:0] y,
    output reg z
);
    
    wire ef, ea, eb;
    wire alu_z;
    wire [WIDTH - 1:0] alu_y;
    reg [2:0] f;
    reg [WIDTH - 1:0] a, b;
    decoder dec(                   // 译码器模块      
        .en(en),
        .sel(sel),
        .ef(ef),
        .ea(ea),
        .eb(eb)
    );
    alu #(.WIDTH(WIDTH)) alu1(     // 算术逻辑单元模块
        .a(a),
        .b(b),
        .f(f),
        .y(alu_y),
        .z(alu_z)
    );
  
    always @(posedge clk) begin    
        if (ef) f <= x[2:0];
        if (ea) a <= x;
        if (eb) b <= x;
        y <= alu_y;
        z <= alu_z;
    end
endmodule