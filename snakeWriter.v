module snakeWriter (clk, writeSnake, snake_in, x_loc, y_loc, data_out);
	input clk, writeSnake;
	input [1799:0] snake_in;
	
	output reg [3:0] x_loc;
	output reg [3:0] y_loc;
	output[1:0] data_out;
	integer i;
	reg [7:0] snake_part;
	reg [10:0] count;
	reg [10:0] temp_count;
	reg [3:0] x_temp, y_temp;
	
	initial begin
		count <= 0;
		//temp_count =0;
	end
	
	assign data_out = 2'b10; //snake
	
	// readSnake = 1, read
	// readSnake = 0, write
	
	always@(posedge clk)
	begin
	    if(writeSnake) begin // write

				if (count == 16) begin//if ((x_temp == 4'd0) || (y_temp == 4'd0)) begin
					count <= 0;
				end
				
				else begin
					count <= count + 8;
					//temp_count = count -1;
					
				end
		
				snake_part <= snake_in[count +: 8];
                //x_loc <= snake_in[i+3 -: 3];
            y_loc <= snake_part[7 : 4];	
				x_loc <= snake_part[3 : 0];	
    	    //end
    	end
    end
endmodule