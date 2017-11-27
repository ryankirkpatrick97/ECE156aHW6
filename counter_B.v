
module counter_B(input clk, reset, output reg [3:0] count);

    reg first_logical, second_logical;

    always @(posedge clk, posedge reset) begin
        first_logical = reset | (count == 10);
        second_logical = (count <= 10);

        if(first_logical) count <= 0;
        else if (second_logical) begin
            count <= count + 1;
        end//counting
    end//always

endmodule
