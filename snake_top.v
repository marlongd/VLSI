module snake_top(clk, reset, vga_clk, RED, GREEN, BLUE, hsync, vsync, up_button,
						down_button, left_button, right_button);
		
		input clk, reset, up_button, down_button, left_button, right_button;
		reg slow_clk;
		output wire [7:0] RED, GREEN, BLUE;
		output wire hsync, vsync, vga_clk;
		wire [1:0] data;
		wire [3:0] XLocation, YLocation;
		wire [1:0] snake_data;
		wire write_enable;
		wire [79:0] snake;
		wire [3:0] x_loc_sw, y_loc_sw;
		reg [21:0] clk_counter;
		reg snake_reset;
		wire swrite;
		wire [10:0] index;
		wire [3:0]xfood, yfood;
		
		
		always @(posedge clk) begin
			if (reset) begin
				clk_counter = 0;
				slow_clk = 0;
			end
		
			clk_counter = clk_counter + 1;
			if (clk_counter == 22'b1111111111111111111110) begin
				snake_reset = 1;
			end
			else begin
				snake_reset = 0;
			end
		
			if (clk_counter == 22'b1111111111111111111111) begin
				slow_clk = !slow_clk;
			end
		
		end
		
		memory mem(.clk(clk), .data_in(snake_data), .x_loc_vga(XLocation), .y_loc_vga(YLocation), 
			.x_loc_sw(x_loc_sw), .y_loc_sw(y_loc_sw), .writeEnable(swrite), .data_out(data), 
			.rst(reset), .sw_reset(snake_reset));
		
		VGAController vga_c(.clk(clk), .reset(reset), .data(data), .XLocation(XLocation),
			.YLocation(YLocation), .vga_clk(vga_clk), .RED(RED), .GREEN(GREEN), .BLUE(BLUE), 
			.hsync(hsync), .vsync(vsync));
			
		snakeWriter sw(.clk(clk), .writeSnake(swrite), .snake_in(snake), .x_loc(x_loc_sw), 
			.y_loc(y_loc_sw), .data_out(snake_data), .reset(reset), .index(index),
			.xfood(xfood), .yfood(yfood));
		
		Snake s(.slw_clk(slow_clk), .reset(reset), .right(!right_button), .left(!left_button), 
			.up(!up_button), .down(!down_button), .snake(snake), .write_snake(swrite), .index(index),
			.xfood(xfood), .yfood(yfood));

endmodule