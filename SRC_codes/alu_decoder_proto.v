`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.08.2023 13:11:01
// Design Name: 
// Module Name: alu_decoder_proto
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


module alu_decoder_proto(opcode,ALU_op,funct7,funct3,ALU_ctrl);
input [6:0] opcode;
input [1:0] ALU_op;
input [6:0] funct7;
input [2:0] funct3;
output reg [3:0] ALU_ctrl;


always @*
begin
case (ALU_op)
2'b00: ALU_ctrl <= 4'b0010;
2'b01: ALU_ctrl <= 4'b0110;
2'b10:
begin
if (funct3 == 3'b000)
begin
if (opcode[5] == 1'b0)
ALU_ctrl <= 4'b0010;
else if(opcode[5] == 1'b1)
begin
if (funct7[5] == 1'b0)
ALU_ctrl<= 4'b0010;
else if(funct7[5] == 1'b1)
ALU_ctrl <= 4'b0110;
end
end
else if(funct3 == 3'b101)
begin
if(funct7[5] == 1'b0)
ALU_ctrl <= 4'b0100;
else if(funct7[5] == 1'b1)
ALU_ctrl <= 4'b0101;
end
else if(funct3 == 3'b010)
ALU_ctrl <= 4'b0111;
else if(funct3 == 3'b100)
ALU_ctrl <= 4'b1000;
else if(funct3 == 3'b110)
ALU_ctrl <= 4'b0001;
else if(funct3 == 3'b111)
ALU_ctrl <= 4'b0000;
else if(funct3 == 3'b001)
ALU_ctrl <= 4'b0011;
end

endcase
end

endmodule
