//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
   instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	BranchType_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o,Jump_o,MemRead_o,MemWrite_o;
output [2-1:0] MemtoReg_o,BranchType_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o,Jump_o,MemRead_o,MemWrite_o;
reg    [2-1:0] MemtoReg_o,BranchType_o;

//Parameter


//Main function

always@( * )begin
	/*---lw---*/
	if(instr_op_i==6'b100011)begin 
		ALU_op_o=3'b000;
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b1;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b01;
	end
	/*---sw---*/
	else if(instr_op_i==6'b101011)begin 
		ALU_op_o=3'b000;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b1;
		MemtoReg_o=2'b00;
	end
	/*---BNE,BNEZ---*/
	else if(instr_op_i==6'b000101)begin 
		ALU_op_o=3'b001;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---BLT---*/
	else if(instr_op_i==6'b000110)begin 
		ALU_op_o=3'b001;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
		BranchType_o=2'b10;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---BGEZ---*/
	else if(instr_op_i==6'b000001)begin 
		ALU_op_o=3'b111;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
		BranchType_o=2'b11;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---BEQ---*/
	else if(instr_op_i==6'b000100)begin 
		ALU_op_o=3'b001;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
		BranchType_o=2'b01;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---Rtype---*/
	if(instr_op_i==6'b000000)begin 
		ALU_op_o=3'b010;
		RegDst_o=1'b1;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b0;
		Branch_o=2'b00;
		BranchType_o=1'b0;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---ADDI---*/
	else if(instr_op_i==6'b001000)begin 
		ALU_op_o=3'b011; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---SLTI---*/
	else if(instr_op_i==6'b001010)begin 
		ALU_op_o=3'b100; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---ORI---*/
	else if(instr_op_i==6'b001101)begin 
		ALU_op_o=3'b110; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---J---*/
	else if(instr_op_i==6'b000010)begin 
		ALU_op_o=3'b110; 
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b1;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---JAL---*/
	else if(instr_op_i==6'b000011)begin 
		ALU_op_o=3'b110; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b0;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b1;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b11;
	end
	/*---JR---*/
	else if(instr_op_i==6'b000000)begin 
		ALU_op_o=3'b010; 
		RegDst_o=1'b1;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b0;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b00;
	end
	/*---LI---*/
	else if(instr_op_i==6'b001111)begin 
		ALU_op_o=3'b110; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b0;
		Branch_o=1'b0;
		BranchType_o=2'b00;
		Jump_o=1'b0;
		MemRead_o=1'b0;
		MemWrite_o=1'b0;
		MemtoReg_o=2'b10;
	end
end

endmodule





                    
                    