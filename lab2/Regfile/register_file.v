module register_file #(
    parameter WIDTH = 32)
    (
    input  clk,             
    input  [4:0] ra0,
    output [WIDTH-1:0] rd0,      
    input  [4:0] ra1,
    output [WIDTH-1:0] rd1,     
    input  [4:0] wa,       
    input  we,              
    input  [WIDTH-1:0] wd
);
    reg [WIDTH-1:0] regfile [0:31];
    assign rd0 = regfile[ra0];
    assign rd1 = regfile[ra1];
    always @(posedge clk) 
    begin
        if (we) 
        begin
            if (wa == 0) regfile[0] <= 0;
            else regfile[wa] <= wd;
        end
    end
endmodule  