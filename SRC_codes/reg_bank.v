`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2023 20:54:57
// Design Name: 
// Module Name: reg_bank
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


// 32 bit register bank
// 32 bit register bank
module register_file (
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input clk,
    input write_enable,
    input [31:0] write_register_data,
    output [31:0] read_register_data_1,
    output [31:0] read_register_data_2
);

reg [31:0] registers[0:31];
integer i;
initial
begin
    for ( i = 0; i < 32; i = i + 1) 
        registers[i] <= 32'd0;

            
            
end



assign read_register_data_1 = registers[rs1];
assign read_register_data_2 = registers[rs2];


always @(posedge clk) begin
    if (write_enable) begin
        registers[rd] <= write_register_data;
    end
end



endmodule
