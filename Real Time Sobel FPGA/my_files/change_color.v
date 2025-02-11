module change_color( switch, red, green, blue, grey, sobel, red_out, green_out, blue_out);

input		[1:0]	switch;
input		[9:0]	red, green ,blue, grey, sobel;		// 8 bit pixels inputs 
output 		[9:0]	red_out, green_out, blue_out;		// 8 bit output pixel 

assign red_out = (switch == 2'b00 ? red : (
					switch == 2'b01 ? grey : (
					switch == 2'b10 ? sobel : 10'd0)));
					
assign green_out = (switch == 2'b00 ? green : (
					switch == 2'b01 ? grey : (
					switch == 2'b10 ? sobel : 10'd0)));

assign blue_out = (switch == 2'b00 ? blue : (
					switch == 2'b01 ? grey : (
					switch == 2'b10 ? sobel : 10'd0)));

/*
always@(posedge CLK)
begin
	if(switch == 2'b00)
		begin
			assign red_out		=	red;
			assign green_out	=	green;
			assign blue_out		=	blue;
		end
	else if(switch == 2'b01)
		begin
			assign red_out		=	grey;
			assign green_out	=	grey;
			assign blue_out		=	grey;
		end
	else if(switch == 2'b10)
		begin
			assign red_out		=	sobel;
			assign green_out	=	sobel;
			assign blue_out		=	sobel;
		end
end
*/

endmodule