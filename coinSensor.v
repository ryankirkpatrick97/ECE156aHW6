
module coinSensor(clk, reset, serialIn, write, penny, nickle, dime, quarter);
	input clk, reset, serialIn, write;
	output reg penny, nickle, dime, quarter;

	reg [9:0] currentCoin;
	reg previousWrite;

	//every clock edge when write is high, read in new signal
	//also set outputs to low at these times
	//when write is low, find coin size 

	always @ (posedge clk) begin
			penny   = 0;
			nickle  = 0;
			dime    = 0;
			quarter = 0;
		if (reset == 1) begin
			currentCoin = 0;
			previousWrite = 0;
			
		end //reset high
		else if (reset == 0 && write == 1) begin
			//shift register to add onto currentCoin
			currentCoin = currentCoin >> 1;
			currentCoin[9] = serialIn;

			//set previousWrite
			previousWrite = 1;
		end // write high
		else if(reset == 0 && write == 0 && previousWrite == 1) begin
			senseCoin(currentCoin, penny, nickle, dime, quarter);
			previousWrite = 0;
		end
	end//always


 	task senseCoin;
		input [9:0] currentCoin;
		output penny, nickle, dime, quarter;

		localparam pennyUp = 10'b10_1111_0011, pennyLow = 10'b10_1110_1001,
							 nickleUp = 10'b11_0100_1000, nickleLow = 10'b11_0011_1110,
							 dimeUp = 10'b10_1100_0110, dimeLow = 10'b10_1011_1100,
							 quarterUp = 10'b11_1100_0000, quarterLow = 10'b11_1011_0110;
		begin
		penny = 0;
		nickle = 0;
		dime  = 0;
		quarter = 0;
		if      (currentCoin <= pennyUp && currentCoin >= pennyLow)
			penny = 1;
		else if (currentCoin <= nickleUp && currentCoin >= nickleLow)
			nickle = 1;
		else if (currentCoin <= dimeUp && currentCoin >= dimeLow)
			dime = 1;
		else if (currentCoin <= quarterUp && currentCoin >= quarterLow)
			quarter = 1;
		end // senseCoin
	endtask

endmodule
