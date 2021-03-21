`include"defines.svh"

module mem(

	input logic										rst,
	
	//来自执行阶段的信息	
	input RegAddr_t       wd_i,
	input logic                    wreg_i,
	input Reg_t					  wdata_i,
	input Reg_t           hi_i,
	input Reg_t           lo_i,
	input logic                    whilo_i,	

	//送到回写阶段的信息
	output RegAddr_t      wd_o,
	output logic                   wreg_o,
	output Reg_t					 wdata_o,
	output Reg_t          hi_o,
	output Reg_t          lo_o,
	output logic                   whilo_o
	
);

	
	always_comb begin
		if(rst == `RstEnable) begin
			wd_o <= `NOPRegAddr;
			wreg_o <= `WriteDisable;
		  wdata_o <= `ZeroWord;
		  hi_o <= `ZeroWord;
		  lo_o <= `ZeroWord;
		  whilo_o <= `WriteDisable;	
		end else begin
		  wd_o <= wd_i;
			wreg_o <= wreg_i;
			wdata_o <= wdata_i;
			hi_o <= hi_i;
			lo_o <= lo_i;
			whilo_o <= whilo_i;	
		end    //if
	end      //always
			

endmodule