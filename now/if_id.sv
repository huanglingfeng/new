
`include"defines.svh"

module if_id(

	input	logic										clk,
	input logic										rst,
	
	input logic[5:0]		stall,

	input InstAddr_t			if_pc,
	input Inst_t          if_inst,
	output InstAddr_t      id_pc,
	output Inst_t          id_inst  
	
);

	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;
	  end else if(stall[1] == `Stop && stall[2] == `NoStop) begin
			id_pc <= `ZeroWord;
			id_inst <= `ZeroWord;	
	  end else if(stall[1] == `NoStop) begin
		  id_pc <= if_pc;
		  id_inst <= if_inst;
		end
	end

endmodule