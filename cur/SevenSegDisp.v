
module SevenSegDisp(clk,sw,seg,an);
    input clk;
    input [15:0] sw;       // 16λ����
    output [7:0] seg;      // 7��������������͵�ƽ��Ч
    output [7:0] an;       // 7�������Ƭѡ�źţ��͵�ƽ��Ч
   
    reg [1:0] q;
    wire [3:0] data;
    initial
    begin
    q=2'b00; 
    end
//    Counter8 U_CNT(clk,q); 
    always @(posedge clk )  begin
          q<=q+1;
          if (q==2'b11) q= 2'b00;
          else  q = q;
          end   
             
    Mem U_MEM (q,sw,data);
    Decoder3_8 U_D38(q, an);   //Ƭѡ
    SevenSegDecoder U_SSD1(data,seg,q);  //8����

endmodule