
module counter_B(input clk, reset, output reg [3:0] count);

    wire first_logical, second_logical;
    assign first_logical = reset | (count == 10);
    assign second_logical = (count <= 10);

    always @(posedge clk, posedge reset) begin
        if(first_logical) count <= 0;
        else if (second_logical) begin
            count <= count + 1;
        end//counting
    end//always

endmodule
