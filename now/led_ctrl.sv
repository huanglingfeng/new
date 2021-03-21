module led_ctrl(clk,i,D,o);
input clk;
input [63:0]i;
output logic [7:0] D;
output logic [7:0] o;
//logic [31:0] d;
logic [4:0] a; //用于记录当前应选中的八段管的位
initial
begin
o<=0;
a<=0;
end
always @ (posedge clk)
begin
//d={i0[7:0],i1[7:0],i2[7:0],i3[7:0]};
if(a==4'h0)
begin
o<=i[63:56];
D<=8'b01111111;
end
else if(a==4'h1)
begin
o<=i[55:48];
D<=8'b10111111;
end
else if(a==4'h2)
begin
o<=i[47:40];
D<=8'b11011111;
end
else if(a==4'h3)
begin
o<=i[39:32];
D<=8'b11101111;
end
else if(a==4'h4)
begin
o<=i[31:24];
D<=8'b11110111;
end
else if(a==4'h5)
begin
o<=i[23:16];
D<=8'b11111011;
end
else if(a==4'h6)
begin
o<=i[15:8];
D<=8'b11111101;
end
else if(a==4'h7)
begin
o<=i[7:0];
D<=8'b11111110;
end
else
a<=4'h0;
if(a==4'h7)
a<=2'h0;
else
a<=a+1;
end
endmodule