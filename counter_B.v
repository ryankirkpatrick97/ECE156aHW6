
module counter_B(clk, reset, count);
    input clk, reset;
    output reg [3:0] count;

    always @ (posedge clk, posedge reset) begin
        if (reset)begin
            count <= 0;
        end else begin
            if (count < 10) begin
                count <= count + 1;
            end else begin
                count <= 0;
            end
        end
    end

endmodule
