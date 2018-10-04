//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
			 Jr_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
output             Jr_o;
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation

always@( * )begin
	if(ALUOp_i==3'b000)begin 
		ALUCtrl_o=4'b0010;
	end
	else if(ALUOp_i==3'b001)begin 
		ALUCtrl_o=4'b0110;
	end
	else if(ALUOp_i==3'b010)begin 
		if(funct_i==6'h20)begin ALUCtrl_o=4'b0010;end
		else if(funct_i==6'h22)begin ALUCtrl_o=4'b0110;end
		else if(funct_i==6'h24)begin ALUCtrl_o=4'b0000;end
		else if(funct_i==6'h25)begin ALUCtrl_o=4'b0001;end
		else if(funct_i==6'h2a)begin ALUCtrl_o=4'b0111;end
		else if(funct_i==6'b000110)begin ALUCtrl_o=4'b1001;end
		else if(funct_i==6'b011000)begin ALUCtrl_o=4'b0100;end
		else if(funct_i==6'b001000)begin ALUCtrl_o=4'b0000;end
	end
	else if(ALUOp_i==3'b011)begin 
		ALUCtrl_o=4'b0010;
	end
	else if(ALUOp_i==3'b100)begin 
		ALUCtrl_o=4'b0111;
	end
	else if(ALUOp_i==3'b101)begin 
		ALUCtrl_o=4'b1010;
	end
	else if(ALUOp_i==3'b110)begin 
		ALUCtrl_o=4'b0001;
	end
	else if(ALUOp_i==3'b111)begin 
		ALUCtrl_o=4'b1011;
	end
end

assign Jr_o = (ALUOp_i==3'b010 && funct_i==6'b001000);

endmodule                