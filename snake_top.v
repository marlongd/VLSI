module snake_top(clk, reset, vga_clk, RED, GREEN, BLUE, hsync, vsync, up_button,
						down_button, left_button, right_button, LED0, LED1, LED2, LED3);
		
		input clk, reset, up_button, down_button, left_button, right_button;
		output wire [7:0] RED, GREEN, BLUE;
		output wire hsync, vsync, vga_clk;
		wire [1:0] data;
		wire [4:0] XLocation, YLocation;
		
		// LED for testing, remove later
		output wire LED0, LED1, LED2, LED3;
		
		// Push buttons are inverted
		assign LED0 = !right_button;
		assign LED1 = !down_button;
		assign LED2 = !up_button;
		assign LED3 = !left_button;
		
		memory mem(.clk(clk), .data_in(2'b00), .x_loc(XLocation), .y_loc(YLocation), 
			.readEnable(1'b1), .data_out(data), .rst(reset));
		
		VGAController vga_c(.clk(clk), .reset(reset), .data(data), .XLocation(XLocation),
			.YLocation(YLocation), .vga_clk(vga_clk), .RED(RED), .GREEN(GREEN), .BLUE(BLUE), 
			.hsync(hsync), .vsync(vsync));
						

endmodule
