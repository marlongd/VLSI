

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
		
			clk_counter = clk_counter + 22'd1;
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

//--------------
// Design Name: memory
// Function: synchronous RAM
// Author: Douglas Karmondy
//-----------------

module memory(clk, data_in, x_loc_vga, y_loc_vga, x_loc_sw, y_loc_sw, writeEnable, 
					data_out, rst, sw_reset);
	input clk, rst;
	input writeEnable; //0 write, 1 read
	input  [1:0] data_in;
	input sw_reset;
	input [3:0] x_loc_vga, y_loc_vga, x_loc_sw, y_loc_sw;
	output reg [1:0] data_out;
	
	integer i;
	reg [1:0] data;
	reg [1:0] world_memory [255:0]; //15 X 15 = 225 //16X16 256
	
	reg output_bit; //225 grid of on and off
	
	
	// Keep track of food
	// 00 - world
	// 01 - food
	// 10 - snake
	// 11
	
	// food is initially at (3,3)
	// snake is 3 blocks initially
	
	
	always @(posedge clk)
	begin
	    if(rst || sw_reset)begin
			for(i=0; i<255; i= i+1)begin
				world_memory[i] <= 2'b00;    // world populated
			end
		
		end

		if(writeEnable) world_memory[15 * (y_loc_sw) + x_loc_sw]<= data_in;
	end
	
	always @*
	begin
			data_out = world_memory[(15 *y_loc_vga) + x_loc_vga];
	end
	
	 
endmodule

