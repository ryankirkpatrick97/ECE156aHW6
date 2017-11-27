
module segment_decoder_7bit(count, a, b, c, d, e, f, g);
	input [3:0] count;
	output a, b, c, d, e, f, g;
	reg a, b, c, d, e, f, g;


	always@*
	begin
		case(count)
		//Hex  : {outputs}       = 7'babc_defg
			4'h0 : {a,b,c,d,e,f,g} = 7'b000_0001;//0 h01
			4'h1 : {a,b,c,d,e,f,g} = 7'b100_1111;//1 h4f
			4'h2 : {a,b,c,d,e,f,g} = 7'b001_0010;//2 h12
			4'h3 : {a,b,c,d,e,f,g} = 7'b000_0110;//3 h06
			4'h4 : {a,b,c,d,e,f,g} = 7'b100_1100;//4 h4c
			4'h5 : {a,b,c,d,e,f,g} = 7'b010_0100;//5 h24
			4'h6 : {a,b,c,d,e,f,g} = 7'b010_0000;//6 h20
			4'h7 : {a,b,c,d,e,f,g} = 7'b000_1111;//7 h0f
			4'h8 : {a,b,c,d,e,f,g} = 7'b000_0000;//8 h00
			4'h9 : {a,b,c,d,e,f,g} = 7'b000_0100;//9 h04
			4'ha : {a,b,c,d,e,f,g} = 7'b000_1000;//a h08
			4'hb : {a,b,c,d,e,f,g} = 7'b110_0000;//b h60
			4'hc : {a,b,c,d,e,f,g} = 7'b011_0001;//c h31
			4'hd : {a,b,c,d,e,f,g} = 7'b100_0010;//d h42
			4'he : {a,b,c,d,e,f,g} = 7'b011_0000;//e h30
			4'hf : {a,b,c,d,e,f,g} = 7'b011_1000;//f h38
		endcase
	end

endmodule

