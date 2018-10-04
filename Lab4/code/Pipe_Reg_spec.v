//Subject:     CO project 4 - Pipe Register
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer: ³¯¼wªé 0111279
//--------------------------------------------------------------------------------
//Date:        
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_Reg_spec(
               clk_i,
					rst_i,
					IF_ID_Write_i,
					data_i,
					data_o
					);
					
parameter size = 0;

input          clk_i;		  
input				rst_i;
input				IF_ID_Write_i;
input      [size-1: 0] data_i;
output reg [size-1: 0] data_o;
	  
always @(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
	 else if(rst_i && IF_ID_Write_i) //if IF_ID_Write_i signal is 1, output the same data as last clock cycle 
        data_o <= data_o;
    else
        data_o <= data_i;
end

endmodule	