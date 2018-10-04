`timescale 1ns / 1ps
//³¯¼wªé0111279
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:02:05 05/22/2015 
// Design Name: 
// Module Name:    Forwarding_Unit 
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
module Forwarding_Unit(
			EX_MEM_RegWrite_i,
			EX_MEM_rd_i,
			MEM_WB_RegWrite_i,
			MEM_WB_rd_i,
			ID_EX_rs_i,
			ID_EX_rt_i,
			Forward1_o,
			Forward2_o
		);

input [5-1:0] 		 MEM_WB_rd_i,EX_MEM_rd_i,ID_EX_rs_i,ID_EX_rt_i;
input  		  		 EX_MEM_RegWrite_i,MEM_WB_RegWrite_i;

output reg [2-1:0] Forward1_o,Forward2_o;

always@( * )begin

	//forward rs
	if(EX_MEM_RegWrite_i && (EX_MEM_rd_i!=5'b00000) && (EX_MEM_rd_i==ID_EX_rs_i)) //from EX_MEM
		Forward1_o=2'b10;
	else if(MEM_WB_RegWrite_i && (MEM_WB_rd_i!=5'b00000) && (~(EX_MEM_RegWrite_i && (EX_MEM_rd_i!=5'b00000) && (EX_MEM_rd_i==ID_EX_rs_i))) && (MEM_WB_rd_i==ID_EX_rs_i)) //from MEM_WB
		Forward1_o=2'b01;
	else //from Reg File
		Forward1_o=2'b00;
	
	//forward rt
	if(EX_MEM_RegWrite_i && (EX_MEM_rd_i!=5'b00000) && (EX_MEM_rd_i==ID_EX_rt_i)) //from EX_MEM
		Forward2_o=2'b10;
	else if(MEM_WB_RegWrite_i && (MEM_WB_rd_i!=5'b00000) && (~(EX_MEM_RegWrite_i && (EX_MEM_rd_i!=5'b00000) && (EX_MEM_rd_i==ID_EX_rt_i))) && (MEM_WB_rd_i==ID_EX_rt_i)) //from MEM_WB
		Forward2_o=2'b01;
	else //from Reg File
		Forward2_o=2'b00;
end

endmodule
