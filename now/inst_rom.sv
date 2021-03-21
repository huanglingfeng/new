
`include"defines.svh"

module inst_rom(

//	input	logic										clk,
	input logic                    ce,
	input InstAddr_t			addr,
	output Inst_t					inst
	
);

	Inst_t  inst_mem[0:`InstMemNum-1];

	initial $readmemh ( "inst_rom.data", inst_mem );

	always_comb begin
		if (ce == `ChipDisable) begin
			inst <= `ZeroWord;
	  end else begin
		  inst <= inst_mem[addr[`InstMemNumLog2+1:2]];
		end
	end

endmodule