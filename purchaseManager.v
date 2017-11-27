
module purchaseManager(clk, reset, buy, product, credit, apple, banana, carrot, date, error);
	input clk, reset;
	input buy;
	input [1:0] product;
	input [7:0] credit;
	output reg apple, banana, carrot, date, error;


	always @ (posedge clk) begin
			apple = 0;
			banana = 0;
			carrot = 0;
			date = 0;
			error = 0;
		if( reset == 0 & buy == 1) begin
			case(product)
				0: begin
						if(credit >= 75) apple = 1;
					 	else error = 1;
					 end
				1: begin
						if(credit >= 20) banana = 1;
					 	else error = 1;
					 end
				2: begin
						if(credit >= 30) carrot = 1;
					 	else error = 1;
					 end
				3: begin
						if(credit >= 40) date = 1;
					 	else error = 1;
					 end
			endcase
		end //if
	end //always

endmodule
