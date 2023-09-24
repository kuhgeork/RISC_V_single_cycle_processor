`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2023 21:09:50
// Design Name: 
// Module Name: instr_mem
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


// 64 KB instruction memory 
module instruction_memory (address,instruction);
input [31:0] address;
output reg [31:0] instruction;
reg [7:0] memory[0:65535];

initial
begin
/*
*/
end

always @* 
begin
    instruction <= {memory[address[15:0]+16'd3],memory[address[15:0]+16'd2],memory[address[15:0]+16'd1],memory[address[15:0]]};
end

endmodule
