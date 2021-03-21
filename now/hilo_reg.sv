`include "defines.svh"

module hilo_reg(

	input logic										clk,
	input logic										rst,
	
	//Ð´¶Ë¿Ú
	input logic										we,
	input Reg_t				    hi_i,
	input Reg_t						lo_i,
	
	//¶Á¶Ë¿Ú1
	output Reg_t           hi_o,
	output Reg_t           lo_o
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
					hi_o <= `ZeroWord;
					lo_o <= `ZeroWord;
		end else if((we == `WriteEnable)) begin
					hi_o <= hi_i;
					lo_o <= lo_i;
		end
	end

endmodule