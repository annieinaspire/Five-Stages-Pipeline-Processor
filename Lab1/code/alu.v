`timescale 1ns/1ps
//³¯¼wªé
//0111279
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

/* "only" in the "always" block, "output" could be "reg"; ---otherwise, output should always be wire.(assign and instance)--- */
wire    [32-1:0] result,C_out;
wire             zero,cout,overflow;
reg 				  Less,Ainv,Binv,C_in;
reg	  [2-1:0] top_oper;
genvar          i;

always@( * )begin
	if(rst_n)begin
		case(ALU_control)
			/*---And---*/
			4'b0000: begin
				Less=1'b0;
				Ainv=1'b0;
				Binv=1'b0;
				C_in=1'b0;
				top_oper=2'b00; end
			/*---Or---*/
			4'b0001: begin
				Less=1'b0;
				Ainv=1'b0;
				Binv=1'b0;
				C_in=1'b0;
				top_oper=2'b01; end
			/*---Add---*/
			4'b0010: begin
				Less=1'b0;
				Ainv=1'b0;
				Binv=1'b0;
				C_in=1'b0;
				top_oper=2'b10; end
			/*---Sub---*/
			4'b0110: begin
				Less=1'b0;
				Ainv=1'b0;
				Binv=1'b1;
				C_in=1'b1;
				top_oper=2'b10; end
			/*---Nor---*/
			4'b1100: begin
				Less=1'b0;
				Ainv=1'b1;
				Binv=1'b1;
				C_in=1'b0;
				top_oper=2'b00; end
			/*---Nand---*/
			4'b1101: begin
				Less=1'b0;
				Ainv=1'b1;
				Binv=1'b1;
				C_in=1'b0;
				top_oper=2'b01; end
			/*---Slt---*/
			4'b0111: begin
				Less=1'b0;
				Ainv=1'b0;
				Binv=1'b1;
				C_in=1'b1;
				top_oper=2'b11; end
		endcase
	end
end 

alu_top head(src1[0],src2[0],Set,Ainv,Binv,C_in,top_oper,result[0],C_out[0]);
generate for(i=1;i<=30;i=i+1)begin alu_top body(src1[i],src2[i],Less,Ainv,Binv,C_out[i-1],top_oper,result[i],C_out[i]); end endgenerate
alu_top bottom(src1[31],src2[31],Less,Ainv,Binv,C_out[30],top_oper,result[31],C_out[31]);

assign Set=(src1[31])^(~src2[31])^(C_out[30]); //Slt: Because I converse src2 in alu_top, so I have to converse src2(src2[31]) in alu as well. 
assign zero=(result==32'h00000000)? 1:0;
assign cout=(ALU_control==4'b0010 || ALU_control==4'b0110 || ALU_control==4'b0111)? C_out[31]: 1'b0;
assign overflow=(ALU_control==4'b0010 && src1[31]==1'b0 && src2[31]==1'b0 && result[31]==1'b1)? 1:
		          (ALU_control==4'b0010 && src1[31]==1'b1 && src2[31]==1'b1 && result[31]==1'b0)? 1:
					 (ALU_control==4'b0110 && src1[31]==1'b0 && src2[31]==1'b1 && result[31]==1'b0)? 1:
					 (ALU_control==4'b0110 && src1[31]==1'b1 && src2[31]==1'b0 && result[31]==1'b1)? 1: 0;

endmodule


