`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:43:47 04/29/2015 
// Design Name: 
// Module Name:    shift_logical 
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
module Shift_Logical(
			src_i,
			sftamt_i,
			ctrl_i,
			shift_o,
			sft_result_o
			);
			
//I/O ports
input  [32-1:0]  src_i;
input  [5-1:0]   sftamt_i;
input  [4-1:0]   ctrl_i;


output	 			shift_o;
output [32-1:0]   sft_result_o;

//Internal signals
reg    shift_o;
reg    [32-1:0] sft_result_o;

//Parameter

//Main function



always@(ctrl_i,src_i,sftamt_i)begin
	if(ctrl_i==4'b1000)begin shift_o=1; sft_result_o <= src_i >> sftamt_i; end
	else begin shift_o=0; sft_result_o <= 0; end
end



endmodule
