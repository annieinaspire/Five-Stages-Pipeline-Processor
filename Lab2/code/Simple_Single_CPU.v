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
wire [32-1:0] pc_data_in,pc_data_out,pc_not_branch,pc_branch,Read_data1,Read_data2,Read_data3,extend_out,shift_out,sft_result;
wire [32-1:0] ALUResult,Result,inst;
wire RegDst,RegWrite,ALUSrc,Branch,Zero,shift;
wire [5-1:0] Write_reg1;
wire [3-1:0] ALU_op;
wire [4-1:0] ALUCtrl;


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
        .pc_addr_i(pc_data_out),  
	     .instr_o(inst)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(inst[20:16]),
        .data1_i(inst[15:11]),
        .select_i(RegDst),
        .data_o(Write_reg1)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(inst[25:21]) ,  
        .RTaddr_i(inst[20:16]) ,  
        .RDaddr_i(Write_reg1) ,  
        .RDdata_i(Result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(Read_data1) ,  
        .RTdata_o(Read_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(inst[31:26]), 
	     .RegWrite_o(RegWrite), 
	     .ALU_op_o(ALU_op),   
	     .ALUSrc_o(ALUSrc),   
	     .RegDst_o(RegDst),   
		  .Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(inst[5:0]),   
        .ALUOp_i(ALU_op),   
        .ALUCtrl_o(ALUCtrl) 
        );
	
Sign_Extend SE(
        .data_i(inst[15:0]),
        .data_o(extend_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(Read_data2),
        .data1_i(extend_out),
        .select_i(ALUSrc),
        .data_o(Read_data3)
        );	

Shift_Logical SL(
        .src_i(Read_data3),
	     .sftamt_i(extend_out[10:6]),
	     .ctrl_i(ALUCtrl),
	     .shift_o(shift),
		  .sft_result_o(sft_result)
	    );
		
ALU ALU(
        .src1_i(Read_data1),
	     .src2_i(Read_data3),
	     .ctrl_i(ALUCtrl),
	     .result_o(ALUResult),
		  .zero_o(Zero)
	    );

MUX_2to1 #(.size(32)) Mux_ALU_or_Shift(
        .data0_i(ALUResult),
        .data1_i(sft_result),
        .select_i(shift),
        .data_o(Result)
        );	
		
Adder Adder2(
        .src1_i(pc_not_branch),     
	     .src2_i(shift_out),     
	     .sum_o(pc_branch)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(extend_out),
        .data_o(shift_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_not_branch),
        .data1_i(pc_branch),
        .select_i(Branch&Zero),
        .data_o(pc_data_in)
        );	

endmodule
		  


