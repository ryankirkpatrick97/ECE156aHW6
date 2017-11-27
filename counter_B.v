
module counter_B(input clk, reset, output reg [3:0] count);

    reg logic1, logic2;

    always @(posedge clk, posedge reset) begin
        logic1 = reset | (count == 10);
        logic2 = (count <= 10);
        if(logic1) count = 0;
        else if (logic2) begin
            count = count + 1;
        end//counting
    end//always

endmodule
