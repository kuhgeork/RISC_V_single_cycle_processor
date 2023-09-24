`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2023 19:39:16
// Design Name: 
// Module Name: extender
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


module extender(instr, ext_imm, imm_src);
input [31:0] instr;
input [2:0] imm_src;
output reg [31:0] ext_imm;
always @*
begin
case (imm_src)
3'b000: ext_imm = {{20{instr[31]}},instr[31:20]};
3'b001: ext_imm = {{20{instr[31]}},instr[31:25],instr[11:7]};
3'b010: ext_imm = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
3'b011: ext_imm = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
3'b100: ext_imm = {instr[31:12], 12'b0};


default: ext_imm = instr;
endcase
end
endmodule
