`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.08.2023 11:51:35
// Design Name: 
// Module Name: main_decoder
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
module mux4to1(in0,in1,in2,in3,sel,out);
input in0,in1,in2,in3;
input [1:0] sel;
output out;
assign out = (sel== 2'b00) ? in0 :
            (sel == 2'b01) ? in1 :
            (sel == 2'b10) ? in2 :
                             in3 ;
            

endmodule

module main_decoder(opcode,funct3,Zero,Carry,Reg_Write,Imm_src,Mem_Write,Result_src,ALU_op,ALU_src,PC_src);
input [6:0] opcode;
input [2:0] funct3;
input Zero;
input Carry;
output reg Reg_Write;
output reg [2:0] Imm_src;
output reg Mem_Write;
output reg [2:0] Result_src;
reg Branch,Jump;
output reg [1:0] ALU_op;
output reg  ALU_src;
output reg [1:0] PC_src;
reg temp;
reg temp1;
reg [1:0]sel;
always @*
begin
case (opcode)
7'b0000011: 
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b000; 
Mem_Write <= 1'b0;
Result_src <= 3'b001;
Branch <= 1'b0;
ALU_op <= 2'b00;
ALU_src <= 1'b1;
Jump <= 1'b0;
end
7'b0100011:
begin
Reg_Write<= 1'b0; 
Imm_src<= 3'b001; 
Mem_Write <= 1'b1;
Result_src <= 3'bxxx;
Branch <= 1'b0;
ALU_op <= 2'b00;
ALU_src <= 1'b1;
Jump <= 1'b0;
end
7'b0110011:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'bxxx; 
Mem_Write <= 1'b0;
Result_src <= 3'b000;
Branch <= 1'b0;
ALU_op <= 2'b10;
ALU_src <= 1'b0;
Jump <= 1'b0;
end
7'b1100011:
begin
Reg_Write<= 1'b0; 
Imm_src<= 3'b010; 
Mem_Write <= 1'b0;
Result_src <= 3'bxxx;
Branch <= 1'b1;
ALU_op <= 2'b01;
ALU_src <= 1'b0;
Jump <= 1'b0;
end
7'b0010011:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b000; 
Mem_Write <= 1'b0;
Result_src <= 3'b000;
Branch <= 1'b0;
ALU_op <= 2'b10;
ALU_src <= 1'b1;
Jump <= 1'b0;
end
7'b1101111:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b011; 
Mem_Write <= 1'b0;
Result_src <= 3'b010;
Branch <= 1'b0;
ALU_op <= 2'bxx;
ALU_src <= 1'bx;
Jump <= 1'b1;
end
7'b1100111:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b000; 
Mem_Write <= 1'b0;
Result_src <= 3'b010;
Branch <= 1'b0;
ALU_op <= 2'b00;
ALU_src <= 1'b1;
Jump <= 1'b1;
end
7'b0110111:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b100; 
Mem_Write <= 1'b0;
Result_src <= 3'b011;
Branch <= 1'b0;
ALU_op <= 2'bxx;
ALU_src <= 1'bx;
Jump <= 1'b0;
end
7'b0010111:
begin
Reg_Write<= 1'b1; 
Imm_src<= 3'b100; 
Mem_Write <= 1'b0;
Result_src <= 3'b100;
Branch <= 1'b0;
ALU_op <= 2'bxx;
ALU_src <= 1'bx;
Jump <= 1'b0;
end
endcase
if (opcode != 7'b1100111)
begin
sel <= {funct3[2],funct3[0]};
case (sel)
2'b00: temp<= Carry & Zero;
2'b10: temp <= ~Carry & ~Zero;
2'b11: temp<= Carry & ~Zero;
default: temp<= 1'b0;
endcase
temp1<= temp & Branch;
PC_src[0] <= temp1 | Jump;
PC_src[1] <= 1'b0;
end
else if(opcode == 7'b1100111)
PC_src <= 2'b10;
end




endmodule
