`include "defines.svh"
`timescale 1ns/1ps

module openmips_min_sopc_tb();

  logic     CLOCK_50;
  logic     rst;
  logic [7:0] D;
  logic [7:0] o;
       
  initial begin
    CLOCK_50 = 1'b0;
    forever #10 CLOCK_50 = ~CLOCK_50;
  end
      
  initial begin
    rst = `RstEnable;
    #195ns rst= `RstDisable;
    #4000ns $stop;
  end
       
  openmips_min_sopc openmips_min_sopc0(
		.clk(CLOCK_50),
		.rst(rst),
    .D(D),
    .o(o)
	);

endmodule