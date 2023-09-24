`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2023 21:00:41
// Design Name: 
// Module Name: Data_mem
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


module data_memory (
    input [31:0] address,
    input [31:0] write_data,
    input write_enable,
    input clk,
    output [31:0] read_data
);

reg [31:0] memory[0:4095];

initial
begin
memory[0] = 32'd2;
memory[1] = 32'd3;
memory[2] = 32'd5;
end

assign read_data = memory[address[11:0]];

always @(posedge clk) 
begin

    if (write_enable) 
        memory[address[11:0]] <= write_data;
   
    
end

endmodule