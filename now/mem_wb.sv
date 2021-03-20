`include "defines.svh"

module mem_wb(

	input	logic										clk,
	input logic										rst,

  //���Կ���ģ�����Ϣ
	input logic[5:0]               stall,	

	//���Էô�׶ε���Ϣ	
	input logic[`RegAddrBus]       mem_wd,
	input logic                    mem_wreg,
	input logic[`RegBus]					 mem_wdata,
	input logic[`RegBus]           mem_hi,
	input logic[`RegBus]           mem_lo,
	input logic                    mem_whilo,	

	//�͵���д�׶ε���Ϣ
	output logic[`RegAddrBus]      wb_wd,
	output logic                   wb_wreg,
	output logic[`RegBus]					 wb_wdata,
	output logic[`RegBus]          wb_hi,
	output logic[`RegBus]          wb_lo,
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