`timescale 1ns / 1ps
module snake_top_tb(vga_clk, RED, GREEN, BLUE, hsync, vsync, up_button,
						down_button, left_button, right_button, LED0, LED1, LED2, LED3);
		
		reg clk, reset;
		input up_button, down_button, left_button, right_button;
		output wire [7:0] RED, GREEN, BLUE;
		output wire hsync, vsync, vga_clk;
		wire [1:0] data;
		wire [3:0] XLocation, YLocation;
		wire [1:0] snake_data;
		wire write_enable;
		wire [79:0] snake;
		wire [3:0] x_loc_sw, y_loc_sw;
		reg slow_clk;
		reg [6:0] clk_counter;
		wire [10:0] index;
		wire [3:0] xfood, yfood;
		
		// LED for testing, remove later
		output wire LED0, LED1, LED2, LED3;
		
		// Push buttons are inverted
		assign LED0 = !right_button;
		assign LED1 = !down_button;
		assign LED2 = !up_button;
		assign LED3 = !left_button;

	initial begin
		clk_counter = 0;
		slow_clk = 0;
		reset = 1'b1;
		clk = 1'b0;
		#10
		clk = 1'b1;
		#10
		clk = 1'b0;
		slow_clk = 1;
		#10	
		reset = 1'b0;
	end
	
	always @(posedge clk) begin
		clk_counter = clk_counter + 1;
		if (clk_counter == 7'b1111111) begin
			slow_clk = !slow_clk;
			reset = 0;
			end
		
	end
	
	always begin
		#20 clk = !clk; // 40 ns period, 25 MHz clk
	 end
		
		
		memory mem(.clk(clk), .data_in(snake_data), .x_loc_vga(XLocation), .y_loc_vga(YLocation), 
			.x_loc_sw(x_loc_sw), .y_loc_sw(y_loc_sw), .writeEnable(1'b1), .data_out(data), 
			.rst(reset), .sw_reset(1'b0));
		
		VGAController vga_c(.clk(clk), .reset(reset), .data(data), .XLocation(XLocation),
			.YLocation(YLocation), .vga_clk(vga_clk), .RED(RED), .GREEN(GREEN), .BLUE(BLUE), 
			.hsync(hsync), .vsync(vsync));
			
		snakeWriter sw(.clk(clk), .writeSnake(1'b1), .snake_in(snake), .x_loc(x_loc_sw), 
			.y_loc(y_loc_sw), .data_out(snake_data), .reset(reset), .index(index),
			.xfood(xfood), .yfood(yfood));
		
		Snake s(.slw_clk(slow_clk), .reset(reset), .right(!right_button), .left(!left_button), 
			.up(!up_button), .down(!down_button), .snake(snake), .write_snake(swrite), .index(index),
			.xfood(xfood), .yfood(yfood));
			
			

endmodule