
module vendingMachine(clk, reset, serialIn, enable, buy, product, digit1, digit0);
	input clk, reset;
	input serialIn;
	input enable;
	input buy;
	input [1:0] product;
	output [6:0] digit1, digit0;

	wire penny, nickel, dime, quarter;
	wire apple, banana, carrot, date, error;
	wire [7:0] credit;

	coinSensor sensor(clk, reset, serialIn, enable, penny, nickel, dime, quarter);
	piggyBank bank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	purchaseManager purchaser(clk, reset, buy, product, credit, apple, banana, carrot, date, error);
	sevenSegDispMngr displayer(clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);

endmodule
