/* Verilog code to calculate Sobel
 * Free to download modify and use
 * 
 */
module SOBEL( p0, p1, p2, p3, p5, p6, p7, p8, out);

input  [9:0] p0,p1,p2,p3,p5,p6,p7,p8;	// 8 bit pixels inputs 
output [9:0] out;					// 8 bit output pixel 

wire signed [12:0] gx,gy;    //11 bits because max value of gx and gy is  
//255*4 and last bit for sign					 
wire signed [12:0] abs_gx,abs_gy;	//it is used to find the absolute value of gx and gy 
wire [12:0] sum;			//the max value is 255*8. here no sign bit needed. 

assign gx=((p2-p0)+((p5-p3)<<1)+(p8-p6));//sobel mask for gradient in horiz. direction 
assign gy=((p0-p6)+((p1-p7)<<1)+(p2-p8));//sobel mask for gradient in vertical direction 

//assign gx=(-p0 + p2 -(2*p3) +(2*p5) - p6 + p8);//sobel mask for gradient in horiz. direction 
//assign gy=(p0 + (2*p1) + p2 - p6 - (2*p7) - p8);//sobel mask for gradient in vertical direction 

assign abs_gx = (gx[12]? ~gx+1 : gx);	// to find the absolute value of gx. 
assign abs_gy = (gy[12]? ~gy+1 : gy);	// to find the absolute value of gy. 

assign sum = (abs_gx+abs_gy);				// finding the sum 
assign out = (|sum[12:11]) ? 10'b1111111111 : sum[9:0];	// to limit the max value to 255  
//assign out = (|sum[12:11]) ? 10'b1111111111 : 10'b0000000000;	// to limit the max value to 255  
//assign out = (sum > 20 ? 10'b0000000000 : 10'b1111111111);


//assign out = (p0 + p1 + p2 + p3 + p5 + p6 + p7 + p8) / 8;

endmodule