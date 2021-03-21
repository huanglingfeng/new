`include "defines.svh"

module regfile(

	input	logic										clk,
	input logic										rst,
	
	//Ð´¶Ë¿Ú
	input logic										we,
	input RegAddr_t				waddr,
	input Reg_t						wdata,
	
	//¶Á¶Ë¿Ú1
	input logic										re1,
	input RegAddr_t			  raddr1,
	output Reg_t           rdata1,
	
	//¶Á¶Ë¿Ú2
	input logic										re2,
	input RegAddr_t			  raddr2,
	output Reg_t           rdata2
	
);

	Reg_t  regs[0:`RegNum-1];

	always @ (posedge clk) begin
		if (rst == `RstDisable) begin
			if((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
				regs[waddr] <= wdata;
			end
		end
	end
	
	always_comb begin
		if(rst == `RstEnable) begin
			  rdata1 <= `ZeroWord;
	  end else if(raddr1 == `RegNumLog2'h0) begin
	  		rdata1 <= `ZeroWord;
	  end else if((raddr1 == waddr) && (we == `WriteEnable) 
	  	            && (re1 == `ReadEnable)) begin
	  	  rdata1 <= wdata;
	  end else if(re1 == `ReadEnable) begin
	      rdata1 <= regs[raddr1];
	  end else begin
	      rdata1 <= `ZeroWord;
	  end
	end

	always_comb begin
		if(rst == `RstEnable) begin
			  rdata2 <= `ZeroWord;
	  end else if(raddr2 == `RegNumLog2'h0) begin
	  		rdata2 <= `ZeroWord;
	  end else if((raddr2 == waddr) && (we == `WriteEnable) 
	  	            && (re2 == `ReadEnable)) begin
	  	  rdata2 <= wdata;
	  end else if(re2 == `ReadEnable) begin
	      rdata2 <= regs[raddr2];
	  end else begin
	      rdata2 <= `ZeroWord;
	  end
	end

endmodule