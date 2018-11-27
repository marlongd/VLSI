`timescale 1ns / 1ps

module VGAController(clk, reset, data, XLocation, YLocation, vga_clk, RED, GREEN, 
							BLUE, hsync, vsync);

	 input clk;
	 input reset;
	 input [1:0] data;				// 01 is food, 10 is snake, 00 is world
	 output wire vga_clk;
	 output reg [7:0] RED;
	 output reg [7:0] GREEN;
	 output reg [7:0] BLUE;
	 output wire [4:0] XLocation;
	 output wire [4:0] YLocation;
	 output hsync;
	 output vsync;
	 reg clkcount;          // vga clock is 2 clk cycles
    wire active_video;
    wire [9:0] XCount;
	 wire [8:0] YCount;
	
	 
	 //INPUT from memory -> 255 


    VGA vga_module(
      .clk(vga_clk),
      .hsync(hsync),
      .vsync(vsync),
      .HCount(XCount),
      .VCount(YCount),
      .active_video(active_video)
    );
	 
	 always @(posedge clk)
    begin
		clkcount = !clkcount;     		
    end
	 
	// Drive vga_clk using input clk
	assign vga_clk = clkcount;
	
	assign XLocation = ((XCount - 80) / 32) + 1;
	assign YLocation = (YCount / 32) + 1;

	always @(posedge vga_clk) // Flash LED every second to verify vga_clk
	begin
	if (active_video)
		begin
			// 15x15 grid, 32x32 pixel squares shave 80 pixels off of each end
			if ((XCount > 80) && (XCount < 560)) // Bright area
			begin			
		
				if (data == 2'b00)       // World is blue
				begin
					RED[7:0] = 8'd0; GREEN[7:0] = 8'd0; BLUE[7:0] = 8'b11111111;
				end
				
				else if (data == 2'b01)  // Food is red
				begin
					RED[7:0] = 8'b11111111; GREEN[7:0] = 8'd0; BLUE[7:0] = 8'd0;
				end
				
				else if (data == 2'b10)  // Snake is green
				begin
					RED[7:0] = 8'd0; GREEN[7:0] = 8'b11111111; BLUE[7:0] = 8'd0;
				end
				
				else
				begin
					RED[7:0] = 8'b111111111; GREEN[7:0] = 8'b00000000; BLUE[7:0] = 8'b00000000;
				end
				
				
			end
			else begin
				RED[7:0] = 8'd0; GREEN[7:0] = 8'd0; BLUE[7:0] = 8'd0;
			end
		end
      else 
		begin
			RED[7:0] = 8'd0; GREEN[7:0] = 8'd0; BLUE[7:0] = 8'd0;	
		end
	
	end
	
	//memory mem(.clk(clk), .data_in(2'b00), .x_loc(XLocation), .y_loc(YLocation), .readEnable(1'b1), 
		//.data_out(data), .rst(!reset));


endmodule
