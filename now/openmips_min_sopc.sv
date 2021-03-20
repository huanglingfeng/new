`include "defines.svh"

module openmips_min_sopc(

	input	logic										clk,
	input logic										rst
	
);

  //����ָ��洢��
  logic[`InstAddrBus] inst_addr;
  logic[`InstBus] inst;
  logic rom_ce;
  logic mem_we_i;
  logic[`RegBus] mem_addr_i;
  logic[`RegBus] mem_data_i;
  logic[`RegBus] mem_data_o;
  logic[3:0] mem_sel_i;  
  logic mem_ce_i;  
 

 openmips openmips0(
		.clk(clk),
		.rst(rst),
	
		.rom_addr_o(inst_addr),
		.rom_data_i(inst),
		.rom_ce_o(rom_ce),

		.ram_we_o(mem_we_i),
		.ram_addr_o(mem_addr_i),
		.ram_sel_o(mem_sel_i),
		.ram_data_o(mem_data_i),
		.ram_data_i(mem_data_o),
		.ram_ce_o(mem_ce_i)		
	
	);
	
	inst_rom inst_rom0(
		.ce(rom_ce),
		.addr(inst_addr),
		.inst(inst)	
	);

	data_ram data_ram0(
		.clk(clk),
		.we(mem_we_i),
		.addr(mem_addr_i),
		.sel(mem_sel_i),
		.data_i(mem_data_i),
		.data_o(mem_data_o),
		.ce(mem_ce_i)		
	);

endmodule