module SevenSegDecoder(
    data, segments,q    
);
    input [3:0]  data;
    output [7:0]  segments;
    input [1:0] q;
    assign segments = {dp, cg, cf, ce, cd, cc, cb, ca};
    
    reg dp, cg, cf, ce, cd, cc, cb, ca;
    always @(data) begin
            case(data)
                4'h0: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0000_0011;
                4'h1: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1001_1111;
                4'h2: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0010_0101;
                4'h3: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0000_1101;
                4'h4: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1001_1001;
                4'h5: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0100_1001;
                4'h6: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0100_0001;
                4'h7: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0001_1111;
                4'h8: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0000_0001;
                4'h9: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0001_1001;
                4'ha: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0001_0001;
                4'hb: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1100_0001;
                4'hc: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1110_0101;
                4'hd: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1000_0101;
                4'he: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0110_0001;
                4'hf: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b0111_0001;
                default: {ca, cb, cc, cd, ce, cf, cg, dp} = 8'b1111_1111;
            endcase
            if(q==2'b10) dp=0;
        end

endmodule