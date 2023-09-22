`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.09.2023 16:23:48
// Design Name: 
// Module Name: RISC
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
//////////////////////////////////////////////////////////////////////////////////`timescale 1ns / 1ps
module mux_8to1 (
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    input wire [31:0] in4,
    input wire [31:0] in5,
    input wire [31:0] in6,
    input wire [31:0] in7,
    input wire [2:0] select,
    output wire [31:0] out
);

assign out = (select == 3'b000) ? in0 :
            (select == 3'b001) ? in1 :
            (select == 3'b010) ? in2 :
            (select == 3'b011) ? in3 :
            (select == 3'b100) ? in4 :
            (select == 3'b101) ? in5 :
            (select == 3'b110) ? in6 :
                               in7;

endmodule


module RISC(clk,reset,PC,ALU_output);

input clk;
input reset;
output [31:0] PC ;
output wire [31:0] ALU_output;
wire [31:0] ALU_out;
wire [31:0] PC_address;
wire [31:0] instruction_fetch;
wire [3:0] ALU_ctrl;
wire [31:0] PCplus4;
wire [31:0] PCtarget;
wire [6:0] funct7; 
wire [31:0] src_b;
wire [31:0] ext_imm;
wire [2:0] Imm_src;
wire [2:0] Result_src;
wire [1:0] ALU_op;
wire [1:0] PC_src;
wire [1:0] PC_src_conn;
wire [31:0] ALU_out_conn;
wire [31:0] rs1_data;
wire [31:0] rs2_data;
wire [31:0] write_reg_data;
wire reset_conn = reset;
program_counter_proto PROG_COUNTER(clk,reset_conn,PC_address,ext_imm,PCplus4,PCtarget,ALU_out_conn,PC_src_conn);
wire [31:0] PCplus4_conn = PCplus4;
wire [31:0] PCtarget_conn = PCtarget;
instruction_memory IM(PC_address,instruction_fetch);
wire Zero_conn;
wire Carry_conn;
main_decoder MD(instruction_fetch[6:0],instruction_fetch[14:12],Zero_conn,Carry_conn,Reg_Write,Imm_src,Mem_Write,Result_src,ALU_op,ALU_src,PC_src);
assign PC_src_conn = PC_src;
wire [1:0] ALU_op_conn = ALU_op;
wire Reg_Write_conn = Reg_Write;
wire [2:0] Imm_src_conn = Imm_src;
wire Mem_Write_conn = Mem_Write;
wire [2:0] Result_src_conn = Result_src;
wire ALU_src_conn = ALU_src;
assign funct7 = (instruction_fetch[6:0] == 7'b0110011) ? instruction_fetch[31:25]:7'bx;
alu_decoder_proto  AD(instruction_fetch[6:0],ALU_op_conn,funct7,instruction_fetch[14:12],ALU_ctrl);
wire [3:0] ALU_ctrl_conn = ALU_ctrl;
wire [31:0] Write_reg_data_conn;
register_file RF(instruction_fetch[19:15] , instruction_fetch[24:20] , instruction_fetch[11:7],clk,Reg_Write_conn,Write_reg_data_conn,rs1_data,rs2_data);
wire [31:0] rs1_data_conn = rs1_data;
wire [31:0] RS2_data_conn = rs2_data;
extender EXT(instruction_fetch,ext_imm,Imm_src_conn);
assign src_b = ALU_src_conn ? ext_imm : RS2_data_conn;
alu ALU(rs1_data_conn,src_b,ALU_out,Zero,Carry,ALU_ctrl_conn);
assign Zero_conn = Zero;
assign Carry_conn = Carry;
assign ALU_out_conn = ALU_out;
wire [31:0] write_data_mem;
wire [31:0] data_rd_out;
wire [31:0] data_read;
store_mux SM(RS2_data_conn,instruction_fetch[13:12],write_data_mem);
wire [31:0] sm_dm = write_data_mem;
data_memory DM(ALU_out_conn,sm_dm,Mem_Write_conn,clk,data_read);
wire [31:0] dm_lm = data_read;
LOAD_MUX LM(dm_lm,instruction_fetch[13:12],data_rd_out);
wire [31:0] data_rd_out_conn = data_rd_out;

mux_8to1 M8(ALU_out_conn,data_rd_out_conn,PCplus4_conn,ext_imm,PCtarget_conn,,,,Result_src_conn,write_reg_data);
assign Write_reg_data_conn = write_reg_data;

assign PC = PC_address;
assign ALU_output =ALU_out_conn;

endmodule
