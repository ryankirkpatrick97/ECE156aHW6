
module vendingMachine_ogtb();
	reg clk, reset;
	reg serialIn;
	reg enable;
	reg buy;
	reg [1:0] product;
	wire [6:0] digit1, digit0;
	integer i;

	vendingMachine UUT(clk, reset, serialIn, enable, buy, product, digit1, digit0);

	reg [11:0] pennyIn = 12'b10_1111_0000_00;
	reg [11:0] nickelIn = 12'b11_0100_0000_00;
	reg [11:0] dimeIn = 12'b10_1100_0000_00;
	reg [11:0] quarterIn = 12'b11_1011_1100_00;
	//should activate on 4, and 11 [11:0]

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

	initial begin
		vendcovergroup vcg;
		vcg = new();

		clk = 0;
		reset = 1;
		serialIn = 0;
		enable = 1;
		buy = 0;
		product = 0;

		#7.5
		reset = 0;

		for( i = 0; i <=48; i= i +1) begin
			#10
			//Handle specific inputs for different coin types
			if      (i >= 0 && i <= 11)
				serialIn = pennyIn[i];
			else if (i >= 12 && i <= 23)
				serialIn = nickelIn[i-12];
			else if (i >= 24 && i <= 35)
				serialIn = dimeIn[i-24];
			else if (i >= 36)
				serialIn = quarterIn[i%12];
	
			//Every twelve, drop write to cause update
			if( (i % 12) == 0)
				enable = 0;
			if( (i % 12) == 1)
				enable = 1;
		end//end for

		#40
		buy = 1;
		#10
		buy = 0;
		enable = 1;
		for(i=48; i <=168; i = i + 1) begin
			#10
			serialIn = quarterIn[i%12];	
			//Every twelve, drop write to cause update
			if( (i % 12) == 0)
				enable = 0;
			if( (i % 12) == 1)
				enable = 1;
		end //for

		#40
		buy=1;
		#10
		buy =0;
		#40
		buy =1;
		product = 1;
		#10
		buy =0;
		#40
		buy =1;
		product = 2;
		#10
		buy =0;
		#40
		buy =1;
		product = 3;
		#10
		buy =0;
		

	end//initial

	


endmodule
