module clock_div(clk_sys,clk,clk_8);/*分频器，将一
个输入信号clk_sys转换为一个比较慢的信号clk和
一个更慢的信号 clk_8*/
    input clk_sys;
    //input [14:0]delay_sw;
    output clk;
    output clk_8;
    logic clk =0;
    logic clk_8=0;
    logic[25:0] div_counter = 0; 

    logic [31:0] div_counter_8=0; 

    always @(posedge clk_sys) begin
        if (div_counter > 5000) begin 
        clk <= ~clk;
        div_counter <= 0;
        div_counter_8<=div_counter_8+1;
    end else begin
        div_counter <= div_counter+1;
    end
    if(div_counter_8==20000)
    begin
        clk_8<=~clk_8;
        div_counter_8<=0;
    end
end
endmodule

