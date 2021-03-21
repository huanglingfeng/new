`include"defines.svh"

module mem_wb(

	input	logic										clk,
	input logic										rst,
	
	input logic[5:0]		stall,

	//来自访存阶段的信息	
	input RegAddr_t       mem_wd,
	input logic                    mem_wreg,
	input Reg_t					 mem_wdata,
	input Reg_t           mem_hi,
	input Reg_t           mem_lo,
	input logic                    mem_whilo,	
	//送到回写阶段的信息
	output RegAddr_t      wb_wd,
	output logic                   wb_wreg,
	output Reg_t					 wb_wdata,
	output Reg_t          wb_hi,
	output Reg_t          wb_lo,
	output logic                   wb_whilo
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;
		  wb_hi <= `ZeroWord;
		  wb_lo <= `ZeroWord;
		  wb_whilo <= `WriteDisable;	
		end else if(stall[4] == `Stop && stall[5] == `NoStop) begin
			wb_wd <= `NOPRegAddr;
			wb_wreg <= `WriteDisable;
		  wb_wdata <= `ZeroWord;
		  wb_hi <= `ZeroWord;
		  wb_lo <= `ZeroWord;
		  wb_whilo <= `WriteDisable;		  	  
		end else if(stall[4] == `NoStop) begin
			wb_wd <= mem_wd;
			wb_wreg <= mem_wreg;
			wb_wdata <= mem_wdata;
			wb_hi <= mem_hi;
			wb_lo <= mem_lo;
			wb_whilo <= mem_whilo;			
		end    //if
	end      //always
			

endmodule