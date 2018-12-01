module snakeWriter (clk, writeSnake, snake_in, x_loc, y_loc, data_out, reset,
							index,xfood,yfood);
							
	input clk, writeSnake;
	input [10:0] index;
	input [79:0] snake_in;
	input reset;
	input [3:0] xfood, yfood;
	output reg [3:0] x_loc;
	output reg [3:0] y_loc;
	output reg[1:0] data_out;
	integer i;
	reg [7:0] snake_part;
	reg [10:0] count;
	reg [10:0] temp_count;
	reg [3:0] x_temp, y_temp;
	
	initial begin
		count <= 0;
	end
	
	
	always@(posedge clk)
	begin
		if(reset) begin
		count <= 0;
		x_loc <=0;
		y_loc <= 0;
		end
	   else if(writeSnake) begin // write

				if (count > index) begin//if ((x_temp == 4'd0) || (y_temp == 4'd0)) begin
					count <= 0;
					x_loc <= xfood;
					y_loc <= yfood;
					data_out <= 2'b01;
				end
				
				else begin
					count <= count + 11'd8;
					 data_out <= 2'b10;
					snake_part <= snake_in[count +: 8];
					y_loc <= snake_part[7 : 4];	
					x_loc <= snake_part[3 : 0];	
					
				end
		

    	end
    end
endmodule