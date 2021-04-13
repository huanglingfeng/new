module clock_div(
    input logic clk_sys,
    output logic clk,
    output logic clk_8
);
    
    logic[25:0] div_counter = 0; 

    logic [31:0] div_counter_8=0; 
    
    initial begin
    clk=0;
    clk_8=0;
    end
    
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

