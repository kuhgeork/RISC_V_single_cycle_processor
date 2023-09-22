`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2023 21:11:18
// Design Name: 
// Module Name: Ultimate_risc_tb
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


module Ultimate_risc_tb();

reg clk;
reg reset;
wire [31:0] PC,ALU_out;

RISC dut(clk,reset,PC,ALU_out);


initial 
begin
clk = 1'b0;
forever #20 clk = ~clk;
end


initial
begin
#5 reset = 1'b1;
#10 reset = 1'b0;
#150 $finish;
end





endmodule
