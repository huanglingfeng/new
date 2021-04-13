`timescale 1ns/1ps
module top_tb(

);
    logic clk,rst,clk0;
    logic[7:0] D,o;
    top top1(.*);
    always #10 clk=~clk;
    initial begin
        clk=0;
        rst=1;
        #100 rst=0;
        #4000 $stop;
    end
endmodule