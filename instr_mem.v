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
/*memory[32'd0] = 8'b10010011;
memory[32'd1] = 8'b00000000;
memory[32'd2] = 8'b10100000;
memory[32'd3] = 8'b00000000;
memory[32'd4] = 8'b00010011;
memory[32'd5] = 8'b00000001;
memory[32'd6] = 8'b01000000;
memory[32'd7] = 8'b00000001;
memory[32'd8] = 8'b10110011;
memory[32'd9] = 8'b00000001;
memory[32'd10] = 8'b00010001;
memory[32'd11] = 8'b00000000;*/
end

always @* 
begin
    instruction <= {memory[address[15:0]+16'd3],memory[address[15:0]+16'd2],memory[address[15:0]+16'd1],memory[address[15:0]]};
end

endmodule
