
module counter_B(clk, reset, count);
    input clk, reset;
    output reg [3:0] count;

    always @ (posedge clk)
    begin
        if (reset)begin
            count <= 4'h0;
        end else begin
            if (count < 4'ha) begin
                count <= count + 1;
            end else begin
                count <= 4'h0;
            end
        end
    end

endmodule
