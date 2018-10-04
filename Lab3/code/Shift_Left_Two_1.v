`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:49:35 05/03/2015 
// Design Name: 
// Module Name:    Shift_Left_Two_1 
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
module Shift_Left_Two_1(
		data_i,
		data_o
		);

//I/O ports                    
input [26-1:0] data_i;
reg   [26-1:0] temp;
output[28-1:0] data_o;



reg [28-1:0] data_o;
//shift left 2
always@( * )begin
	temp=data_i<<2;
	data_o=temp;
end

endmodule

