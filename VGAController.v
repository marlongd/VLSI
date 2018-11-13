`timescale 1ns / 1ps

module VGAController(clk, vga_clk, RED, GREEN, BLUE, hsync, vsync);

	 input clk;
	 output wire vga_clk;
	 output reg [7:0] RED;
	 output reg [7:0] GREEN;
	 output reg [7:0] BLUE;
	 output hsync;
	 output vsync;
	 
	 reg clkcount;          // vga clock is 2 clk cycles
    wire active_video;
    wire [9:0] XCount;
	 wire [8:0] YCount; 


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
	
	always @(posedge vga_clk) // Flash LED every second to verify vga_clk
	begin
	if (active_video)
		begin
			// Make 8x8 grid, each block is 60x60, shave 80 pixels off of each end
			if ((XCount > 80) && (XCount < 560)) 
			begin
				RED[7:0] = 8'b111111111; GREEN[7:0] = 8'b11111111; BLUE[7:0] = 8'b11111111;
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
		


endmodule
