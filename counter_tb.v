
module counter_tb();

reg clk, reset;
wire [3:0] count;

    counter_B cb(clk, reset, count);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #7.5
    reset = 0;

    #120
    reset = 1;

end
endmodule
