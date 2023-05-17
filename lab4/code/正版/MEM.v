`timescale 1ns / 1ps

module MEM(
input clk ,
// MEM Data BUS with CPU

// Instruction memory ports
input [31:0] im_addr ,
output [31:0] im_dout ,
// Data memory ports
input [31:0] dm_addr ,
input dm_we ,
input [31:0] dm_din ,
output [31:0] dm_dout ,

// MEM Debug BUS
input [31:0] mem_check_addr ,
output [31:0] mem_check_data
);

Inst_mem Inst_mem (
  .a(im_addr[9:2]),      // input wire [7 : 0] a
  .spo(im_dout)  // output wire [31 : 0] spo
);

Data_mem Data_mem(
  .a(dm_addr[9:2]),        // input wire [7 : 0] a 读写公用端口 CPU
  .d(dm_din),        // input wire [31 : 0] d CPU
  .dpra(mem_check_addr[7:0]),  // input wire [7 : 0] dpra 只读端口 PDU
  .clk(clk),    // input wire clk
  .we(dm_we),      // input wire we
  .spo(dm_dout),    // output wire [31 : 0] spo CPU
  .dpo(mem_check_data)    // output wire [31 : 0] dpo PDU
);
endmodule
