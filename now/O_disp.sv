module disp(clk,sw,seg,an);
    input logic clk;
    input logic[15:0] sw;       // 16位数据
    output logic[7:0] seg;      // 7段数码管驱动，低电平有效
    output logic[7:0] an;       // 7段数码管片选信号，低电平有效
   
    logic[3:0] data;
             
    Mem U_MEM (sw,data);
    Decoder3_8 U_D38(q, an);   //片选
    SevenSegDecoder U_SSD1(data,seg,q);  //8段码

endmodule