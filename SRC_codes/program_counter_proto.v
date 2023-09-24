`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.08.2023 15:47:57
// Design Name: 
// Module Name: program_counter_proto
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module mux_4to1(in0,in1,in2,in3,sel,out);
input [31:0] in0;
input [31:0] in1;
input [31:0] in2;
input [31:0] in3;
input [1:0] sel;
output reg [31:0] out;

always @*
begin
case(sel)
2'b00 : out = in0;
2'b01 : out = in1;
2'b10 : out = in2;
2'b11 : out = in3;
endcase

end
endmodule

module adder(in0,in1,out);
input  [31:0] in0;
input  [31:0] in1;
output reg [31:0] out;

always @*
out = in0 + in1;
endmodule

module program_counter_proto(clk,reset,PC,imm_ext,PCplus4,PCtarget,PC_ALU_out_JALR,PC_src);
input clk;
input reset;
input [1:0] PC_src;
input [31:0] imm_ext;
wire [31:0] PC_next;
input [31:0] PC_ALU_out_JALR;
output reg [31:0] PC;
output  [31:0] PCplus4;
output  [31:0] PCtarget;

adder a1(PC,32'd4,PCplus4);
adder a2(PC,imm_ext,PCtarget);

mux_4to1 m1(PCplus4,PCtarget,PC_ALU_out_JALR,,PC_src,PC_next);

always @(posedge clk or posedge reset)
begin
if(reset)
PC <= 32'd0;
else
PC <= PC_next;
end


endmodule


