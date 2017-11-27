
class rand_input;
    //Coins
    rand bit [10] coin;
    constraint coinc{
        coin dist{
        745, 755 := 2, //penny
        830, 840 := 2, //nickel
        700, 710 := 2, //dime
        950, 960 := 2, //quarter
        123, 216 := 2 //noncoin
    };
    }
    //Other Variables
    rand bit [2] product;
    constraint productc{
        product dist{
        0 := 25,
        1 := 25,
        2 := 25,
        3 := 25
    };
    }

    rand bit reset;
    constraint rc{ reset dist{0 :=95, 1:= 5};}

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
    PENNY: coverpoint vendingMachine.piggyBank.penny{
        bins zero = {0};
        bins one = {1};
    }
    NICKEL: coverpoint vendingMachine.piggyBank.nickel{
        bins zero = {0};
        bins one = {1};
    }
    DIME: coverpoint vendingMachine.piggyBank.dime{
        bins zero = {0};
        bins one = {1};
    }
    QUARTER: coverpoint vendingMachine.piggyBank.quarter{
        bins zero = {0};
        bins one = {1};
    }
    APPLE: coverpoint vendingMachine.piggyBank.apple{
        bins zero = {0};
        bins one = {1};
    }
    APPLE: coverpoint vendingMachine.piggyBank.apple{
        bins zero = {0};
        bins one = {1};
    }
    BANANA: coverpoint vendingMachine.piggyBank.banana{
        bins zero = {0};
        bins one = {1};
    }
    CARROT: coverpoint vendingMachine.piggyBank.carrot{
        bins zero = {0};
        bins one = {1};
    }
    DATE: coverpoint vendingMachine.piggyBank.date{
        bins zero = {0};
        bins one = {1};
    }
    ERROR: coverpoint vendingMachine.piggyBank.error{
        bins zero = {0};
        bins one = {1};
    }

    CREDIT: coverpoint vendingMachine.piggyBank.credit{
        bins range1 = {0,4};
        bins range2 = {5,9};
        bins range3 = {10,24};
        bins range4 = {25,39};
        bins range5 = {40,59};
        bins range6 = {50,74};
        bins range7 = {75,255};
    }

    CROSS_APPLE_ERROR: cross APPLE, ERROR;
    CROSS_BANANA_ERROR: cross BANANA, ERROR;
    CROSS_CARROT_ERROR: cross CARROT, ERROR;
    CROSS_DATE_ERROR: cross DATE, ERROR;
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
        end//end for

        #40
        buy = 1;
        #10
        buy = 0;
    end //forever
end



endmodule
