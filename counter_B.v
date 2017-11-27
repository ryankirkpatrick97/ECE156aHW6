
module counter_B(input clk, reset, output reg [3:0] count);

    always @(posedge clk, posedge reset) begin
        if(reset==1 | count == 10) count = 0;
        else if (count <= 10) begin
            count = count + 1;
        end//counting
    end//always

endmodule
