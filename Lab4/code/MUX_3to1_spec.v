`timescale 1ns / 1ps
//���w��0111279
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
module MUX_3to1_spec(
		data0_i,
      data1_i,
		data2_i,
      select_i,
		srl_i,
      data_o
		);

parameter size = 0;	
			
//I/O ports               
input   [size-1:0] data0_i,data1_i,data2_i;
input   [2-1:0]    select_i;
input					 srl_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] data_o;

//Main function

always@( * )begin
	if(~srl_i) begin
		if(select_i==2'b00)data_o=data0_i;
		else if(select_i==2'b01)data_o=data1_i;
	end
	else begin data_o=data2_i; end //especially for SRL instruction when srl_i signal is 1
end

endmodule
