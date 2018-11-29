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
reg [3:0] state, next_state;
reg [3:0] xfood; //x pixel
reg [3:0] yfood; //y pixel
reg[2:0] direction;
 //snake locations the tail will be stored up front.
reg[10:0] index;
reg[7:0] new_head;
parameter RESET  = 3'd0; // 0000 - no button pushed
parameter S_UP    = 3'd1; // 0001 - the first button pushed
parameter S_DOWN  = 3'd2; 
parameter S_LEFT  = 3'd3; // 0100 - and so on
parameter S_RIGHT = 3'd4; 
 

always@(posedge slw_clk)
begin
	if(reset)begin 
		state <= 3'd0; //RESET
		snake = 1800'd0;
	end
	
	else begin
		if (state == RESET) begin
			state <= 3'd4; // Move right
			direction= 3'd4; 
			xfood = 4'd3;
			yfood = 4'd3;//in the memory
			snake = {1775'd0, 4'd1, 4'd3, 4'd1, 4'd2, 4'd1, 4'd1};
			index =11'd23;
			new_head =0; //right
		end
		
		else state <= next_state;
	end
	
						//direction= 3'd4; 
						//xfood = 4'd3;
						//yfood = 4'd3;//in the memory
						//snake = {1775'd0, 4'd1, 4'd3, 4'd1, 4'd2, 4'd1, 4'd1};
						//index =11'd23;
						//new_head =0; //right
						
	//else state <= next_state;
	new_head = snake[index -:8];
	case(state)
	RESET: begin
		snake = 1800'd0;
		new_head = 0;
	end
	S_UP:		begin
	if(direction != S_DOWN) begin

	//move up
	//new_head = snake[index -:8];
	new_head = {new_head[7:4]-1'b1, new_head[3:0]};	
	direction = S_UP;
	
	end
	else new_head ={new_head[7:4]+1'b1, new_head[3:0]};	
	end
	S_DOWN:	begin
	if(direction != S_UP) begin
	//move up
	//new_head = snake[index -:8];
	new_head = {new_head[7:4]+1'b1, new_head[3:0]};
	//snake = snake >> 8; 
	//snake[index-7 +:8] = new_head; ///****************
	direction = S_DOWN;
	end
	
	else new_head ={new_head[7:4]-1'b1, new_head[3:0]};	
	end 
	S_LEFT:  begin
	if(direction != S_RIGHT) begin
	//move up
	
	new_head = {new_head[7:4], new_head[3:0]-1'b1};
	//snake = snake >> 8; 
	//snake[index-7 +:8] = new_head; ///****************
	direction = S_LEFT;
	end
	else new_head ={new_head[7:4], new_head[3:0]+1'b1};	
	end 
	S_RIGHT: begin
	if(direction != S_LEFT) begin
	//move up
	//new_head = snake[index -:8];
	new_head = {new_head[7:4], new_head[3:0]+1'b1};
	//snake = snake >> 8; 
	//snake[index-7 +:8] = new_head; ///****************
	direction = S_RIGHT;
	end
	else new_head ={new_head[7:4], new_head[3:0]-1'b1};
	end
	default: begin
	
	 
	end
	endcase
	
	snake = snake >> 8; 
	snake[index-7 +:8] = new_head; ///****************
	
end
always @*
begin
if(reset) next_state =3'd4;
else if(up) next_state = S_UP;

else if(down) next_state = S_DOWN;

else if(left) next_state = S_LEFT;

else if(right) next_state = S_RIGHT;

else next_state = next_state;


end
endmodule 