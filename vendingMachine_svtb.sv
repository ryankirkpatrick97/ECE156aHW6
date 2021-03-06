
class rand_input;
    //Coins
    rand bit [9:0] coin;
    constraint coinc{
        coin dist{
        [745: 755] := 25, //penny
        [830: 840] := 25, //nickel
        [700: 710] := 25, //dime
        [950: 960] := 24, //quarter
        [123: 216] := 01 //noncoin
    };
    }
    //Other Variables
    rand bit [1:0] product;
    constraint productc{
        product dist{
        2'b00 := 25,
        2'b01 := 25,
        2'b10 := 25,
        2'b11 := 25
    };
    }

    rand bit reset;
    constraint rc{ reset dist{0 :=99, 1:= 01};}

endclass

module vendingMachine_svtb();
    reg clk, reset;
    reg serialIn;
    reg enable;
    reg buy;
    reg [1:0] product;
    wire [6:0] digit1, digit0;

vendingMachine UUT(clk, reset, serialIn, enable, buy, product, digit1, digit0);

covergroup vendcovergroup @(clk);
    PENNY: coverpoint UUT.penny{
        bins zero = {0};
        bins one = {1};
    }
    NICKEL: coverpoint UUT.nickel{
        bins zero = {0};
        bins one = {1};
    }
    DIME: coverpoint UUT.dime{
        bins zero = {0};
        bins one = {1};
    }
    QUARTER: coverpoint UUT.quarter{
        bins zero = {0};
        bins one = {1};
    }
    PRODUCT: coverpoint product{
	bins apple_attempt = {0} iff(buy == 1);
	bins banana_attempt = {1} iff(buy == 1);
	bins carrot_attempt = {2} iff(buy == 1);
	bins date_attempt = {3} iff(buy == 1);
    }
    ERROR: coverpoint UUT.error{
        bins zero = {0} iff(buy ==1);
        bins one = {1} iff(buy ==1);
    }

    CREDIT: coverpoint UUT.credit{
        bins range1 = {0,4};
        bins range2 = {5,9};
        bins range3 = {10,24};
        bins range4 = {25,39};
        bins range5 = {40,59};
        bins range6 = {60,74};
        bins range7 = {75,255};
    }

    CROSS_PRODUCT_ERROR: cross PRODUCT, ERROR;
   
endgroup


always #5 clk = ~clk;
integer i;

initial begin
    //Object instantiation
    rand_input ri;
    vendcovergroup vcg;
    ri = new();
    vcg = new();

    //Test setup
    clk = 0;
    reset = 1;
    serialIn = 0;
    buy = 0;
    #7.5
    reset = 0;

    forever begin
        assert(ri.randomize())
        product <= ri.product;
        reset <= ri.reset;
        enable <= 1;
	
        for( i = 0; i <= 10; i= i +1) begin
            #10
            //Handle specific inputs for different coin types
            if      (i >= 0 && i <= 9)
                serialIn = ri.coin[i];
            //Every tenth, drop write to cause update
            if( (i % 10) == 0)
                enable <= 0;
            if( (i % 10) == 1)
                enable <= 1;
        end//end for

        #40
        buy = 1;
        #15
        buy = 0;
    end //forever
end



endmodule
