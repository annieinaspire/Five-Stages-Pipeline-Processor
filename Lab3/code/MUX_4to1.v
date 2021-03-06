`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:45 05/03/2015 
// Design Name: 
// Module Name:    MUX_3to1 
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
module MUX_4to1(
		data0_i,
      data1_i,
		data2_i,
		data3_i,
      select_i,
      data_o
		);

parameter size = 0;	
			
//I/O ports               
input   [size-1:0] data0_i,data1_i,data2_i,data3_i;
input   [2-1:0]    select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function

always@( * )begin
	if(select_i==2'b00)data_o=data0_i;
	else if(select_i==2'b01)data_o=data1_i;
	else if(select_i==2'b10)data_o=data2_i;
	else if(select_i==2'b11)data_o=data3_i;
end

endmodule
