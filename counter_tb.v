
module counter_tb();

reg clk, reset;
wire [3:0] countB, countS, countM;
wire miterOut;

    counter_B cb(clk, reset, countB);
    counter_S cs(clk, reset, countS);

    assign countM = countB ^ countS;
    or(miterOut, countM[3], countM[2], countM[1], countM[0]);


always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #7.5
    reset = 0;

    #150
    reset = 1;

end
endmodule
