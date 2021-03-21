`include"defines.svh"

module pc_reg(

	input	logic										clk,
	input logic										rst,
	
	//来自控制模块的信息
	input logic[5:0]               stall,

	output InstAddr_t			pc,
	output logic                    ce
	
);

	always @ (posedge clk) begin
		if (ce == `ChipDisable) begin
			pc <= 32'h00000000;
		end else if(stall[0] == `NoStop) begin
	 		pc <= pc + 4'h4;
		end
	end
	
	always @ (posedge clk) begin
		if (rst == `RstEnable) begin
			ce <= `ChipDisable;
		end else begin
			ce <= `ChipEnable;
		end
	end

endmodule