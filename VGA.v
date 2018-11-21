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
				VCount = VCount + 1;
			end
		end
		else begin
			HCount = HCount + 1;
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

