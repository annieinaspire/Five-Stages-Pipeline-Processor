//³¯¼wªé0111279
//Subject:     CO project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU(
		src1_i,
		src2_i,
		ctrl_i,
		result_o,
		zero_o
		);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]  src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output             zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;
reg	 [32-1:0]  slt;


//Main function

assign zero_o=(result_o==0);

always@(ctrl_i,src1_i,src2_i)begin
	case(ctrl_i)
		0:result_o <= src1_i & src2_i; //AND
		1:result_o <= src1_i | src2_i; //OR
		2:result_o <= src1_i + src2_i; //ADD,ADDI
		4:result_o <= src1_i * src2_i; //MUL
		6:result_o <= src1_i - src2_i; //SUB
		7:begin slt = src1_i - src2_i; result_o = slt[31]; end //SLT
		9:result_o <= src2_i >> src1_i ; //SRLV
		default: result_o <= 0;
	endcase
end

 
endmodule
