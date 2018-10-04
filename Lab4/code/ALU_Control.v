//³¯¼wªé0111279
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

module ALU_Control(
          funct_i,
          ALUOp_i,
          ALUCtrl_o,
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
//Internal Signals
reg        [4-1:0] ALUCtrl_o;
       
//Select exact operation

always@( * )begin
	if(ALUOp_i==3'b000)begin //LW,SW
		ALUCtrl_o=4'b0010;
	end
	else if(ALUOp_i==3'b001)begin //BRANCH:BEQ
		ALUCtrl_o=4'b0110;
	end
	else if(ALUOp_i==3'b010)begin //Rtype
		if(funct_i==6'h20)begin ALUCtrl_o=4'b0010;end //ADD
		else if(funct_i==6'h22)begin ALUCtrl_o=4'b0110;end //SUB
		else if(funct_i==6'h24)begin ALUCtrl_o=4'b0000;end //OR
		else if(funct_i==6'h25)begin ALUCtrl_o=4'b0001;end //AND
		else if(funct_i==6'h2a)begin ALUCtrl_o=4'b0111;end //SLT
		else if(funct_i==6'b000010)begin ALUCtrl_o=4'b1000;end //SRL
		else if(funct_i==6'b000110)begin ALUCtrl_o=4'b1001;end //SRLV
		else if(funct_i==6'b011000)begin ALUCtrl_o=4'b0100;end //MUL
	end
	else if(ALUOp_i==3'b011)begin //ADDI
		ALUCtrl_o=4'b0010;
	end
	else if(ALUOp_i==3'b100)begin //SLTI
		ALUCtrl_o=4'b0111;
	end
end

endmodule                