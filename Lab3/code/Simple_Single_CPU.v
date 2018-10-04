//Subject:     CO project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
			clk_i,
			rst_i
		 );
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0] pc_data_in,pc_data_out,pc_not_branch,pc_branch,pc_not_jr,pc_not_jump; //pc_jump
wire [32-1:0] Read_data1,Read_data2,Read_data3;
wire [32-1:0] extend_out,shift_out,ALUResult,DMResult,WriteData,inst;
wire RegDst,RegWrite,ALUSrc,Branch,Zero,Zero_,Jump,Jr,MemRead,MemWrite;
wire [5-1:0] Write_reg1,Write_reg2;
wire [3-1:0] ALU_op;
wire [4-1:0] ALUCtrl;
wire [28-1:0]jump_shift;
wire [2-1:0] BranchType,MemtoReg;


//Greate componentes
ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_data_in) ,   
	    .pc_out_o(pc_data_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	     .src2_i(pc_data_out),     
	     .sum_o(pc_not_branch)    
	    );
	
Instr_Memory IM(
        .addr_i(pc_data_out),  
	     .instr_o(inst)    
	    );
		 
Shift_Left_Two_1 Shifter1(
        .data_i(inst[25:0]),
        .data_o(jump_shift)
        ); 		
		  
Decoder Decoder(
        .instr_op_i(inst[31:26]), 
	     .RegWrite_o(RegWrite), 
	     .ALU_op_o(ALU_op),   
	     .ALUSrc_o(ALUSrc),   
	     .RegDst_o(RegDst),   
		  .Branch_o(Branch),
		  .BranchType_o(BranchType),
		  .Jump_o(Jump),
		  .MemRead_o(MemRead),
		  .MemWrite_o(MemWrite),
		  .MemtoReg_o(MemtoReg)
	    );


MUX_2to1 #(.size(5)) Mux_Write_Reg1(
        .data0_i(inst[20:16]),
        .data1_i(inst[15:11]),
        .select_i(RegDst),
        .data_o(Write_reg1)
        );	
		  
MUX_2to1 #(.size(5)) Mux_Write_Reg2(
        .data0_i(Write_reg1),
        .data1_i(5'b11111),
        .select_i(Jump),
        .data_o(Write_reg2)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(inst[25:21]) ,  
        .RTaddr_i(inst[20:16]) ,  
        .RDaddr_i(Write_reg2) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(Read_data1) ,  
        .RTdata_o(Read_data2)  
        );
		  
Sign_Extend SE(
        .data_i(inst[15:0]),
        .data_o(extend_out)
        );
		  
ALU_Ctrl AC(
        .funct_i(inst[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl),
		  .Jr_o(Jr) 
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(Read_data2),
        .data1_i(extend_out),
        .select_i(ALUSrc),
        .data_o(Read_data3)
        );	
		
ALU ALU(
        .src1_i(Read_data1),
	     .src2_i(Read_data3),
	     .ctrl_i(ALUCtrl),
	     .result_o(ALUResult),
		  .zero_o(Zero)
	    );
		  
MUX_4to1 #(.size(1)) BRANCH(
        .data0_i(~Zero), //BNE
        .data1_i(Zero),  //BEQ
		  .data2_i(ALUResult[31]), //BLT
		  .data3_i(~ALUResult[31]), //BGEZ
        .select_i(BranchType),
        .data_o(Zero_)
        );
		  
Data_Memory Data_Memory(
		.clk_i(clk_i),
		.addr_i(ALUResult),
		.data_i(Read_data2),
		.MemRead_i(MemRead),
		.MemWrite_i(MemWrite),
		.data_o(DMResult)
		);
		
MUX_4to1 #(.size(32)) Mux_Write_Data_Source(
        .data0_i(ALUResult),
        .data1_i(DMResult),
		  .data2_i(extend_out),
		  .data3_i(pc_not_branch),
        .select_i(MemtoReg),
        .data_o(WriteData)
        );
		  
Shift_Left_Two_2 Shifter(
        .data_i(extend_out),
        .data_o(shift_out)
        ); 				
		  
Adder Adder2(
        .src1_i(pc_not_branch),     
	     .src2_i(shift_out),     
	     .sum_o(pc_branch)      
	    );
		

		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_not_branch),
        .data1_i(pc_branch),
        .select_i(Branch&Zero_),
        .data_o(pc_not_jump)
        );	
		  
MUX_2to1 #(.size(32)) Mux_J_Source(
        .data0_i(pc_not_jump),
        .data1_i({pc_data_out[31:28],jump_shift}),
        .select_i(Jump),
        .data_o(pc_not_jr)
        );	
		  
MUX_2to1 #(.size(32)) JR(
        .data0_i(pc_not_jr),
        .data1_i(Read_data1),
        .select_i(Jr),
        .data_o(pc_data_in)
        );

endmodule
		  


