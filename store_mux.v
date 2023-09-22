`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.08.2023 23:59:21
// Design Name: 
// Module Name: store_mux
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


module store_mux(RS2,Store_sel,data_out);
input [31:0] RS2;
input [1:0] Store_sel;
output [31:0] data_out;
wire [7:0] i0;
wire [15:0] i1;    // connect lower two bits of funct3 to Store_sel
wire [31:0] i2;
assign i0 = RS2[7:0];
assign i1 = RS2[15:0];
assign i2 = RS2[31:0];
assign data_out = Store_sel[1] ? (Store_sel[0] ? 32'bx:i2 ) :( Store_sel[0] ? {{16{i1[15]}},i1}:{{24{i0[7]}},i0});

endmodule
