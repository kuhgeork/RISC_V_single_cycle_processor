`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2023 00:17:15
// Design Name: 
// Module Name: LOAD_MUX
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


module LOAD_MUX( rd_data,Load_sel, data_out);
input [31:0] rd_data;
input [1:0] Load_sel;
output [31:0] data_out;
wire [7:0] i0;
wire [15:0] i1;
wire [31:0] i2;
assign i0 = rd_data[7:0];
assign i1 = rd_data[15:0];   
assign i2 = rd_data[31:0];


assign data_out = Load_sel[1] ? (Load_sel[0] ? 32'bx:i2 ) :( Load_sel[0] ? {{16{i1[15]}},i1}:{{24{i0[7]}},i0});
endmodule
