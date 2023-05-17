`timescale 1ns / 1ps

module branch(
input [31:0] op1,op2,
input [2:0] br_type,
output reg br //是否分支
);
always @(*) begin
    case (br_type)
        3'b000: br=0;
        3'b001: //beq
        begin
            if(op1==op2) br=1;
            else br=0;
        end
        3'b010: //blt //有符号数比较
        begin
            if(~(op1[31]^op2[31]))//均为正或均为负
                br=(op1<op2?4'b01:4'b0);//和无符号数比较相同
            else if(op1[31]&&!op2[31])
                br=1;
            else 
                br=0;
        end
        3'b011://bne 不等时分支
        begin
            if(op1!=op2) br=1;
            else br=0;
        end
        3'b100://bgeu 无符号大于等于时分支
        begin
            if(op1>=op2) br=1;
            else br=0;
        end
        3'b101://bltu 无符号小于时分支
        begin
            if(op1<op2) br=1;
            else br=0;
        end
        default: br=0;
    endcase
end
endmodule
