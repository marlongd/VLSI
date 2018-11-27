module Snake(
input slw_clk,
input reset,
input right,
input left,
input up,
input down,
output reg[1799:0] snake
);
 
 //00 up
 //01 down
 //10 left
 //11 right
 //left -
 //up -
 //rigth +
 // down +
parameter [1:0] s0 = 2'b00,
s1 = 2'b01,s2 = 2'b10, s3 = 2'b11;

reg [2:0] state, next_state;reg [3:0] xhead; //x pixel
reg [3:0] yhead; //y pixel
reg [3:0] xtail; //x pixel
reg [3:0] ytail; //y pixel
reg [3:0] xfood; //x pixel
reg [3:0] yfood; //y pixel
reg[2:0] direction;
 //snake locations the tail will be stored up front.
reg[10:0] index;
reg[7:0] new_head;
parameter S_IDLE  = 3'd0; // 0000 - no button pushed
parameter S_UP    = 3'd1; // 0001 - the first button pushed
parameter S_DOWN  = 3'd2; // 0010 - the second button pushed
parameter S_LEFT  = 3'd3; // 0100 - and so on
parameter S_RIGHT = 3'd4; // 1000 - and so on
 


always@(posedge slw_clk)
begin
	if(reset)begin state = 3'd4; 
						direction= 3'd4; 
						xhead = 4'd2;
						yhead = 4'd1;
						xfood = 4'd3;//in
						yfood = 4'd3;//in the memory
						snake ={1776'd0,  4'd1, 4'd3, 4'd1, 4'd2,4'd1, 4'd1};
						index =11'd23;
						new_head =0;
						end
	else //state = next_state;
	
	
	case(state)
	S_UP:		begin
	if(direction != S_DOWN) begin
	//move up
	
	
	end
	end
	S_DOWN:	begin
	
	end 
	S_LEFT:  begin
	
	end 
	S_RIGHT: begin
	if(direction != S_LEFT) begin
	//move up
	new_head = snake[index -:8];
	new_head = {new_head[7:4], new_head[3:0]+1'b1};
	snake = snake >> 8; 
	snake[index-7 +:8] = new_head; ///****************
	//direction = S_LEFT;
	end
	end
	default: begin
	
	 
	end
	endcase
end
always @*
begin

begin 
//send into state of growth.
end


end
endmodule 