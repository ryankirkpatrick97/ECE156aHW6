
module sevenSegDispMngr(clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);
	input clk, reset;
	input apple, banana, carrot, date, error;
	input [7:0] credit;
	output [6:0] digit1, digit0;

	reg [3:0] count1, count0;
	reg [7:0] itemReg;
	reg [2:0] counter;

	segment_decoder_7bit decoder1(count1[3:0], digit1[6], digit1[5], digit1[4], digit1[3], digit1[2], digit1[1], digit1[0]);
	segment_decoder_7bit decoder0(count0[3:0], digit0[6], digit0[5], digit0[4], digit0[3], digit0[2], digit0[1], digit0[0]);

	always @ (posedge clk) begin
		count1 = 0;
		count0 = 0;

		if(reset == 0) begin

			if(apple == 1) begin
				itemReg = 8'hAA;
				counter = 6;
			end else if(banana == 1) begin
				itemReg = 8'hBB;
				counter = 6;
			end else if(carrot == 1) begin
				itemReg = 8'hCC;
				counter = 6;
			end else if(date == 1) begin
				itemReg = 8'hDD;
				counter = 6;
			end else if(error == 1) begin
				itemReg = 8'hEE;
				counter = 6;
			end //End item input

			if(counter > 0) begin
				counter = counter - 1;
				count1 = itemReg[7:4];
				count0 = itemReg[3:0];
			end else begin
				count1 = credit[7:4];
				count0 = credit[3:0];
			end // End putting data in counts

		end//reset if
	end //always




endmodule
