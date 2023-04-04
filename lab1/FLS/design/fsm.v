// ״̬��������״̬, �ֱ�Ϊ initiated, a_loaded, b_loaded, ���Ϊ��ǰ״̬
module fsm(      
    input clk,
    input rst,
    input en,
    output [1:0] state
);
    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    parameter initiated = 2'b00;
    parameter a_loaded = 2'b01;
    parameter b_loaded = 2'b10;

    // 1. ״̬ת��
    always @(posedge clk) begin
        if (rst) curr_state <= initiated;
        else if (en) curr_state <= next_state;
    end

    // 2. ��һ״̬ NS
    always @(curr_state) begin
        case (curr_state)
            initiated: next_state = a_loaded;
            a_loaded: next_state = b_loaded;
            b_loaded: next_state = b_loaded;
            default: next_state = initiated;
        endcase
    end

    // 3. ����߼�
    assign state = curr_state;
endmodule