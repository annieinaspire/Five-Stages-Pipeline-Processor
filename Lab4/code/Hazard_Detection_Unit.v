`timescale 1ns / 1ps
//³¯¼wªé0111279
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:02:36 05/22/2015 
// Design Name: 
// Module Name:    Hazard_Detection_Unit 
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
module Hazard_Detection_Unit(
			IF_ID_rs_i,
			IF_ID_rt_i,
			ID_EX_rt_i,
			ID_EX_MemRead_i,
			PCSrc_i,
			PCWrite_o,
			IFIDWrite_o,
			IFIDFlush_o,
			IDFlush_o,
			EXFlush_o,
		 );

input [5-1:0] IF_ID_rs_i,IF_ID_rt_i,ID_EX_rt_i;
input 		  ID_EX_MemRead_i,PCSrc_i;	 
output reg 	  PCWrite_o,IFIDWrite_o;
output reg	  IFIDFlush_o,IDFlush_o,EXFlush_o;

always@( * )begin
	//if branch taking place, flush the instructions in IF, ID and EX stage
	if(PCSrc_i)begin
		PCWrite_o=1'b0;
		IFIDWrite_o=1'b0;
		IFIDFlush_o=1'b1;
		IDFlush_o=1'b1;
		EXFlush_o=1'b1;
	end
	//if there is a data dependency between a LW instruction and any other instruction, insert bubble (stall)
	else if(ID_EX_MemRead_i && ((ID_EX_rt_i==IF_ID_rs_i) || (ID_EX_rt_i==IF_ID_rt_i))) begin
		PCWrite_o=1'b1;
		IFIDWrite_o=1'b1;
		IFIDFlush_o=1'b0;
		IDFlush_o=1'b1;
		EXFlush_o=1'b0;
	end
	else begin
		PCWrite_o=1'b0;
		IFIDWrite_o=1'b0;
		IFIDFlush_o=1'b0;
		IDFlush_o=1'b0;
		EXFlush_o=1'b0;
	end
end

endmodule
