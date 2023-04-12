module list_control_unit(
    input clk,         
    input rst,  //ͬ����λ
    input [3:0] in,
    input enq,  //���
    input deq,  //����
    input [3:0]  rd,        
    output full,
    output emp,         
    output reg [3:0] out,  //��������
    output [2:0] ra,       
    output we,          
    output [2:0] wa,          
    output [3:0]  wd,          
    output reg [7:0] valid
);
    reg [2:0] head;  //ͷָ��
    reg [2:0] tail;  //βָ��

    assign full = &valid;
    assign emp = ~(|valid);

    assign ra = head;
    assign we = enq & ~full & ~rst;
    assign wa = tail;
    assign wd = in; 
    
    always @(posedge clk) begin
        if (rst) begin
            valid <= 8'h00;
            head <= 3'h0;
            tail <= 3'h0;
            out <= 3'h0;
        end
        else if(enq & ~full) begin
            valid[tail] <= 1'b1;
            tail <= tail + 3'h1;
        end
        else if(deq & ~emp) begin
            valid[head] <= 1'b0;
            head <= head + 3'h1;
            out <= rd;
        end
    end
endmodule