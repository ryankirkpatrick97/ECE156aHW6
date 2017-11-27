
module piggyBank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	input clk, reset;
	input penny, nickel, dime, quarter;
	input apple, banana, carrot, date;
	output reg [7:0] credit;


	always @ (posedge clk) begin
		if(reset == 1) begin
			credit = 0;
		end else begin
			if(penny == 1) begin
				if (credit > 254)
					credit <= 255;
				else
					credit = credit + 1;
			end //penny
		
			if(nickel == 1) begin
				if (credit > 250)
					credit <= 255;
				else
					credit <= credit + 5;
			end //nickel

			if(dime == 1) begin
				if (credit > 245)
					credit <= 255;
				else
					credit <= credit + 10;
			end //dime
	
			if(quarter == 1) begin
				if (credit > 230)
					credit <= 255;
				else
					credit <= credit + 25;
			end //quarter
	
			if(apple == 1) begin
					credit <= credit - 75;
			end //apple
	
			if(banana == 1) begin
				credit <= credit - 20;
			end //banana
	
			if(carrot == 1) begin
					credit <= credit - 30;
			end //carrot

			if(date == 1) begin
					credit <= credit - 40;
			end //date
		end //else
	end//always

endmodule
