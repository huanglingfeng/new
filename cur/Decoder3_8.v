
module Decoder3_8(num, sel);
    input  [1: 0] num;       // 数码管编号：0~7
    output reg [7:0] sel;       // 7段数码管片选信号，低电平有效

    always @(num) begin
        case(num)
            3'd0: sel = #10000000 8'b11111110;
            3'd1: sel = #10000000 8'b11111101;
            3'd2: sel =  #10000000 8'b11111011;
            3'd3: sel =  #10000000 8'b11110111; 
            default: sel = 8'b11111111;
        endcase
    end

endmodule