module Snake(
input slw_clk,
input reset,
input right,
input left,
input up,
input down,
output reg[79:0] snake,
output reg write_snake,
output reg [10:0] index,
output reg [3:0] xfood, //x pixel
output reg [3:0] yfood //y pixel
);
 

	reg [3:0] state, next_state;


	reg[2:0] direction;
	 //snake locations the tail will be stored up front.
	reg[7:0] new_head;
	
	reg [3:0] x_rando_count, y_rando_count;


	parameter RESET   = 3'd0;
	parameter S_UP    = 3'd1; 
	parameter S_DOWN  = 3'd2; 
	parameter S_LEFT  = 3'd3; 
	parameter S_RIGHT = 3'd4; 
	parameter EAT     = 3'd5;
	parameter DIE     = 3'd6;
	 

	always@(posedge slw_clk)
	begin
		if(reset)begin 
			state <= 3'd0; //RESET
			snake = 80'd0;
			write_snake <=0;
			x_rando_count <= 0;
			y_rando_count <= 0;
		end
		
		else begin
			if (state == RESET) begin
				state <= 3'd4; // Move right
				direction= 3'd4; 
				xfood = 4'd3;
				yfood = 4'd3;//in the memory
				snake = {56'd0, 4'd1, 4'd3, 4'd1, 4'd2, 4'd1, 4'd1};
				index =11'd23;
				new_head =0; //right
			end
			
			else begin state <= next_state;
							write_snake <=1;
				x_rando_count <= x_rando_count +1;
				if (x_rando_count == 4'b1111) y_rando_count <= y_rando_count + 1;
			end 
		end

							
		new_head = snake[index -:8];
		
		
		case(state)
		
			RESET: begin
				snake = 80'd0;
				new_head = 0;
			end
			S_UP:		begin
				if(direction != S_DOWN) begin

				new_head = {new_head[7:4]-1'b1, new_head[3:0]};	
				direction = S_UP;
				
				end
				else new_head ={new_head[7:4]+1'b1, new_head[3:0]};	
			end
			
			S_DOWN:	begin
				if(direction != S_UP) begin
				new_head = {new_head[7:4]+1'b1, new_head[3:0]};
				direction = S_DOWN;
				end
				
				else new_head ={new_head[7:4]-1'b1, new_head[3:0]};		
			end 
			
			S_LEFT:  begin
				if(direction != S_RIGHT) begin
				new_head = {new_head[7:4], new_head[3:0]-1'b1};
				direction = S_LEFT;
				end
				else new_head ={new_head[7:4], new_head[3:0]+1'b1};	
			end 
			
			S_RIGHT: begin
				if(direction != S_LEFT) begin
				new_head = {new_head[7:4], new_head[3:0]+1'b1};
				direction = S_RIGHT;
				end
				else new_head ={new_head[7:4], new_head[3:0]-1'b1};
			end
			
			EAT: begin
				new_head = {yfood, xfood};
				index = index + 8;
				snake = snake << 8;
				xfood = x_rando_count;
				yfood = y_rando_count;
			end
			
			default: begin
			
			 
			end
		endcase
		
		snake = snake >> 8; 
		snake[index-7 +:8] = new_head;
		
	end

	always @*
	begin
		if(reset) next_state = 3'd4;

		else if(snake[index -:4] == yfood && snake[index-4 -: 4] == xfood)
						next_state = EAT;
						
		else if(up) next_state = S_UP;

		else if(down) next_state = S_DOWN;

		else if(left) next_state = S_LEFT;

		else if(right) next_state = S_RIGHT;

		else if (next_state == EAT) next_state = direction;
		
		else next_state = direction;

	end
endmodule 

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

module VGA(clk, hsync, vsync, active_video, HCount, VCount);
  
    input clk;
	 output reg hsync;
	 output reg vsync;
	 output reg active_video;
	 output reg [9:0] HCount;
	 output reg [8:0] VCount;
  
	 // 640x480, 25 MHz clk
	 parameter ACTIVE_H = 640; 		
	 parameter FRONT_PORCH_H = 16;   
	 parameter SYNC_PULSE_H = 96; 	
	 parameter H_TOTAL = 800; 			
	 parameter ACTIVE_V = 480; 		
	 parameter FRONT_PORCH_V = 11;   
	 parameter SYNC_PULSE_V = 2; 		
	 parameter V_TOTAL = 524; 			

    wire HMax = (HCount == H_TOTAL); 
    wire VMax = (VCount == V_TOTAL);

	 
	 initial begin
		HCount = 10'b000000000;
		VCount = 9'b00000000;
	 end

    always @(posedge clk) // Board clk is 50 Mhz, VGA sends signals at 100 Mhz
	 begin
		if (HMax) 
		begin
			HCount = 0;
			if (VMax) begin
				VCount = 0;
			end
			else begin
				VCount = VCount + 9'd1;
			end
		end
		else begin
			HCount = HCount + 10'd1;
		end
		
		
		active_video = (HCount < ACTIVE_H) && (VCount < 600);
		
		
		if ((HCount > (ACTIVE_H + FRONT_PORCH_H)) && (HCount < (ACTIVE_H + FRONT_PORCH_H + SYNC_PULSE_H)))
		begin
			 hsync = 0;
		end
		else
		begin
			hsync = 1;
		end
		
		
		if ((VCount > (ACTIVE_V + FRONT_PORCH_V)) && (VCount < (ACTIVE_V + FRONT_PORCH_V + SYNC_PULSE_V)))
		begin
			vsync = 0;
		end
		else
		begin
			vsync = 1;
		end
    end
endmodule

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
	 output reg [3:0] XLocation;
	 output reg [3:0] YLocation;
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

	always @(posedge vga_clk) // Flash LED every second to verify vga_clk
	begin
	if (active_video)
		begin

			// 15x15 grid, 32x32 pixel squares shave 80 pixels off of each end
			if ((XCount > 80) && (XCount < 560)) // Bright area
			begin	
				XLocation = ((XCount - 80) / 32);// + 1;
				YLocation = (YCount / 32);// + 1; 
		
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
					RED[7:0] = 8'b11111111; GREEN[7:0] = 8'b00000000; BLUE[7:0] = 8'b00000000;
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


endmodule
