`include"defines.svh"

module ex_mem(

	input	logic										clk,
	input logic										rst,
	
	input logic[5:0]			stall,

	//来自执行阶段的信息	
	input RegAddr_t       ex_wd,
	input logic                    ex_wreg,
	input Reg_t					 ex_wdata, 	
	input Reg_t           ex_hi,
	input Reg_t           ex_lo,
	input logic                    ex_whilo, 	

	input DoubleReg_t		      hilo_i,	
	input logic[1:0]               cnt_i,

	//送到访存阶段的信息
	output RegAddr_t      mem_wd,
	output logic                   mem_wreg,
	output Reg_t					 mem_wdata,
	
	output Reg_t          mem_hi,
	output Reg_t          mem_lo,
	output logic                   mem_whilo,

	output DoubleReg_t		      hilo_o,	
	output logic[1:0]               cnt_o
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
		end else if(stall[3] == `Stop && stall[4] == `NoStop) begin
			mem_wd <= `NOPRegAddr;
			mem_wreg <= `WriteDisable;
		  mem_wdata <= `ZeroWord;
		  mem_hi <= `ZeroWord;
		  mem_lo <= `ZeroWord;
		  mem_whilo <= `WriteDisable;
	    hilo_o <= hilo_i;
			cnt_o <= cnt_i;			  				    
		end else if(stall[3] == `NoStop) begin
			mem_wd <= ex_wd;
			mem_wreg <= ex_wreg;
			mem_wdata <= ex_wdata;	
			mem_hi <= ex_hi;
			mem_lo <= ex_lo;
			mem_whilo <= ex_whilo;	
	    hilo_o <= {`ZeroWord, `ZeroWord};
			cnt_o <= 2'b00;	
		end else begin
	    hilo_o <= hilo_i;
			cnt_o <= cnt_i;											
		end    //if
	end      //always
			

endmodule