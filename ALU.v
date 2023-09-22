`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2023 11:50:45
// Design Name: 
// Module Name: ALU
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


module alu (in_a, in_b, alu_out, zero,carry, control);
	input [31:0] in_a, in_b;
	output reg [31:0] alu_out;
	output reg zero;
	output reg carry;
	
	
	input [3:0] control;
	always @ (control or in_a or in_b)
	begin
	    zero <= 1'b0;
	    carry <= 1'b0;
		case (control)
		4'b0000:begin  alu_out<=in_a&in_b; end
		4'b0001:begin  alu_out<=in_a|in_b; end
		4'b0010:begin  alu_out<=in_a+in_b; end
		4'b0011:begin  alu_out<=in_a << (in_b & 32'd31); end
		4'b0100:begin  alu_out<=in_a >> (in_b & 32'd31); end
		4'b0101:begin  alu_out<=in_a >>> (in_b & 32'd31); end
		4'b0110:begin 
		if(in_a==in_b) begin zero<= 1'b1; carry<= 1'b1; end
		else if(in_a>in_b)
		begin zero<= 1'b0; carry<= 1'b1; alu_out<=in_a-in_b; end
		else begin zero<= 1'b0; carry<= 1'b0; alu_out<=in_a-in_b; end
		end
		4'b1000:begin  alu_out<=in_a^in_b; end
		4'b0111:begin  if(in_a-in_b>=32'h8000_0000) alu_out<=32'b1; else alu_out<=32'b0; end
		
		default: begin  alu_out<=in_a; end
		endcase
	end
endmodule
