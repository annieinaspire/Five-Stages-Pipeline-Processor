//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer: ³¯¼wªé 0111279
//--------------------------------------------------------------------------------
//Date:        
//--------------------------------------------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
         clk_i,
			rst_i
		);
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/

/**** IF stage ****/

wire [32-1:0] pc_data_in,pc_data_out,pc_not_branch,inst;
wire [32-1:0] flush_pc_not_branch,flush_inst;

/**** ID stage ****/
wire [32-1:0] pc_not_branch1,inst1;

wire [32-1:0] Read_data1,Read_data2;
wire [32-1:0] extend_out;
wire [32-1:0] write_reg_data;
wire [5-1:0]  write_reg_addr;
wire [2-1:0]  MemtoReg;
wire [3-1:0]  ALU_op;
wire 			  RegDst,RegWrite,ALUSrc,Branch,MemRead,MemWrite;

wire [11-1:0] flush_control1;

/**** EX stage ****/

wire [11-1:0] control2;
wire [32-1:0] pc_not_branch2,Read_data1_2,Read_data2_2,extend_out2;
wire [5-1:0]  rs2,rt2,rd2;

wire [32-1:0] Forward_Read_data1_2,Forward_Read_data2_2,Read_data3,SRL_out,ALUResult,pc_branch,shift_out;
wire [4-1:0]  ALUCtrl;
wire 			  SRL,Zero;

wire [6-1:0]  flush_control2;

/**** MEM stage ****/

wire [32-1:0] pc_branch3,ALUResult3,Read_data2_3,SRL_out3;
wire [6-1:0]  control3;
wire [5-1:0]  write_reg_addr3;
wire 			  Zero3,SRL3;

wire [32-1:0] DMResult;

/**** WB stage ****/

wire [32-1:0] DMResult4,ALUResult4,SRL_out4;
wire [5-1:0]  write_reg_addr4;
wire [3-1:0]  control4;
wire 			  SRL4;

wire [2-1:0]  Forward1,Forward2;
wire 			  PCWrite,IFIDWrite,IFFlush,IDFlush,EXFlush;

/****************************************
Instantiate modules
****************************************/

//Instantiate the components in IF stage
ProgramCounter PC(
			 .clk_i(clk_i),      
			 .rst_i (rst_i),
			 .pc_write_i(PCWrite),
			 .pc_in_i(pc_data_in),   
			 .pc_out_o(pc_data_out) 
        );

Adder Add_pc(
			.src1_i(32'd4),     
			.src2_i(pc_data_out),     
			.sum_o(pc_not_branch)  
	    );
			
Instr_Memory IM(
			.addr_i(pc_data_out),  
	      .instr_o(inst)    
		);
		
MUX_2to1 #(.size(64)) Mux6(
			  .data0_i({pc_not_branch,inst}),
			  .data1_i(64'b0),
			  .select_i(IFFlush),
			  .data_o({flush_pc_not_branch,flush_inst})
        );

		
Pipe_Reg_spec #(.size(64)) IF_ID(
			.clk_i(clk_i),      
			.rst_i (rst_i),     
			.IF_ID_Write_i(IFIDWrite), 
			.data_i({flush_pc_not_branch,flush_inst}),   
			.data_o({pc_not_branch1,inst1}) 
		);
		
//Instantiate the components in ID stage
Reg_File RF(
		  .clk_i(clk_i),      
	     .rst_i(rst_i) ,     
        .RSaddr_i(inst1[25:21]),  
        .RTaddr_i(inst1[20:16]),  
        .RDaddr_i(write_reg_addr4),  
        .RDdata_i(write_reg_data), 
        .RegWrite_i(control4[2]),
        .RSdata_o(Read_data1),  
        .RTdata_o(Read_data2)  
		);

Decoder Control(
		  .instr_op_i(inst1[31:26]), 
	     .RegWrite_o(RegWrite), 
	     .ALU_op_o(ALU_op),   
	     .ALUSrc_o(ALUSrc),   
	     .RegDst_o(RegDst),   
		  .Branch_o(Branch),
		  .MemRead_o(MemRead),
		  .MemWrite_o(MemWrite),
		  .MemtoReg_o(MemtoReg)
		);
		
MUX_2to1 #(.size(11)) Mux7(
			  .data0_i({RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,ALU_op,ALUSrc}),
			  .data1_i(11'b00000000000),
			  .select_i(IDFlush),
			  .data_o(flush_control1)
        );

Sign_Extend Sign_Extend(
		  .data_i(inst1[15:0]),
        .data_o(extend_out)
		);	

Pipe_Reg #(.size(154)) ID_EX(
			.clk_i(clk_i),      
			.rst_i (rst_i),     
			.data_i({flush_control1,pc_not_branch1,Read_data1,Read_data2,extend_out,inst1[25:21],inst1[20:16],inst1[15:11]}),   
			.data_o({control2,pc_not_branch2,Read_data1_2,Read_data2_2,extend_out2,rs2,rt2,rd2}) 
		);
		
