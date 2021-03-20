`include "defines.svh"

module ex_mem(

	input	logic										clk,
	input logic										rst,

	//���Կ���ģ�����Ϣ
	input logic[5:0]							 stall,	
	
	//����ִ�н׶ε���Ϣ	
	input logic[`RegAddrBus]       ex_wd,
	input logic                    ex_wreg,
	input logic[`RegBus]					 ex_wdata, 	
	input logic[`RegBus]           ex_hi,
	input logic[`RegBus]           ex_lo,
	input logic                    ex_whilo, 	

  //Ϊʵ�ּ��ء��ô�ָ������
  input logic[`AluOpBus]        ex_aluop,
	input logic[`RegBus]          ex_mem_addr,
	input logic[`RegBus]          ex_reg2,

	input logic[`DoubleRegBus]     hilo_i,	
	input logic[1:0]               cnt_i,	
	
	//�͵��ô�׶ε���Ϣ
	output logic[`RegAddrBus]      mem_wd,
	output logic                   mem_wreg,
	output logic[`RegBus]					 mem_wdata,
	output logic[`RegBus]          mem_hi,
	output logic[`RegBus]          mem_lo,
	output logic                   mem_whilo,

  //Ϊʵ�ּ��ء��ô�ָ������
  output logic[`AluOpBus]        mem_aluop,
	output logic[`RegBus]          mem_mem_addr,
	output logic[`RegBus]          mem_reg2,
		
	output logic[`DoubleRegBus]    hilo_o,
	output logic[1:0]              cnt_o	
	
	
);


	always @ (posedge clk) begin
		if(rst == `RstEnable) begin
			mem_wd <= `NOPRegAddr;
			mem_wreg <= `WriteDisable;
		  mem_wdata <= `ZeroWord;	
		  mem_hi <= `ZeroWord;
		  mem_lo <= `ZeroWord;
		  mem_whilo <= `WriteDisable;		
	    hilo_o <= {`ZeroWord, `ZeroWord};
			cnt_o <= 2'b00;	
  		mem_aluop <= `EXE_NOP_OP;
			mem_mem_addr <= `ZeroWord;
			mem_reg2 <= `ZeroWord;			
		end else if(stall[3] == `Stop && stall[4] == `NoStop) begin
			mem_wd <= `NOPRegAddr;
			mem_wreg <= `WriteDisable;
		  mem_wdata <= `ZeroWord;
		  mem_hi <= `ZeroWord;
		  mem_lo <= `ZeroWord;
		  mem_whilo <= `WriteDisable;
	    hilo_o <= hilo_i;
			cnt_o <= cnt_i;	
  		mem_aluop <= `EXE_NOP_OP;
			mem_mem_addr <= `ZeroWord;
			mem_reg2 <= `ZeroWord;						  				    
		end else if(stall[3] == `NoStop) begin
			mem_wd <= ex_wd;
			mem_wreg <= ex_wreg;
			mem_wdata <= ex_wdata;	
			mem_hi <= ex_hi;
			mem_lo <= ex_lo;
			mem_whilo <= ex_whilo;	
	    hilo_o <= {`ZeroWord, `ZeroWord};
			cnt_o <= 2'b00;	
  		mem_aluop <= ex_aluop;
			mem_mem_addr <= ex_mem_addr;
			mem_reg2 <= ex_reg2;			
		end else begin
	    hilo_o <= hilo_i;
			cnt_o <= cnt_i;											
		end    //if
	end      //always
			

endmodule