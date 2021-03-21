`include "defines.svh"

module openmips_min_sopc(

	input	logic										clk,
	input logic										rst,
	output logic [7:0] D,
    output logic [7:0] o
);
	logic clk1,clk2;
  //Á¬½ÓÖ¸Áî´æ´¢Æ÷
  logic[`InstAddrBus] inst_addr;
  logic[`InstBus] inst;
  logic rom_ce;
  logic mem_we_i;
  logic[`RegBus] mem_addr_i;
  logic[`RegBus] mem_data_i;
  logic[`RegBus] mem_data_o;
  logic[3:0] mem_sel_i;  
  logic mem_ce_i;  
  logic[`RegBus] .D(out;
  logic [63:0] .Y(led_anode_out;
clock_div clk_d(.clk_sys(clk),.clk(clk2),.clk_8(clk1));
 openmips openmips0(
		.clk(clk2),
		.rst(rst),

		..D(out(.D(out),
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
		.clk(clk2),
		.we(mem_we_i),
		.addr(mem_addr_i),
		.sel(mem_sel_i),
		.data_i(mem_data_i),
		.data_o(mem_data_o),
		.ce(mem_ce_i)		
	);
	
	led_anode led0(.D(out[3:0]),.Y(led_anode_out[7:0]));
    led_anode led1(.D(out[7:4]),.Y(led_anode_out[15:8]));
    led_anode led2(.D(out[11:8]),.Y(led_anode_out[23:16]));
    led_anode led3(.D(out[15:12]),.Y(led_anode_out[31:24]));
    led_anode led4(.D(out[19:16]),.Y(led_anode_out[39:32]));
    led_anode led5(.D(out[23:20]),.Y(led_anode_out[47:40]));
    led_anode led6(.D(out[27:24]),.Y(led_anode_out[55:48]));
    led_anode led7(.D(out[31:28]),.Y(led_anode_out[63:56]));

	led_ctrl led_c(.clk(clk2),.i(led_anode_out),.D(D),.o(o));
endmodule