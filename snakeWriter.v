module snakeWriter (clk, readSnake, snake_in, x_loc, y_loc, data_out);
	input clk, readSnake;
	input [1799:0] snake_in;
	
	output reg [3:0] x_loc;
	output reg [3:0] y_loc;
	output[1:0] data_out;
	integer i;
	
	assign data_out = 2'b10; //snake
	
	// readSnake = 1, read
	// readSnake = 0, write
	
	always@(posedge clk)
	begin
	    if(!readSnake) begin // write
		    for (i=0; i<1799; i=i+8) begin
                x_loc <= snake_in[i+3 -: 3];
                y_loc <= snake_in[i+7 -: 3];
    	    end
    	end
    end
endmodule