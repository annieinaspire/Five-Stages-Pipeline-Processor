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
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter


//Main function

always@( * )begin
	/*---Rtype---*/
	if(instr_op_i==6'b000000)begin 
		ALU_op_o=3'b010;
		RegDst_o=1'b1;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b0;
		Branch_o=1'b0;
	end
	/*---ADDI---*/
	else if(instr_op_i==6'b001000)begin 
		ALU_op_o=3'b011; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
	end
	/*---SLTI---*/
	else if(instr_op_i==6'b001010)begin 
		ALU_op_o=3'b100; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
	end
	/*---BEQ---*/
	else if(instr_op_i==6'b000100)begin 
		ALU_op_o=3'b001;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
	end
	/*---LUI---*/
	else if(instr_op_i==6'b001111)begin 
		ALU_op_o=3'b101;
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
	end
	/*---ORI---*/
	else if(instr_op_i==6'b001101)begin 
		ALU_op_o=3'b110; 
		RegDst_o=1'b0;
		RegWrite_o=1'b1;
		ALUSrc_o=1'b1;
		Branch_o=1'b0;
	end
	/*---BNE---*/
	else if(instr_op_i==6'b000101)begin 
		ALU_op_o=3'b111;
		RegDst_o=1'b0;
		RegWrite_o=1'b0;
		ALUSrc_o=1'b0;
		Branch_o=1'b1;
	end
end

endmodule





                    
                    