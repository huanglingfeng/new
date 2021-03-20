module disp(clk,sw,seg,an);
    input logic clk;
    input logic[15:0] sw;       // 16λ����
    output logic[7:0] seg;      // 7��������������͵�ƽ��Ч
    output logic[7:0] an;       // 7�������Ƭѡ�źţ��͵�ƽ��Ч
   
    logic[3:0] data;
             
    Mem U_MEM (sw,data);
    Decoder3_8 U_D38(q, an);   //Ƭѡ
    SevenSegDecoder U_SSD1(data,seg,q);  //8����

endmodule