//Instantiate the components in EX stage
MUX_2to1 #(.size(6)) Mux8(
			  .data0_i(control2[10:5]),
			  .data1_i(6'b000000),
			  .select_i(EXFlush),
			  .data_o(flush_control2)
        );
		  
MUX_3to1 #(.size(32)) Mux4(
			  .data0_i(Read_data1_2),
			  .data1_i(write_reg_data),
			  .data2_i(ALUResult3),
			  .select_i(Forward1),
			  .data_o(Forward_Read_data1_2)
        );
		  
MUX_3to1 #(.size(32)) Mux5(
			  .data0_i(Read_data2_2),
			  .data1_i(write_reg_data),
			  .data2_i(ALUResult3),
			  .select_i(Forward2),
			  .data_o(Forward_Read_data2_2)
        );
	   
MUX_2to1 #(.size(32)) Mux1(
			  .data0_i(Forward_Read_data2_2),
			  .data1_i(extend_out2),
			  .select_i(control2[0]),
			  .data_o(Read_data3)
        );

ALU_Control ALU_Control(
		  .funct_i(extend_out2[5:0]),   
        .ALUOp_i(control2[3:1]),   
        .ALUCtrl_o(ALUCtrl) 
		);

Shift_Logical SL(
		  .src_i(Read_data3),
	     .sftamt_i(extend_out2[10:6]),
	     .ctrl_i(ALUCtrl),
	     .shift_o(SRL),
		  .sft_result_o(SRL_out)
	    );

ALU ALU(
		  .src1_i(Forward_Read_data1_2),
	     .src2_i(Read_data3),
	     .ctrl_i(ALUCtrl),
	     .result_o(ALUResult),
		  .zero_o(Zero)
		);	
		
MUX_2to1 #(.size(5)) Mux2(
			  .data0_i(rt2),
			  .data1_i(rd2),
			  .select_i(control2[4]),
			  .data_o(write_reg_addr)
        );
		  
Shift_Left_Two_32 Shifter(
        .data_i(extend_out2),
        .data_o(shift_out)
        ); 	

Adder Add_branch(
		  .src1_i(pc_not_branch2),     
	     .src2_i(shift_out),     
	     .sum_o(pc_branch)    
		);

Pipe_Reg #(.size(141)) EX_MEM(
			.clk_i(clk_i),      
			.rst_i (rst_i),     
			.data_i({flush_control2[5:0],pc_branch,Zero,ALUResult,Read_data2_2,write_reg_addr,SRL_out,SRL}),   
			.data_o({control3,pc_branch3,Zero3,ALUResult3,Read_data2_3,write_reg_addr3,SRL_out3,SRL3}) 
		);
			   
//Instantiate the components in MEM stage
Data_Memory DM(
			.clk_i(clk_i),
			.addr_i(ALUResult3),
			.data_i(Read_data2_3),
			.MemRead_i(control3[1]),
			.MemWrite_i(control3[0]),
			.data_o(DMResult)
	    );
		 
MUX_2to1 #(.size(32)) Mux3(
			.data0_i(pc_not_branch),//not pc_not_branch1 or pc_not_branch2 (there is no pc_not_branch3 & pc_not_branch4), read the picture carefully!
			.data1_i(pc_branch3),
			.select_i(control3[2]&Zero3),
			.data_o(pc_data_in)
        );

Pipe_Reg #(.size(105)) MEM_WB(
         .clk_i(clk_i),      
			.rst_i(rst_i),     
			.data_i({control3[5:3],DMResult,ALUResult3,SRL_out3,SRL3,write_reg_addr3}),
			.data_o({control4,DMResult4,ALUResult4,SRL_out4,SRL4,write_reg_addr4}) 
		);

//Instantiate the components in WB stage
MUX_3to1_spec #(.size(32)) Mux(
				  .data0_i(ALUResult4),
				  .data1_i(DMResult4),
				  .data2_i(SRL_out4),
				  .select_i(control4[1:0]),
				  .srl_i(SRL4),
				  .data_o(write_reg_data)
				);
		  
//Forwarding Unit
Forwarding_Unit FU(
			.EX_MEM_RegWrite_i(control3[5]),
			.EX_MEM_rd_i(write_reg_addr3),
			.MEM_WB_RegWrite_i(control4[2]),
			.MEM_WB_rd_i(write_reg_addr4),
			.ID_EX_rs_i(rs2),
			.ID_EX_rt_i(rt2),
			.Forward1_o(Forward1),
			.Forward2_o(Forward2)
		);
		
//Hazard Detection Unit
Hazard_Detection_Unit HDU(
			.IF_ID_rs_i(inst1[25:21]),
			.IF_ID_rt_i(inst1[20:16]),
			.ID_EX_rt_i(rt2),
			.ID_EX_MemRead_i(control2[6]),
			.PCSrc_i(control3[2]&Zero3),
			.PCWrite_o(PCWrite),
			.IFIDWrite_o(IFIDWrite),
			.IFIDFlush_o(IFFlush),
			.IDFlush_o(IDFlush),
			.EXFlush_o(EXFlush)
		);

endmodule

